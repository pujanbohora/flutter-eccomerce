import 'dart:convert';

import 'package:the_gadget_zone/api_helper/api_url.dart';
import 'package:http/http.dart';
import 'package:the_gadget_zone/model/review_model.dart';

class ReviewGet{
  userViewReview({required String token, required String productId}) async {
  String url = ApiUrl.baseUrl + ApiUrl.showReview + productId;

  Uri uri = Uri.parse(url);
  
  try {
    var res = await get(uri, headers: {
      "Authorization": "Bearer " + token,
    });
    print('show review');
    print(res.statusCode);

    if (res.statusCode == 200) {
      List reviewList = (jsonDecode(res.body) as List)
          .map((reviewList) => ReviewModel.fromJson(reviewList))
          .toList();
      print('pujannannnana');
      print(reviewList);
      return reviewList;
    }
  } catch (e) {
    return Future.error("Can't get reivew Information");
  }
}
}