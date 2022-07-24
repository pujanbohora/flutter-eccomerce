part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccessState extends LoginState{
  final String message;
  LoginSuccessState({required this.message});
}
class LoginFailedState extends LoginState{
  final String message;
  LoginFailedState({required this.message});
}

class LoadingState extends LoginState{}




