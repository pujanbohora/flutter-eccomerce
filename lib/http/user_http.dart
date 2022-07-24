import 'dart:convert';
import 'package:http/http.dart';
import 'package:the_gadget_zone/api_helper/api_url.dart';
import 'package:the_gadget_zone/auth_model/auth_user_model.dart';
import 'package:the_gadget_zone/model/category_model.dart';
import 'package:the_gadget_zone/model/customer_model.dart';

class HttpUser {

  String testToken ='';

  bool responseVal=false;
  Future<bool> registerPost({required AuthUserModel authUserModel}) async {
    try {
      final response = await post(Uri.parse(ApiUrl.baseUrl + ApiUrl.signup),
          body: {
            "email": authUserModel.email,
            "password": authUserModel.password
          });

          print(response.statusCode);
      if (response.statusCode == 200) {
        responseVal=true;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String> loginPost({required AuthUserModel authUserModel}) async {
    try {
      final response = await post(Uri.parse(ApiUrl.baseUrl + ApiUrl.singin),
          body: {
            "email": authUserModel.email,
            "password": authUserModel.password
          });
          print('loginpage');
      print(response.statusCode);
      if (response.statusCode == 200) {
        responseVal = true;
        if (jsonDecode(response.body)["token"] != null &&
            jsonDecode(response.body)["token"] != "") {

              //for testing
              testToken = jsonDecode(response.body)["token"];
              print(testToken);
              
          return jsonDecode(response.body)["token"];
        } else {
          return Future.error("Token not found.");
        }
      } else {
        return Future.error("Login Failed.");
      }
    } catch (e) {
      print(e);
      return Future.error("Login Failed.");
    }
  }

  Future<String> profileUpdate(
      {String? fullname, String? contactNumber, required String token}) async {
    try {
      final response = await put(
          Uri.parse(ApiUrl.baseUrl + ApiUrl.userUpdate),
          headers: {"Authorization": "Bearer " + token},
          body: {"fullname": fullname, "contactNumber": contactNumber});

          print(response.statusCode);
      if (response.statusCode == 200) {
        return 'Profile has been updated';
      } else {
        return Future.error("Profile can't be updated");
      }
    } catch (e) {
      return Future.error('Profile update failed');
    }
  }

  profileView({required String token}) async {
    try {
      final response = await get(
        Uri.parse(ApiUrl.baseUrl + ApiUrl.userView),
        headers: {"Authorization": "Bearer " + token},
      );
      print(response.statusCode);

      String jsonString = response.body;
      List pa = (jsonDecode(jsonString) as List)
          .map((catList) => CategoryModel.fromJson(catList))
          .toList();
      print(jsonDecode(jsonString).toString());
      print(pa.toString());
    } catch (e) {
      return Future.error("Can't get user Information");
    }
  }
}
