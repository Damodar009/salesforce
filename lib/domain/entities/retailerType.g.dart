// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retailerType.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RetailerTypeAdapter extends TypeAdapter<RetailerType> {
  @override
  final int typeId = 1;

  @override
  RetailerType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RetailerType(
      name: fields[0] as String,
      id: fields[1] as String,
      status: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, RetailerType obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RetailerTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
