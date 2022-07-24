import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:the_gadget_zone/hive/hive_db.dart';
import 'package:the_gadget_zone/http/myorder_repo.dart';
import 'package:the_gadget_zone/model/myorder.dart';

part 'ordercompleted_event.dart';
part 'ordercompleted_state.dart';

class OrdercompletedBloc
    extends Bloc<OrdercompletedEvent, OrdercompletedState> {
  SaveLocally hiveDb = SaveLocally();
  OrdercompletedBloc() : super(OrdercompletedInitial()) {
    on<MyOrderCompleteEvent>((event, emit) async {
      Box box = await hiveDb.openBox();

      String token = box.get('token');
      try {
        if (box.toMap().containsKey('token')) {
          List<MyOrderModel> orderDetails =  await MyOrderCompleted().MyOrder(token: token);
          emit(MyOrderCompleteState(orderinfodetails: orderDetails));
        }
        
      } catch (e) {
        emit(MyOrderCompleteFailedState(message: 'Order view info error'));
        print(e.toString());
      }
    });

    on<AdminOrderStatusEvent>((event, emit) async {
      Box box = await hiveDb.openBox();

      String token = box.get('token');
      try {
        if (box.toMap().containsKey('token')) {
          List<MyOrderModel> orderDetails =  await MyOrderCompleted().adminOrderStatus(token: token, status: event.status);
          emit(AdminOrderStatusState(orderinfodetails: orderDetails));
        }
        
      } catch (e) {
        emit(MyOrderCompleteFailedState(message: 'Order view info error'));
        print(e.toString());
      }
    });

    on<AdminChangeStatusEvent>((event, emit) async {
      Box box = await hiveDb.openBox();
      print('oleoleoleoleoel');

      String token = box.get('token');
      try {
        print('oleoleoleoleoel2222');
        if (box.toMap().containsKey('token')) {
          print('oleoleoleoleoel222266666');
          await MyOrderCompleted().adminChangeStatus(token: token, id: event.id, changedStatus: event.changedStatus);
          emit(AdminOrderChangedStatus(message : "Order has been viewed"));
        }
        
      } catch (e) {
        emit(MyOrderCompleteFailedState(message: 'Order view info error'));
        print(e.toString());
      }
    });
  }
}
