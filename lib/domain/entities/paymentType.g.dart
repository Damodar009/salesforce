// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentType.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentTypeAdapter extends TypeAdapter<PaymentType> {
  @override
  final int typeId = 17;

  @override
  PaymentType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentType(
      payment_type: fields[0] as String,
      key: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentType obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.payment_type)
      ..writeByte(1)
      ..write(obj.key);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
