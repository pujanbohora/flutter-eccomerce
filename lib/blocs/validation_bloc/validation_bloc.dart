import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:the_gadget_zone/auth_model/auth_user_model.dart';

part 'validation_event.dart';
part 'validation_state.dart';

class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {
  ValidationBloc() : super(ValidationInitial()) {
    on<ValidationCheckEvent>((event, emit) {

      const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
      final regExp = RegExp(pattern);
      if( event.model.email==null || event.model.email == "" ){
        emit(ValidationError(message: "Email Field can't be empty"));
      }
      else if(!regExp.hasMatch(event.model.email!)){
        emit(ValidationError(message: 'Enter a valid email'));
      }
      else if( event.model.password==null || event.model.password == "" ){
        emit(ValidationError(message: "Password Field can't be empty"));
      }
      else if(event.model.password!.length < 6){
        emit(ValidationError(message: "Passowrd must contain more than 6 digits"));
      }
      else if( event.model.confirmPassword==null || event.model.confirmPassword == "" ){
        emit(ValidationError(message: "Confirm Password Field can't be empty"));
      }
      else if(event.model.password != event.model.confirmPassword){
        emit(ValidationError(message: "Password doesn't match confirm passowrd"));
      }
      
      
      else{
        emit(ValidationSuccess(model: event.model));
      }
    });
    on<LoginValidationCheckEvent>((event, emit){
      const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
       final regExp = RegExp(pattern);
       print("login validatidsfadsfdsfdsfdsfsdon check");

       if(event.model.email== null || event.model.email=="" ){
         emit(LoginValidationFailed(message: "Email Field can't be empty"));       
        }
        else if(event.model.password== null || event.model.password==""){
          emit(LoginValidationFailed(message: "Pasword Field can't be empty"));
        }
        else if(!regExp.hasMatch(event.model.email!) ){
          emit(LoginValidationFailed(message: "Enter a valid email"));
        }
        else if(event.model.password!.length < 6){
        emit(LoginValidationFailed(message: "Passowrd must contain more than 6 digits"));
      }
      else{
        emit(LoginValidationSuccess(model: event.model));
        print("dsfadsfdsfsdfdsfdsfdsfdsffdgdfgfdgdfgdfgfdg");
      }
    });
  }
}
