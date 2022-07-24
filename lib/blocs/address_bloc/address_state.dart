part of 'address_bloc.dart';

@immutable
abstract class AddressState {}

class AddressInitial extends AddressState {}

class AcceptAddressId extends AddressState{
  String address;

  AcceptAddressId(this.address);
}

class CompleteOrder extends AddressState{
  String message;

  CompleteOrder({required this.message});
}

class LoadingSubmitState extends AddressState{}

