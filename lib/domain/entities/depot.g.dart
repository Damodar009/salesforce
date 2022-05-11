// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'depot.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DepotAdapter extends TypeAdapter<Depot> {
  @override
  final int typeId = 4;

  @override
  Depot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Depot(
      id: fields[1] as String,
      name: fields[0] as String,
      longitude: fields[2] as double,
      latitude: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Depot obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.longitude)
      ..writeByte(3)
      ..write(obj.latitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DepotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
