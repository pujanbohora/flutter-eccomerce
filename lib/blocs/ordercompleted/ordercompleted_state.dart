part of 'ordercompleted_bloc.dart';

@immutable
abstract class OrdercompletedState {}

class OrdercompletedInitial extends OrdercompletedState {}

class MyOrderCompleteState extends OrdercompletedState{
  final List<MyOrderModel> orderinfodetails;
  MyOrderCompleteState({required this.orderinfodetails});

}

class MyOrderCompleteFailedState extends OrdercompletedState{
  String? message;
  MyOrderCompleteFailedState({this.message});
}

class AdminOrderStatusState extends OrdercompletedState{
  final List<MyOrderModel> orderinfodetails;
  AdminOrderStatusState({required this.orderinfodetails});
}

class AdminOrderChangedStatus extends OrdercompletedState{
  String? message;
  AdminOrderChangedStatus({required this.message});
}
