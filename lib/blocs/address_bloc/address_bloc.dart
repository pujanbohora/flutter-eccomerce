import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
import 'package:the_gadget_zone/hive/hive_db.dart';
import 'package:hive/hive.dart';
import 'package:the_gadget_zone/http/address_repo.dart';
import 'package:the_gadget_zone/model/address_model.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    on<UserAddressEvent>((event, emit) async{
      emit(LoadingSubmitState());

     Box box = await SaveLocally().openBox();
     print('hello im in bloc address');

      if(box.isNotEmpty){
        String token = box.get("token");
        print(token);
        final address = await OrderAddress().addressSave(token : token, addressModel : event.model );

        emit(AcceptAddressId(address));
      }
      
    });

    on<CompleteOrderEvent>((event, emit) async{

      emit(LoadingSubmitState());
     Box box = await SaveLocally().openBox();

      if(box.isNotEmpty){
        String token = box.get("token");
        print(token);
        await CompleteOrderRepo().orderSave(token : token, addressId : event.addressId);

        emit(CompleteOrder( message : "Your order has been"));
      }
      
    });
  }
}
