// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'returns.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReturnsAdapter extends TypeAdapter<Returns> {
  @override
  final int typeId = 11;

  @override
  Returns read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Returns(
      returned: fields[0] as int,
      product: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Returns obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.returned)
      ..writeByte(1)
      ..write(obj.product);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReturnsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
