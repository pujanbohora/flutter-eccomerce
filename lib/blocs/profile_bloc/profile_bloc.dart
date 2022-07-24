import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:hive/hive.dart';
import 'package:the_gadget_zone/hive/hive_db.dart';
import 'package:the_gadget_zone/http/user_http.dart';
import 'package:the_gadget_zone/model/customer_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  SaveLocally hiveToken = SaveLocally();
  HttpUser apiCall = HttpUser();
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileUpdateEvent>((event, emit) async {
      emit(LoadingState());
      try {
        Box userBox = await hiveToken.openBox();
        String token = userBox.get("token");
        print(token);

        String message = await apiCall.profileUpdate(
            fullname: event.fullname, contactNumber: event.phone, token: token);
        
        emit(ProfileUpdateSucess(message: message));
      } catch (e) {
        print(e.toString());
        emit(ProfileUpdateFailed(message: e.toString()));
      }
    });
    on<ProfileShow>((event, emit) async {
      try {
        Box userBox = await hiveToken.openBox();
        String token = userBox.get("token");
        CustomerModel profileSave = await apiCall.profileView(token: token);
        emit(ProfileViewSuccess(profileSave: profileSave,));
      } catch (e) {
        emit(ProfileViewFailed(message : e.toString()));
      }
      

    });
  }
}
