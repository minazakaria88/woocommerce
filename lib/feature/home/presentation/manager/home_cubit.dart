import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/functions/show_snackbar.dart';
import 'package:khoyout/core/helpers/cache_helper.dart';
import 'package:khoyout/feature/cart/data/models/cart_item_model.dart';
import 'package:khoyout/feature/home/data/models/product_variations.dart';
import 'package:khoyout/feature/home/data/repositories/home_repo.dart';
import 'package:khoyout/feature/home/presentation/widgets/home_screen_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../main.dart';
import '../../../cart/presentation/pages/cart_screen.dart';
import '../../../more/data/models/create_customer_model.dart';
import '../../../more/presentation/pages/MoreScreen.dart';
import '../../../search/presentation/pages/search.dart';
import '../../data/models/category_model.dart';
import '../../data/models/products_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepo}) : super(HomeInitial());
  final HomeRepo homeRepo;
  int currentIndex = 0;
  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  List<Widget> screens = [
    const HomeScreenWidget(),
    const SearchScreen(),
    const CartScreen(),
    const MoreScreen(),
  ];

  List<String> images = [
    'https://th.bing.com/th/id/OIP.zsIVrzBiWB4j0YBYJxKwTQHaHa?rs=1&pid=ImgDetMain',
    'https://thumbs.dreamstime.com/b/e-commerce-concept-illustration-tablet-computer-online-shopping-decorative-icons-set-vector-51554856.jpg',
    'https://img.freepik.com/free-vector/e-commerce-round-composition_1284-22113.jpg?w=360&t=st=1707465748~exp=1707466348~hmac=27c2a9c21c7ab1d5d014d31dae0997943206c2663b5c5b4d32b18528fc5401b4',
  ];

  List<CartItemModel> cartList = [];
  List<ProductModel> products = [];
  void getProducts() async {
    var result = await homeRepo.getProducts();
    result.fold((l) => emit(ProductsErrorState()), (r) {
      products = r;
      emit(ProductsSuccessState());
    });
  }

  List<CategoryModel> categories = [];
  void getCategories() async {
    var result = await homeRepo.getCategories();
    result.fold((l) => emit(CategoriesErrorState()), (r) {
      categories = r;
      emit(CategoriesSuccessState());
    });
  }

  void addToCart(CartItemModel product) {
    productIndex = -1;
    if (cartList.any((element) =>
        element.productModel.id == product.productModel.id &&
        element.variantId == product.variantId)) {
      int index = cartList.indexWhere((element) =>
          element.productModel.id == product.productModel.id &&
          element.variantId == product.variantId);

      if (product.quantity > 1) {
        cartList[index].quantity += product.quantity;
      } else {
        cartList[index].quantity++;
      }
      totalPrice();
      emit(AddToCartState());
      showSnackBarF(
          context: NavigationService.navigatorKey.currentState!.context,
          text: S
              .of(NavigationService.navigatorKey.currentState!.context)
              .SuccessfullyAddedToCart);
      return;
    }

    cartList.add(product);
    totalPrice();
    showSnackBarF(
        context: NavigationService.navigatorKey.currentState!.context,
        text: S
            .of(NavigationService.navigatorKey.currentState!.context)
            .SuccessfullyAddedToCart);
    emit(AddToCartState());
  }

  void increaseQuantity(int index) {
    cartList[index].quantity++;
    totalPrice();
    emit(AddToCartState());
  }

  void decreaseQuantity(int index) {
    if (cartList[index].quantity > 1) {
      cartList[index].quantity--;
      totalPrice();
      emit(AddToCartState());
    }
  }

  void removeFromCart(int index) {
    cartList.removeAt(index);
    totalPrice();
    emit(AddToCartState());
  }

  double total = 0.0;
  void totalPrice() {
    total = 0.0;
    for (var element in cartList) {
      total += double.parse(element.productModel.price) * element.quantity;
    }
    emit(AddToCartState());
  }

  void makeOrder(Map<String, dynamic> data) async {
    emit(OrderLoadingState());
    var result = await homeRepo.makeOrder(data);
    result.fold((l) {
      emit(OrderErrorState());
    }, (r) {
      List<String> ordersHistoryIds = [];
      if (CacheHelper.getData(key: CacheHelperKeys.ordersHistory) != null) {
        ordersHistoryIds =
            CacheHelper.getListData(key: CacheHelperKeys.ordersHistory);
      }
      ordersHistoryIds.add(r.id.toString());
      CacheHelper.saveData(
          key: CacheHelperKeys.ordersHistory, value: ordersHistoryIds);
      emit(OrderSuccessState());
    });
  }

  void clearData() {
    cartList.clear();
    total = 0.0;
    currentIndex = 0;
    emit(AddToCartState());
  }

  List<ProductModel> productsByCategory = [];
  void getProductsByCategory(int categoryId) async {
    emit(ProductsLoadingState());
    productsByCategory = [];
    var result = await homeRepo.getProductsByCategory(categoryId);
    result.fold((l) => emit(ProductsErrorState()), (r) {
      productsByCategory = r;
      emit(ProductsSuccessState());
    });
  }

  void searchByCategoryName(String categoryName) {
    productsByCategory = [];
    if (categoryName.isNotEmpty) {
      List<CategoryModel> models = categories
          .where((category) => category.name
              .toLowerCase()
              .startsWith(categoryName.toLowerCase()))
          .toList();
      if (models.isNotEmpty) {
        getProductsByCategory(models[0].id);
        models = [];
      }
      else
        {
          emit(SearchByCategoryEmptyState());
        }
    }
    else {
      emit(SearchByCategoryState());
    }
  }

  List<ProductVariations> productVariants = [];
  void getProductVariants(int productId) async {
    emit(ProductVariationLoadingState());
    var result = await homeRepo.getProductVariations(productId);
    result.fold((l) => emit(ProductsErrorState()), (r) {
      productVariants = r;
      emit(ProductsSuccessState());
    });
  }

  int productIndex = -1;

  void matchVariantProduct(String name) {
    productIndex =
        productVariants.indexWhere((element) => name == element.name);
  }

  void concatenateVariantProduct(List<String> names) {
    String name = names.join(', ');
    matchVariantProduct(name);
  }

  CreateCustomerModel? customerModel;
  Future<void> getCustomerData(int id) async {
    customerModel=null;
    emit(UserLoadingState());
    var result = await homeRepo.getCustomerData(id);
    result.fold((l) => emit(UserErrorState()), (r) {
      customerModel = r;
      emit(UserSuccessState());
    });
  }


  void editOrderStatus(int orderId,data)async
  {
    var result=await homeRepo.editOrderStatus(orderId,data);
    result.fold((l) => emit(EditOrderErrorState()), (r) {
      emit(EditOrderSuccessState());
    });
  }
}
