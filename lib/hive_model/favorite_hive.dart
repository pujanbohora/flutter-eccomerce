import 'package:hive/hive.dart';
part 'favorite_hive.g.dart';

@HiveType(typeId: 1)
class FavouriteHiveModel {
  @HiveField(0) 
  final String? product_image;
  @HiveField(1)
  final String? product_title;
  @HiveField(2)
  final String? product_price;
  @HiveField(3)
  final String? product_quantity;
  @HiveField(4)
  final String? product_description;

  FavouriteHiveModel(
      {this.product_image,
      this.product_title,
      this.product_price,
      this.product_quantity,
      this.product_description});

}