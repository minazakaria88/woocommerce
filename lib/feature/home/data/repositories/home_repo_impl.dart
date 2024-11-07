import 'package:dartz/dartz.dart';
import 'package:khoyout/core/api_helper/end_points.dart';
import 'package:khoyout/core/api_helper/woocommerce_api.dart';
import 'package:khoyout/core/errors/failure.dart';
import 'package:khoyout/feature/home/data/models/category_model.dart';
import 'package:khoyout/feature/home/data/models/order_model.dart';
import 'package:khoyout/feature/home/data/models/product_variations.dart';
import 'package:khoyout/feature/home/data/models/products_model.dart';
import 'package:khoyout/feature/home/data/repositories/home_repo.dart';

import '../../../more/data/models/create_customer_model.dart';

class HomeRepoImpl implements HomeRepo
{
  final ApiHelper apiHelper;

  HomeRepoImpl({required this.apiHelper});



  @override
  Future<Either<Failure, List<ProductModel>>> getProducts()async {
    List<ProductModel> products=[];
    try {
      final response = await apiHelper.getData(url: EndPoints.products);
      for(var item in response.data) {
        products.add(ProductModel.fromJson(item));
      }
      return Right(products);
    } catch (e) {
      //dio
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories()async {

    final List<CategoryModel> categories=[];
    try
    {
      final response=await apiHelper.getData(url: EndPoints.categories);
      for(var item in response.data) {
        categories.add(CategoryModel.fromJson(item));
        // if(item['image']!=null) {
        //   categories.add(CategoryModel.fromJson(item));
        // }
      }
      return Right(categories);
    }catch(e)
    {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderModel>> makeOrder(Map<String, dynamic> data)async {
    try
    {
      final response =await apiHelper.postData(url: EndPoints.orders, data: data);
      return Right(OrderModel.fromJson(response.data));
    }catch(e)
    {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(int categoryId)async {
    List<ProductModel> products=[];
    try {
      final response = await apiHelper.getData(url: EndPoints.products, query: {'category': categoryId});
      for(var item in response.data) {
        products.add(ProductModel.fromJson(item));
      }
      return Right(products);
    } catch (e) {
      //dio
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductVariations>>> getProductVariations(int productId)async {
    List<ProductVariations> products=[];
    try {
      final response = await apiHelper.getData(url:'${EndPoints.products}/$productId/${EndPoints.variations}');
      for(var item in response.data) {
        products.add(ProductVariations.fromJson(item));
      }

      return Right(products);
    } catch (e) {
      //dio

      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateCustomerModel>> getCustomerData(
      int customerId) async {
    try {
      var response =
      await apiHelper.getData(url: '${EndPoints.customers}/$customerId');
      return Right(CreateCustomerModel.fromJson(response.data));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderModel>> editOrderStatus(int orderId,data)async {
    try
        {
           var response=await apiHelper.putData(url: '${EndPoints.orders}/$orderId',data: data);
           return Right(OrderModel.fromJson(response.data));
        }catch(e)
    {
      return Left(Failure(message: e.toString()));
    }
  }



}