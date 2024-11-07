import 'package:dartz/dartz.dart';
import 'package:khoyout/core/errors/failure.dart';
import 'package:khoyout/feature/home/data/models/order_model.dart';

import '../models/create_customer_model.dart';

abstract class MoreRepo
{
  Future<Either<Failure,OrderModel>> getOrderHistory(int id);
  Future<Either<Failure,List<OrderModel>>> getOrdersHistoryByCustomerId(int customerId);
  Future<Either<Failure,int>> createCustomer(CreateCustomerModel model);
  Future<Either<Failure,List<CreateCustomerModel>>> login(String email);
}