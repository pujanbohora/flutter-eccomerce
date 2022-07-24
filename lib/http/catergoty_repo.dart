import 'dart:convert';

import 'package:http/http.dart';
import 'package:the_gadget_zone/api_helper/api_url.dart';
import 'package:the_gadget_zone/model/category_model.dart';

class CategoryRepo {
  bool responseVal = false;
  Future<List<CategoryModel>> getCategory({required String token}) async {
    try {
      final response = await get(
        Uri.parse(ApiUrl.baseUrl + ApiUrl.categoryView),
        headers: {"Authorization": "Bearer " + token},
      );

      if (response.statusCode == 200) {
        responseVal = true;
        print('getCategory');

        String jsonString = response.body;
        List jsonMapList = jsonDecode(jsonString);
        List<CategoryModel> categoryModel =
            jsonMapList.map((e) => CategoryModel.fromJson(e)).toList();
        return categoryModel;
      }
      else{
        return Future.error("response 200");
      }
    } catch (e) {
      return Future.error("Cann't get user Information");
    }
  }
}
