// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productName.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductNameAdapter extends TypeAdapter<ProductName> {
  @override
  final int typeId = 15;

  @override
  ProductName read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductName(
      quantity: fields[0] as int,
      requestedDate: fields[1] as String,
      id: fields[2] as String,
      productName: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductName obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.quantity)
      ..writeByte(1)
      ..write(obj.requestedDate)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.productName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
