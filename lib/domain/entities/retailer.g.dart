// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retailer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RetailerAdapter extends TypeAdapter<Retailer> {
  @override
  final int typeId = 5;

  @override
  Retailer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Retailer(
      name: fields[0] as String,
      latitude: fields[1] as double,
      longitude: fields[2] as double,
      address: fields[3] as String,
      contactPerson: fields[4] as String,
      contactNumber: fields[5] as String,
      retailerClass: fields[6] as String,
      retailerType: fields[7] as String,
      region: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Retailer obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.contactPerson)
      ..writeByte(5)
      ..write(obj.contactNumber)
      ..writeByte(6)
      ..write(obj.retailerClass)
      ..writeByte(7)
      ..write(obj.retailerType)
      ..writeByte(8)
      ..write(obj.region);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RetailerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
