// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SalesModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesModel _$SalesModelFromJson(Map<String, dynamic> json) => SalesModel(
      sales: json['sales'] as int,
      product: json['product'] as String,
      orderStatus: json['orderStatus'] as bool,
      requestedDate: json['requestedDate'] as String?,
    );

Map<String, dynamic> _$SalesModelToJson(SalesModel instance) =>
    <String, dynamic>{
      'sales': instance.sales,
      'product': instance.product,
      'orderStatus': instance.orderStatus,
      'requestedDate': instance.requestedDate,
    };
