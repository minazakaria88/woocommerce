import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/functions/show_snackbar.dart';
import 'package:khoyout/core/utils/app_colors.dart';
import 'package:khoyout/feature/more/presentation/manager/history_cubit/orders_history_cubit.dart';
import 'package:khoyout/feature/more/presentation/manager/history_cubit/orders_history_state.dart';
import 'package:khoyout/generated/l10n.dart';

class OrdersHistoryScreen extends StatelessWidget {
  const OrdersHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).ordersHistory),
      ),
      body: BlocConsumer<OrdersHistoryCubit, OrdersHistoryState>(
          listener: (context, state) {
        if (state is OrdersHistorySuccessState &&
            BlocProvider.of<OrdersHistoryCubit>(context)
                .ordersHistoryList
                .isEmpty) {
          showSnackBarF(
              context: context, text: S.of(context).ordershistoryisempty);
        }
      }, builder: (context, state) {
        var cubit = BlocProvider.of<OrdersHistoryCubit>(context);
        if (state is OrdersHistoryLoadedState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is OrdersHistorySuccessState) {
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: cubit.ordersHistoryList.length,
                  (context, index) {
                    return orderHistoryListItem(cubit, index, context);
                  },
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Text(S.of(context).Somethingwentwrong),
          );
        }
      }),
    );
  }

  Padding orderHistoryListItem(OrdersHistoryCubit cubit, int index, context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            orderHistoryItem(
                S.of(context).ID, '${cubit.ordersHistoryList[index].id}'),
            orderHistoryItem(S.of(context).Total,
                '${cubit.ordersHistoryList[index].total} ${cubit.ordersHistoryList[index].currency}'),
            orderHistoryItem(
                S.of(context).Status, cubit.ordersHistoryList[index].status),
            orderHistoryItem(S.of(context).Name,
                '${cubit.ordersHistoryList[index].billing.firstName} ${cubit.ordersHistoryList[index].billing.lastName}'),
            orderHistoryItem(S.of(context).city,
                cubit.ordersHistoryList[index].billing.city),
            orderHistoryItem(S.of(context).address,
                cubit.ordersHistoryList[index].billing.address),
            orderHistoryItem(S.of(context).zipCode,
                cubit.ordersHistoryList[index].billing.postalCode),
            orderHistoryItem(S.of(context).phone,
                cubit.ordersHistoryList[index].billing.phone),
          ],
        ),
      ),
    );
  }

  Padding orderHistoryItem(String key, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '$key :   $value',
        style: const TextStyle(color: AppColors.primaryColor, fontSize: 18),
      ),
    );
  }
}
