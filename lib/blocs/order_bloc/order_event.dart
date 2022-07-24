part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class AddProductToCart extends OrderEvent {
  final Order order;
  AddProductToCart(this.order);
}

class GetCartProduct extends OrderEvent {}

class TestEvent extends OrderEvent{}

class DeleteCartEvent extends OrderEvent{}


