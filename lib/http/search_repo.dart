import 'dart:convert';
import 'package:http/http.dart';
import 'package:the_gadget_zone/api_helper/api_url.dart';
import 'package:the_gadget_zone/model/product_model.dart';

class SearchRepo {
  searchProduct({required String token, required String name}) async {
    String url = ApiUrl.baseUrl + ApiUrl.searchProduct + name;

    Uri uri = Uri.parse(url);

    try {
      var res = await get(uri, headers: {
        "Authorization": "Bearer " + token,
      });
      print(res.statusCode);

      if (res.statusCode == 200) {
        List jsonMapList = jsonDecode(res.body);
        List<ProductModel> searchModel =
            jsonMapList.map((e) => ProductModel.fromJson(e)).toList();

        return searchModel;    
      }
    } catch (e) {}
  }
}
