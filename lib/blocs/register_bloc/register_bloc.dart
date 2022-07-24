import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:the_gadget_zone/auth_model/auth_user_model.dart';
import 'package:the_gadget_zone/http/user_http.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterFormSubmitEvent>((event, emit) async{
     emit(LoginSubmitLoading());
      bool status = await HttpUser().registerPost(authUserModel: event.model);

      if(status==true){
        emit(RegistrationSuccessState(message: 'User successflully registered'));
      }else{
        emit(RegistrationFailedState(message: 'User cannot be registered'));
      }
    });
  }
}
