// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saleslocationTrack.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalesLocationTrackAdapter extends TypeAdapter<SalesLocationTrack> {
  @override
  final int typeId = 2;

  @override
  SalesLocationTrack read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalesLocationTrack(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
      trackingDate: fields[2] as String,
      userId: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SalesLocationTrack obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.trackingDate)
      ..writeByte(3)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalesLocationTrackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
