import 'package:dartz/dartz.dart';
import 'package:khoyout/core/errors/failure.dart';
import 'package:khoyout/feature/home/data/models/product_variations.dart';

import '../../../more/data/models/create_customer_model.dart';
import '../models/category_model.dart';
import '../models/order_model.dart';
import '../models/products_model.dart';

abstract class HomeRepo
{
  Future<Either<Failure,List<ProductModel>>> getProducts();
  Future<Either<Failure,OrderModel>> makeOrder(Map<String, dynamic> data);
  Future<Either<Failure,List<CategoryModel>>> getCategories();

  Future<Either<Failure,List<ProductModel>>> getProductsByCategory(int categoryId);

  Future<Either<Failure,List<ProductVariations>>> getProductVariations(int productId);

  Future<Either<Failure,CreateCustomerModel>> getCustomerData(int customerId);

  Future<Either<Failure,OrderModel>> editOrderStatus(int orderId,data);
}