// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestDeliver.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RequestDeliveredAdapter extends TypeAdapter<RequestDelivered> {
  @override
  final int typeId = 19;

  @override
  RequestDelivered read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RequestDelivered(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RequestDelivered obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.deliveredDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestDeliveredAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
