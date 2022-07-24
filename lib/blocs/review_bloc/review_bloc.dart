import 'dart:convert';


import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:the_gadget_zone/api_helper/api_url.dart';
import 'package:the_gadget_zone/hive/hive_db.dart';
import 'package:the_gadget_zone/http/review_repo.dart';
import 'package:the_gadget_zone/http/user_http.dart';
import 'package:the_gadget_zone/model/review_model.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  SaveLocally hiveToken = SaveLocally();
  HttpUser apiCall = HttpUser();
  ReviewBloc() : super(ReviewInitial()) {
    on<ReviewPostEvent>((event, emit) async {
      try {
        
        Box box = await SaveLocally().openBox();
        if (box.isNotEmpty) {
          String token = box.get("token");
          await userAddReview(
              token: token, review: event.review, pid: event.pid);
          emit(AddReviewSuccess(message: "Review has been added"));
          print('state below');
        } else {
          print('cart in bloc');
        }
      } catch (e) {}
    });

    on<ReviewViewEvent>(((event, emit) async {
      try {
        Box box = await SaveLocally().openBox();
        if (box.isNotEmpty) {
          String token = box.get("token");
          List<ReviewModel> reviews =
              await ReviewGet().userViewReview(token: token, productId: event.productId);
          emit(ViewReviewState(reviews: reviews));
        }
      } catch (e) {print(e);}
    }));
  }
}

userAddReview(
    {required String token,
    required String review,
    required String pid}) async {
  String url = ApiUrl.baseUrl + ApiUrl.addReview + pid;

  Uri uri = Uri.parse(url);

  try {
    var res = await put(uri, headers: {
      "Authorization": "Bearer " + token,
    }, body: {
      "review": review
    });

    if (res.statusCode == 200) {
      return true;
    } else {
      return Future.error('Review Can\'t be added');
    }
  } catch (e) {
    return Future.error(e.toString());
  }
}


