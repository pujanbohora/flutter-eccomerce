// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouriteHiveModelAdapter extends TypeAdapter<FavouriteHiveModel> {
  @override
  final int typeId = 1;

  @override
  FavouriteHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouriteHiveModel(
      product_image: fields[0] as String?,
      product_title: fields[1] as String?,
      product_price: fields[2] as String?,
      product_quantity: fields[3] as String?,
      product_description: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FavouriteHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.product_image)
      ..writeByte(1)
      ..write(obj.product_title)
      ..writeByte(2)
      ..write(obj.product_price)
      ..writeByte(3)
      ..write(obj.product_quantity)
      ..writeByte(4)
      ..write(obj.product_description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
