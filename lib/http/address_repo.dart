import 'dart:convert';

import 'package:the_gadget_zone/api_helper/api_url.dart';
import 'package:http/http.dart';
import 'package:the_gadget_zone/model/address_model.dart';

class OrderAddress {
  Future<String> addressSave(
      {required String token, required AddressModel addressModel}) async {
    String addressUrl = ApiUrl.baseUrl + ApiUrl.saveAddress;

    try {
      final response = await post(Uri.parse(addressUrl), headers: {
        "Authorization": "Bearer " + token
      }, body: {
        "name": addressModel.name,
        "mobileNumber": addressModel.mobileNumber,
        "locality": addressModel.locality,
        "address": addressModel.address,
        "cityDistrictTown": addressModel.cityDistrictTown,
        "landmark": addressModel.landmark
      });

      if (response.statusCode == 200) {
        print(jsonDecode(response.body)["addressId"]);
        return jsonDecode(response.body)["addressId"];
        

      } else {
       return('Nothing in body');
      }
    } catch (e) {
      return e.toString();
    }
  }
}

class CompleteOrderRepo {
  orderSave({required String token, required String addressId}) async{
    String orderUrl = ApiUrl.baseUrl + ApiUrl.saveOrderInfo;

    try {
      final response = await post(Uri.parse(orderUrl), headers: {
        "Authorization": "Bearer " + token
      }, body: {
        "addressId": addressId,
      });
    } catch (e) {
      return e.toString();
    }

  }
}
