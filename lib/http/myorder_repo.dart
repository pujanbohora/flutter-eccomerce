import 'dart:convert';

import 'package:http/http.dart';
import 'package:the_gadget_zone/api_helper/api_url.dart';
import 'package:the_gadget_zone/model/myorder.dart';

class MyOrderCompleted {

  bool responseVal=true;

  MyOrder({required String token}) async {
    final response = await get(
      Uri.parse(ApiUrl.baseUrl + ApiUrl.getOrderdetails),
      headers: {"Authorization": "Bearer " + token},
    );

    try {
      if (response.statusCode == 200) {
        responseVal= false;
        List orderDetails = (jsonDecode(response.body) as List)
            .map((e) => MyOrderModel.fromJson(e))
            .toList();
        print(orderDetails.toString());

        return (orderDetails);
      } else {
        return Future.error('Order view error');
      }
    } catch (e) {
      return Future.error('Order view failed');
    }
  }

  adminOrderStatus({required String token, required String status}) async {
    print('hello');
    final response = await get(
        Uri.parse(ApiUrl.baseUrl + ApiUrl.adminGetOrderStatus + status),
        headers: {"Authorization": "Bearer " + token});

    try {
      print(response.statusCode);
      print('in admin order');
      if (response.statusCode == 200) {
        
        print('hjhejkhsjdhf');
        print(response.body.toString());
        List orderDetails = (jsonDecode(response.body) as List)
            .map((e) => MyOrderModel.fromAdminOrder(e))
            .toList();

        return (orderDetails);
      } else {
        return Future.error('Adimin Order view error');
      }
    } catch (e) {
      return Future.error('Admin Order view failed');
    }
  }

  adminChangeStatus(
      {required String token,
      required String id,
      required String changedStatus}) async {
    try {
      print(id);
      final response = await post(
          Uri.parse(ApiUrl.baseUrl + ApiUrl.adminChangeOrderStatus + id),
          headers: {"Authorization": "Bearer " + token},
          body: {"status": changedStatus});

          print(response.toString());

      print(response.statusCode);
      if (response.statusCode == 200) {

        return 'Order Added to in progress';
      }
      else{
        return Future.error("Error, Order can't be added to in progress");
      }
    } catch (e) {
      return Future.error('Admin Order added failed');
    }
  }
}
