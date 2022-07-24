part of 'ordercompleted_bloc.dart';

@immutable
abstract class OrdercompletedEvent {}

class MyOrderCompleteEvent extends OrdercompletedEvent{}

class AdminOrderStatusEvent extends OrdercompletedEvent{
  String status;
  AdminOrderStatusEvent({required this.status});
}

class AdminChangeStatusEvent extends OrdercompletedEvent{
  String id;
  String changedStatus;

  AdminChangeStatusEvent({required this.id, required this.changedStatus});
}

class AdminCancelOrderEvent extends OrdercompletedEvent{
  String id;

  AdminCancelOrderEvent({required this.id});
}
