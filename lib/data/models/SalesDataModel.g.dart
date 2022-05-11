// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SalesDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesDataModel _$SalesDataModelFromJson(Map<String, dynamic> json) =>
    SalesDataModel(
      sales: (json['sales'] as List<dynamic>)
          .map((e) => SalesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      availability: (json['availability'] as List<dynamic>)
          .map((e) => AvailabilityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      returns: (json['returns'] as List<dynamic>)
          .map((e) => ReturnsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      salesDescription: json['salesDescription'] as String,
      returnedDescription: json['returnedDescription'] as String,
      stockDescription: json['stockDescription'] as String,
      availabilityDescription: json['availabilityDescription'] as String,
      assignedDepot: json['assignedDepot'] as String,
      collectionDate: json['collectionDate'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      paymentType: json['paymentType'] as String,
      paymentdocument: json['paymentdocument'] as String,
      userId: json['userId'] as String,
      retiler: RetailerModel.fromJson(json['retiler'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SalesDataModelToJson(SalesDataModel instance) =>
    <String, dynamic>{
      'sales': instance.sales.map((e) => e.toJson()).toList(),
      'availability': instance.availability.map((e) => e.toJson()).toList(),
      'returns': instance.returns.map((e) => e.toJson()).toList(),
      'salesDescription': instance.salesDescription,
      'returnedDescription': instance.returnedDescription,
      'stockDescription': instance.stockDescription,
      'availabilityDescription': instance.availabilityDescription,
      'assignedDepot': instance.assignedDepot,
      'collectionDate': instance.collectionDate,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'paymentType': instance.paymentType,
      'paymentdocument': instance.paymentdocument,
      'userId': instance.userId,
      'retiler': instance.retiler.toJson(),
    };
