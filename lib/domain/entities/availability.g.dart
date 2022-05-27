// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AvailabilityAdapter extends TypeAdapter<Availability> {
  @override
  final int typeId = 13;

  @override
  Availability read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Availability(
      stock: fields[0] as int,
      availability: fields[1] as bool,
      product: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Availability obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.stock)
      ..writeByte(1)
      ..write(obj.availability)
      ..writeByte(2)
      ..write(obj.product);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AvailabilityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
