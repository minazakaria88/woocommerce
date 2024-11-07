import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/helpers/extenction.dart';
import 'package:khoyout/core/utils/app_colors.dart';
import 'package:khoyout/feature/home/presentation/manager/home_cubit.dart';
import 'package:khoyout/feature/home/presentation/manager/home_state.dart';
import 'package:khoyout/feature/home/presentation/widgets/product_listview_item.dart';
import 'package:khoyout/generated/l10n.dart';
import 'package:khoyout/generated/l10n.dart';
import '../../../../core/helpers/product_type.dart';
import '../../../../core/routing/routes.dart';
import '../../../cart/data/models/cart_item_model.dart';
import '../../data/models/products_model.dart';

class AllProductByCategoryScreen extends StatelessWidget {
  const AllProductByCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).products),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<HomeCubit>(context);
          return cubit.productsByCategory.isNotEmpty
              ? CustomScrollView(
                  slivers: [
                    SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ProductListViewItem(
                              width: width,
                              height: height,
                              model: cubit.productsByCategory[index],
                              index: index,
                              onTap: () {
                                if (cubit.productsByCategory[index].type ==
                                    checkProductType(ProductType.variable)) {
                                  cubit.getProductVariants(
                                      cubit.productsByCategory[index].id);
                                }
                                ProductModel productModel =
                                    cubit.productsByCategory[index];
                                context.pushNamed(
                                  Routes.productDetail,
                                  arguments: CartItemModel(
                                      productModel: productModel.copyWith()),
                                );
                              },
                              addToCart: () {
                                if (cubit.productsByCategory[index].type ==
                                    checkProductType(ProductType.variable)) {
                                  cubit.getProductVariants(
                                      cubit.productsByCategory[index].id);
                                  ProductModel productModel =
                                      cubit.productsByCategory[index];
                                  context.pushNamed(
                                    Routes.productDetail,
                                    arguments: CartItemModel(
                                        productModel: productModel.copyWith()),
                                  );
                                } else {
                                  ProductModel productModel =
                                      cubit.productsByCategory[index];
                                  cubit.addToCart(CartItemModel(
                                      productModel: productModel));
                                }
                              },
                            ),
                          ),
                          childCount: cubit.productsByCategory.length,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ))
                  ],
                )
              : state is ProductsLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  :  Center(
                    child: Text(
                     S.of(context).emptyCategory,
                    ),
                  );
        },
      ),
    );
  }
}
