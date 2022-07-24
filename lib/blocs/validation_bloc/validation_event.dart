part of 'validation_bloc.dart';

@immutable
abstract class ValidationEvent {}

class ValidationCheckEvent extends ValidationEvent{
  final AuthUserModel model;
  ValidationCheckEvent({required this.model});
}

class LoginValidationCheckEvent extends ValidationEvent{
  final AuthUserModel model;
  LoginValidationCheckEvent({required this.model}); 
}
