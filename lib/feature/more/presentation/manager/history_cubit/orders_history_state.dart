abstract class OrdersHistoryState {}

class OrdersHistoryInitial extends OrdersHistoryState {}

class OrdersHistorySuccessState extends OrdersHistoryState {}

class OrdersHistoryLoadedState extends OrdersHistoryState {

}

class OrdersHistoryErrorState extends OrdersHistoryState {
  final String message;
  OrdersHistoryErrorState({required this.message});
}