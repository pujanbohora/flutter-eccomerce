part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderPlacedState extends OrderState {
  String message;
  OrderPlacedState(this.message);
}

class OrderPlacingFailedState extends OrderState {
  String message;
  OrderPlacingFailedState(this.message);
}

class TestState extends OrderState {}

class MyCartItems extends OrderState {
  final List<Order> orderModel;

  MyCartItems({required this.orderModel});
}

class LoadingSubmitState extends OrderState{}

class DeleteCart extends OrderState{
  String message;
  DeleteCart(this.message);
}
