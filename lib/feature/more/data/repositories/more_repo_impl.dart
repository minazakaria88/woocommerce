import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khoyout/core/api_helper/end_points.dart';
import 'package:khoyout/core/api_helper/woocommerce_api.dart';
import 'package:khoyout/core/errors/failure.dart';
import 'package:khoyout/feature/home/data/models/order_model.dart';
import 'package:khoyout/feature/more/data/repositories/more_repo.dart';

import '../models/create_customer_model.dart';

class MoreRepoImpl implements MoreRepo {
  final ApiHelper apiHelper;

  MoreRepoImpl({required this.apiHelper});

  @override
  Future<Either<Failure, OrderModel>> getOrderHistory(int id) async {
    try {
      var response = await apiHelper.getData(url: '${EndPoints.orders}/$id');
      return Right(OrderModel.fromJson(response.data));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> createCustomer(CreateCustomerModel model) async {
    try {
      var response = await apiHelper.postData(
        url: EndPoints.customers,
        data: model.toJson(),
        query: {
          'email': model.email,
          'password': model.password,
        },
      );
      return Right(response.data['id']);
    } catch (e) {
      if(e is DioException) {
        return Left(ServerFailure.serverError(e));
      }
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getOrdersHistoryByCustomerId(int customerId) async{
    List<OrderModel> orders = [];
    try {
      var response = await apiHelper.getData(url: "${EndPoints.orders}?customer=$customerId");
      for(var order in response.data)
        {
          orders.add(OrderModel.fromJson(order));
        }
      return Right(orders);
    }catch(e){
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CreateCustomerModel>>> login(String email)async {
    List<CreateCustomerModel> customers=[];
    try
        {
          var response=await apiHelper.getData(url: EndPoints.customers,query: {'email':email});
          for(var model in response.data)
            {
              customers.add(CreateCustomerModel.fromJson(model));
            }
          return Right(customers);

        }catch(e)
    {
      if(e is DioException) {
        return Left(ServerFailure.serverError(e));
      }
      return Left(Failure(message: e.toString()));
    }
  }


}
