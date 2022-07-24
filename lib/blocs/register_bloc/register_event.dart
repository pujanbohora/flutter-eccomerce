part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterFormSubmitEvent extends RegisterEvent{
  final AuthUserModel model;
  RegisterFormSubmitEvent({required this.model});

}


