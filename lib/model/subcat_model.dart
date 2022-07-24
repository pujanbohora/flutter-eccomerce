import 'package:the_gadget_zone/model/ads_model.dart';
import 'package:the_gadget_zone/model/product_model.dart';

class SubCategoryModel {
  String? subCat_name;
  List<ProductModel>? subCatListOfProducts;

  SubCategoryModel({
    this.subCat_name,
    this.subCatListOfProducts,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
        subCatListOfProducts: (json["products"] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList(),
        subCat_name: json["sub_category"]["name"]);
  }
}
