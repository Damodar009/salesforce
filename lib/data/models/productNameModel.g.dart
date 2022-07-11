// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productNameModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductNameModel _$ProductNameModelFromJson(Map<String, dynamic> json) =>
    ProductNameModel(
      quantity: json['quantity'] as int,
      requestedDate: json['requestedDate'] as String,
      id: json['id'] as String,
      productName: json['productName'] as String,
    );

Map<String, dynamic> _$ProductNameModelToJson(ProductNameModel instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'requestedDate': instance.requestedDate,
      'id': instance.id,
      'productName': instance.productName,
    };
