part of 'address_bloc.dart';

@immutable
abstract class AddressEvent {}

class UserAddressEvent extends AddressEvent{
  final AddressModel model;

  UserAddressEvent({required this.model});

}
class CompleteOrderEvent extends AddressEvent{
  String addressId;

  CompleteOrderEvent({required this.addressId});
}
