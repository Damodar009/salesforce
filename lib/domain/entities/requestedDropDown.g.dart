// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestedDropDown.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RequestedDropDownAdapter extends TypeAdapter<RequestedDropDown> {
  @override
  final int typeId = 16;

  @override
  RequestedDropDown read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RequestedDropDown(
      retailerName: fields[0] as String,
      productName: (fields[1] as List).cast<ProductName>(),
    );
  }

  @override
  void write(BinaryWriter writer, RequestedDropDown obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.retailerName)
      ..writeByte(1)
      ..write(obj.productName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestedDropDownAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
