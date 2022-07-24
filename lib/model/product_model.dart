import 'package:the_gadget_zone/model/ads_model.dart';

class ProductModel {
  String? id;
  String? product_image;
  String? product_title;
  String? product_price;
  String? product_quantity;
  String? product_description;
  
  ProductModel({this.product_image, this.product_title, this.product_quantity, this.product_price, this.product_description,required this.id});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    
    return ProductModel(
      id: json ['_id'],
      product_title: json ['product_title'],
      product_quantity: json['product_quantity'].toString(),
      product_price: json['product_price'].toString(),
      product_description: json['product_description'],
      product_image: json['product_image'],
    );
  }
}