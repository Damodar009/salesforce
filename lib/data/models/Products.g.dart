// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsModel _$ProductsModelFromJson(Map<String, dynamic> json) =>
    ProductsModel(
      name: json['name'] as String,
      path: json['path'] as String?,
      id: json['id'] as String,
      childProducts: (json['childProducts'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>?)
          .toList(),
    );

Map<String, dynamic> _$ProductsModelToJson(ProductsModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'id': instance.id,
      'childProducts': instance.childProducts,
    };
