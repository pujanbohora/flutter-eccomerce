import 'dart:convert';

import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'package:the_gadget_zone/api_helper/api_url.dart';
import 'package:the_gadget_zone/model/ads_model.dart';
import 'package:the_gadget_zone/model/category_model.dart';
import 'package:the_gadget_zone/model/product_model.dart';
import 'package:the_gadget_zone/model/subcat_model.dart';

class ViewCategoryRepo { 

  bool responseVal = false; 

   viewCategory({required String token, required String slug}) async {
    String slugUrl = ApiUrl.baseUrl + ApiUrl.categoryItemsBySlug + slug;
    print(slugUrl);
    print(token+'jhdfjhjdhf');
    try {
      final response = await get(Uri.parse(slugUrl),
          headers: {"Authorization": "Bearer " + token});

          print('inside try');

      // print(jsonDecode(response.body)["catData"][0]["ads"][0]["pagenation_image"]);
      if (response.statusCode == 200) {
        responseVal = true;
        List<AdsModel> adsList = (jsonDecode(response.body)["ads"] as List)
            .map((e) => AdsModel.fromJson(e))
            .toList();
        List<SubCategoryModel> subcatList =
            (jsonDecode(response.body)["productsBySubCategory"] as List)
                .map((e) => SubCategoryModel.fromJson(e))
                .toList();
        return {'ads': adsList, "subcatWithProduct": subcatList};
      }
    } catch (e) {}
  }
}
