// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retailerDropDown.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RetailerDropDownAdapter extends TypeAdapter<RetailerDropDown> {
  @override
  final int typeId = 6;

  @override
  RetailerDropDown read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RetailerDropDown(
      name: fields[0] as String,
      latitude: fields[1] as double,
      longitude: fields[2] as double,
      address: fields[3] as String,
      contact_person: fields[4] as String,
      contact_number: fields[5] as String,
      retailer_class: fields[6] as String,
      retailer_type_name: fields[7] as String,
      id: fields[8] as String,
      retailer_type_id: fields[9] as String,
      status: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, RetailerDropDown obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.contact_person)
      ..writeByte(5)
      ..write(obj.contact_number)
      ..writeByte(6)
      ..write(obj.retailer_class)
      ..writeByte(7)
      ..write(obj.retailer_type_name)
      ..writeByte(8)
      ..write(obj.id)
      ..writeByte(9)
      ..write(obj.retailer_type_id)
      ..writeByte(10)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RetailerDropDownAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
