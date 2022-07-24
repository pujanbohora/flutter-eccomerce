part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class LoginSubmitLoading extends RegisterState{}

class RegistrationSuccessState extends RegisterState{
  final String message;
  RegistrationSuccessState({required this.message});
}

class RegistrationFailedState extends RegisterState{
  final String message;
  RegistrationFailedState({required this.message});
}