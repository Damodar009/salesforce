// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegionDropDownAdapter extends TypeAdapter<RegionDropDown> {
  @override
  final int typeId = 7;

  @override
  RegionDropDown read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegionDropDown(
      name: fields[0] as String,
      id: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RegionDropDown obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegionDropDownAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}