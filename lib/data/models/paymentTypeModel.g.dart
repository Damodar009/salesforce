// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentTypeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTypeModel _$PaymentTypeModelFromJson(Map<String, dynamic> json) =>
    PaymentTypeModel(
      payment_type: json['payment_type'] as String,
      key: json['key'] as String,
    );

Map<String, dynamic> _$PaymentTypeModelToJson(PaymentTypeModel instance) =>
    <String, dynamic>{
      'payment_type': instance.payment_type,
      'key': instance.key,
    };
