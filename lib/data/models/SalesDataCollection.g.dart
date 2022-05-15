// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SalesDataCollection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesDataCollectionModel _$SalesDataCollectionModelFromJson(
        Map<String, dynamic> json) =>
    SalesDataCollectionModel(
      json['retailer'] as String,
      collectionData: json['collectionData'] as String,
      sales: json['sales'] as int,
      salesDescription: json['salesDescription'] as String,
      returned: json['returned'] as String,
      returnedDescription: json['returnedDescription'] as String,
      stock: json['stock'] as int,
      stockDescription: json['stockDescription'] as String,
      availability: json['availability'] as bool,
      availabilityDescriptionl: json['availabilityDescriptionl'] as String,
      product: json['product'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      paymentType: json['paymentType'] as String,
      paymentDocument: json['paymentDocument'] as String,
      userId: json['userId'] as String,
      assignedDepot: json['assignedDepot'] as String,
      retailerPojo: RetailerPojoModel.fromJson(
          json['retailerPojo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SalesDataCollectionModelToJson(
        SalesDataCollectionModel instance) =>
    <String, dynamic>{
      'assignedDepot': instance.assignedDepot,
      'collectionData': instance.collectionData,
      'sales': instance.sales,
      'salesDescription': instance.salesDescription,
      'returned': instance.returned,
      'returnedDescription': instance.returnedDescription,
      'stock': instance.stock,
      'stockDescription': instance.stockDescription,
      'availability': instance.availability,
      'availabilityDescriptionl': instance.availabilityDescriptionl,
      'product': instance.product,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'retailer': instance.retailer,
      'paymentType': instance.paymentType,
      'paymentDocument': instance.paymentDocument,
      'userId': instance.userId,
      'retailerPojo': instance.retailerPojo,
    };
