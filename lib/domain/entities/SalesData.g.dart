// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SalesData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalesDataAdapter extends TypeAdapter<SalesData> {
  @override
  final int typeId = 9;

  @override
  SalesData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalesData(
      sales: (fields[0] as List?)?.cast<Sales>(),
      availability: (fields[1] as List?)?.cast<Availability>(),
      returns: (fields[2] as List?)?.cast<Returns>(),
      salesDescription: fields[3] as String?,
      returnedDescription: fields[4] as String?,
      availabilityDescription: fields[5] as String?,
      assignedDepot: fields[6] as String,
      collectionDate: fields[7] as String,
      latitude: fields[8] as double,
      longitude: fields[9] as double,
      retailer: fields[10] as String?,
      paymentType: fields[11] as String?,
      paymentdocument: fields[12] as String?,
      userId: fields[13] as String,
      retailerPojo: fields[14] as Retailer?,
      merchandiseOrderPojo: fields[15] as MerchandiseOrder?,
    );
  }

  @override
  void write(BinaryWriter writer, SalesData obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.sales)
      ..writeByte(1)
      ..write(obj.availability)
      ..writeByte(2)
      ..write(obj.returns)
      ..writeByte(3)
      ..write(obj.salesDescription)
      ..writeByte(4)
      ..write(obj.returnedDescription)
      ..writeByte(5)
      ..write(obj.availabilityDescription)
      ..writeByte(6)
      ..write(obj.assignedDepot)
      ..writeByte(7)
      ..write(obj.collectionDate)
      ..writeByte(8)
      ..write(obj.latitude)
      ..writeByte(9)
      ..write(obj.longitude)
      ..writeByte(10)
      ..write(obj.retailer)
      ..writeByte(11)
      ..write(obj.paymentType)
      ..writeByte(12)
      ..write(obj.paymentdocument)
      ..writeByte(13)
      ..write(obj.userId)
      ..writeByte(14)
      ..write(obj.retailerPojo)
      ..writeByte(15)
      ..write(obj.merchandiseOrderPojo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalesDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
