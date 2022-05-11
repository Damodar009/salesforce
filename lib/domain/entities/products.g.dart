// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductsAdapter extends TypeAdapter<Products> {
  @override
  final int typeId = 3;

  @override
  Products read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Products(
      name: fields[0] as String,
      path: fields[1] as String,
      id: fields[2] as String,
      childProducts: (fields[3] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, Products obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.childProducts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
