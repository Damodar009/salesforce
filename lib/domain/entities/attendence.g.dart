// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendence.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendenceAdapter extends TypeAdapter<Attendence> {
  @override
  final int typeId = 0;

  @override
  Attendence read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Attendence(
      id: fields[0] as String?,
      macAddress: fields[1] as String?,
      checkin: fields[2] as String?,
      checkin_latitude: fields[3] as double?,
      checkin_longitude: fields[4] as double?,
      checkout: fields[5] as String?,
      checkout_latitude: fields[6] as double?,
      checkout_longitude: fields[7] as double?,
      user: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Attendence obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.macAddress)
      ..writeByte(2)
      ..write(obj.checkin)
      ..writeByte(3)
      ..write(obj.checkin_latitude)
      ..writeByte(4)
      ..write(obj.checkin_longitude)
      ..writeByte(5)
      ..write(obj.checkout)
      ..writeByte(6)
      ..write(obj.checkout_latitude)
      ..writeByte(7)
      ..write(obj.checkout_longitude)
      ..writeByte(8)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
