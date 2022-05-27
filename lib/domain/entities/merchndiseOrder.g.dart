// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchndiseOrder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MerchandiseOrderAdapter extends TypeAdapter<MerchandiseOrder> {
  @override
  final int typeId = 12;

  @override
  MerchandiseOrder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MerchandiseOrder(
      image: fields[0] as String,
      description: fields[1] as String,
      merchandise_id: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MerchandiseOrder obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.merchandise_id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchandiseOrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
