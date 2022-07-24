part of 'validation_bloc.dart';

@immutable
abstract class ValidationState {}

class ValidationInitial extends ValidationState {}

class ValidationError extends ValidationState{
  final String message;
  ValidationError({required this.message});

}
class ValidationSuccess extends ValidationState{
  final AuthUserModel model;
  ValidationSuccess({required this.model});
}

class LoginValidationSuccess extends ValidationState{
  final AuthUserModel model;
  LoginValidationSuccess({required this.model});
}
class LoginValidationFailed extends ValidationState{
  final String message;
  LoginValidationFailed({required this.message});
}
