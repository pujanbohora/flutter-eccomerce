import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:the_gadget_zone/auth_model/auth_user_model.dart';
import 'package:the_gadget_zone/hive/hive_db.dart';
import 'package:the_gadget_zone/http/user_http.dart';
import 'package:hive/hive.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  SaveLocally hive = SaveLocally();
  
  LoginBloc() : super(LoginInitial()) {

    on <LoginThroughBiometrics>(((event, emit)  async {

        print('running');
    try {
      var box = await Hive.openBox('user');
      String email = await box.get('email');
      String password = await box.get('password');

      print(email);
      print(password);
      print('hello');

      String token = await HttpUser().loginPost(authUserModel: AuthUserModel(email: email, password: password));
        await hive.savetoken(token);

           emit(LoginSuccessState(message: 'User Login Successful'));

    
    } 
    catch (e) {
          print('you are in login failed');
        emit(LoginFailedState(message: e.toString()));
      
    }
  }
    ));
    on<LoginFormSubmitEvent>((event, emit) async {
      emit(LoadingState());
      try {
        String token = await HttpUser().loginPost(authUserModel: event.model);
        await hive.savetoken(token);

       var boox= await Hive.openBox('user');
       await boox.put('email', event.model.email);
       await boox.put('password', event.model.password);

       


        emit(LoginSuccessState(message: 'User Login Successful'));
      } catch (e) {
        print('you are in login failed');
        emit(LoginFailedState(message: e.toString()));
      }
    });
  }}


