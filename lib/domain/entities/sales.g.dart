// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalesAdapter extends TypeAdapter<Sales> {
  @override
  final int typeId = 10;

  @override
  Sales read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sales(
      orderStatus: fields[2] as bool,
      requestedDate: fields[3] as String?,
      sales: fields[0] as int,
      product: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Sales obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.sales)
      ..writeByte(1)
      ..write(obj.product)
      ..writeByte(2)
      ..write(obj.orderStatus)
      ..writeByte(3)
      ..write(obj.requestedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
