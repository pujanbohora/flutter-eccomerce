import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:the_gadget_zone/api_helper/api_url.dart';
import 'package:the_gadget_zone/hive/hive_db.dart';
import 'package:the_gadget_zone/model/order_model.dart';
import 'package:http/http.dart' as http;

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  SaveLocally hiveDb = SaveLocally();
  OrderBloc() : super(OrderInitial()) {
    on<AddProductToCart>((event, emit) async {
      emit(LoadingSubmitState());
      Box box = await hiveDb.openBox();

      String token = box.get('token');

      if (box.toMap().containsKey('token')) {
        try {
          await addTOCart(event.order, token);

          emit(OrderPlacedState('Product has been added to cart'));
        } catch (e) {
          emit(OrderPlacingFailedState("Product can't been added"));
        }
      }
    });

    on<GetCartProduct>((event, emit) async {
      print('Im in box vanda mathi');
      Box box = await SaveLocally().openBox();
      print("IN bloc");
      if (box.isNotEmpty) {
        String token = box.get("token");
        var addcartToken = await ViewCart(token: token);
      } else {
        print('cart in bloc');
      }
    });

    on<TestEvent>(((event, emit) async {
      print('Im in box vanda mathi');
      Box box = await SaveLocally().openBox();
      print("IN bloc");
      if (box.isNotEmpty) {
        String token = box.get("token");
        var addcartToken = await ViewCart(token: token);

        emit(MyCartItems(orderModel: addcartToken));
      } else {
        print('cart in bloc');
      }
    }));

    //delete cart

    on<DeleteCartEvent>((event, emit) async {
      try {
        emit(LoadingSubmitState());
        print('delete cart');
        Box box = await SaveLocally().openBox();
        print("delete 2");
        if (box.isNotEmpty) {
          String token = box.get("token");
          var addcartToken = await deleteCart(token: token);

          emit(DeleteCart('Cart has been cleared'));
        } else {
          print('cart in delete');
        }
      } catch (e) {
        return Future.error(e.toString());
      }
    });
  }
}

addTOCart(Order order, String token) async {
  String url = ApiUrl.baseUrl + ApiUrl.addToCart;

  Uri uri = Uri.parse(url);
  var data = json.encode({
    "cartItems": {
      "product": order.id.toString(),
      "quantity": order.product_quantity,
      "price": order.product_price.toString()
    }
  });

  try {
    var res = await http.post(uri,
        headers: {
          "Authorization": "Bearer " + token,
          "content-type": "application/json"
        },
        body: data);
    print('status code');
    print(res.statusCode);

    if (res.statusCode == 200) {
    } else {
      return Future.error('Can\'t be added to cart');
    }
  } catch (e) {
    return Future.error(e.toString());
  }
}

ViewCart({required String token}) async {
  final response = await http.get(
    Uri.parse(ApiUrl.baseUrl + ApiUrl.viewCart),
    headers: {"Authorization": "Bearer " + token},
  );

  if (response.statusCode == 200) {
    print('in cart');

    List<Order> cartProduct = (jsonDecode(response.body) as List)
        .map((e) => Order.fromJson(e))
        .toList();

    return cartProduct;
  } else {
    print('no in cart');
  }
}

deleteCart({required String token}) async {
  final response = await http.delete(
    Uri.parse(ApiUrl.baseUrl + ApiUrl.deleteCart),
    headers: {"Authorization": "Bearer " + token},
  );
  print(response.statusCode);

  if (response.statusCode == 200) {
    print('delete cart 200');

    return 'Cart has been cleared';
  } else {
    return 'cart cannot be cleared';
  }
}
