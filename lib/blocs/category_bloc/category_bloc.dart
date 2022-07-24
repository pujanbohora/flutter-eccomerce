

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:the_gadget_zone/hive/hive_db.dart';
import 'package:the_gadget_zone/http/category_view_repo.dart';
import 'package:the_gadget_zone/http/catergoty_repo.dart';
import 'package:the_gadget_zone/model/category_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryView>((event, emit) async {
      try {
        Box box = await SaveLocally().openBox();
        if (box.isNotEmpty) {
          String token = box.get("token");
          List<CategoryModel> listOfCategoryModels =
              await CategoryRepo().getCategory(token: token);
              print('hey i am here');
          emit(CategoryGetSuccess(categoriesModel: listOfCategoryModels));
        } else {
          
          emit(CategoryGetFailed('User Token not found'));
        }
      } catch (e) {
        print('failed');
        emit(CategoryGetFailed(e.toString()));
        
      }
    });

    // on<GetCategoryProduct>((event, emit)async{
    //   print('sdhfjkhsjkdfhsdjkhfjksdhfjkdshjkfhsdpawan');
    //   try {
    //     Box box = await SaveLocally().openBox();
    //     if(box.isNotEmpty){
    //       String token = box.get("token");
    //       print(token);
    //       print(event.slug);
    //       await ViewCategoryRepo().viewCategory(token: token, slug: event.slug);
    //     }
    //   } catch (e) {
    //   }
    // });
  }
  

}
