import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/helpers/cache_helper.dart';
import 'package:khoyout/feature/home/data/models/order_model.dart';
import 'package:khoyout/feature/more/data/repositories/more_repo.dart';

import 'orders_history_state.dart';

class OrdersHistoryCubit extends Cubit<OrdersHistoryState> {
  OrdersHistoryCubit({required this.moreRepo}) : super(OrdersHistoryInitial());

  final MoreRepo moreRepo;


  // Future<OrderModel?> getOrderHistory(int id) async {
  //   var result = await moreRepo.getOrderHistory(id);
  //   OrderModel ? orderModel;
  //   result.fold(
  //     (l) => orderModel=null,
  //     (model) {
  //      orderModel= model;
  //     },
  //   );
  //   return orderModel;
  // }

  // void getAllOrdersHistoryList()async
  // {
  //   emit(OrdersHistoryLoadedState());
  //   List<String> ordersIds=CacheHelper.getData(key: CacheHelperKeys.ordersHistory);
  //   OrderModel ? orderModel;
  //   for(String id in ordersIds)
  //     {
  //       orderModel=await getOrderHistory(int.parse(id));
  //       if(orderModel !=null)
  //         {
  //           ordersHistoryList.add(orderModel);
  //         }
  //     }
  //   emit(OrdersHistorySuccessState());
  // }

  List<OrderModel> ordersHistoryList=[];

  void getAllOrdersHistory()async
  {
    ordersHistoryList=[];
    emit(OrdersHistoryLoadedState());
    try
        {
          List<String> ordersId=CacheHelper.getListData(key: CacheHelperKeys.ordersHistory);
          final future=ordersId.map((id) => moreRepo.getOrderHistory(int.parse(id))).toList();
          final orders=await Future.wait(future);
          for (var order in orders) {
            order.fold((l){}, (r){
              ordersHistoryList.add(r);
            });
          }
          emit(OrdersHistorySuccessState());
        }
        catch(e)
    {
      emit(OrdersHistoryErrorState(message: e.toString()));
    }

  }

  void getHistory()
  {
    if(CacheHelper.getData(key: CacheHelperKeys.createCustomer)!=null)
      {
        getAllOrdersHistoryByCustomerId(CacheHelper.getData(key: CacheHelperKeys.createCustomer));
        print('customer id ${CacheHelper.getData(key: CacheHelperKeys.createCustomer)}');
      }
    else
      {
        print('gggggggggggggggggggggggggggggggggggggggggg');
        getAllOrdersHistory();
      }
  }



  void getAllOrdersHistoryByCustomerId(int customerId)async
  {
    ordersHistoryList=[];
    emit(OrdersHistoryLoadedState());
    var result = await moreRepo.getOrdersHistoryByCustomerId(customerId);
    result.fold(
      (l) => emit(OrdersHistoryErrorState(message: l.message.toString())),
      (r) {
        ordersHistoryList=r;
        emit(OrdersHistorySuccessState());
      },
    );

  }




}
