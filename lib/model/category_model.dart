import 'package:the_gadget_zone/model/ads_model.dart';

class CategoryModel {
  String? categoryName;
  String? slug;
  List? ads;
  List? products;
  CategoryModel({this.categoryName, this.slug, this.ads, this.products});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryName: json['name'],
      slug: json['slug'],
    );
  }
  factory CategoryModel.fromCategoryJson(Map<String, dynamic> json) {
    print('CategoryModel');
    return CategoryModel(
      slug: json['slug'],
      
    );
  }
}
