part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginFormSubmitEvent extends LoginEvent{
  final AuthUserModel model;
  LoginFormSubmitEvent({required this.model});
}

class LoginThroughBiometrics extends LoginEvent {}

