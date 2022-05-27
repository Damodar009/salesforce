import 'package:salesforce/data/models/AvailabilityModel.dart';
import 'package:salesforce/data/models/RetailerModel.dart';
import 'package:salesforce/data/models/SalesModel.dart';
import 'package:salesforce/data/models/returnModel.dart';
import 'package:salesforce/domain/entities/SalesData.dart';

import 'merchandiseOrderModel.dart';

class SalesDataModel extends SalesData {
  SalesDataModel({
    List<SalesModel>? salesPojo,
    List<AvailabilityModel>? availabilityPojo,
    List<ReturnsModel>? returnsPojo,
    String? salesDescription,
    String? returnedDescription,
    String? availabilityDescription,
    required String assignedDepot,
    required String collectionDate,
    required double latitude,
    required double longitude,
    String? retailer,
    String? paymentType,
    String? paymentdocument,
    required String userId,
    RetailerModel? retailerPojo,
    MerchandiseOrderModel? merchandiseOrderPojo,
  }) : super(
            sales: salesPojo,
            availability: availabilityPojo,
            returns: returnsPojo,
            salesDescription: salesDescription,
            returnedDescription: returnedDescription,
            availabilityDescription: availabilityDescription,
            assignedDepot: assignedDepot,
            collectionDate: collectionDate,
            latitude: latitude,
            longitude: longitude,
            retailer: retailer,
            paymentType: paymentType,
            paymentdocument: paymentdocument,
            userId: userId,
            retailerPojo: retailerPojo,
            merchandiseOrderPojo: merchandiseOrderPojo);



  factory SalesDataModel.fromJson(Map<String, dynamic> json) => SalesDataModel(
        salesPojo: (json["salesPojo"] as List)
            .map((e) => SalesModel.fromJson(e))
            .toList(),
        availabilityPojo: (json["availabilityPojo"] as List)
            .map((e) => AvailabilityModel.fromJson(e))
            .toList(),
        returnsPojo: (json["returnPojo"] as List)
            .map((e) => ReturnsModel.fromJson(e))
            .toList(),
        salesDescription: json['salesDescription'] as String?,
        returnedDescription: json['returnedDescription'] as String?,
        availabilityDescription: json['availabilityDescription'] as String?,
        assignedDepot: json['assignedDepot'] as String,
        collectionDate: json['collectionDate'] as String,
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
        retailer: json['retailer'] as String?,
        paymentType: json['paymentType'] as String?,
        paymentdocument: json['paymentdocument'] as String?,
        userId: json['userId'] as String,
        retailerPojo: json['retailerPojo'] == null
            ? null
            : RetailerModel.fromJson(
                json['retailerPojo'] as Map<String, dynamic>),
        merchandiseOrderPojo: json['merchandiseOrderPojo'] == null
            ? null
            : MerchandiseOrderModel.fromJson(
                json['merchandiseOrderPojo'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson(SalesDataModel instance) => <String, dynamic>{
        'salesPojo': instance.sales?.map((e) => e.toJson()).toList(),
        'availabilityPojo':
            instance.availability?.map((e) => e.toJson()).toList(),
        'returnPojo': instance.returns?.map((e) => e.toJson()).toList(),
        'salesDescription': instance.salesDescription,
        'returnedDescription': instance.returnedDescription,
        'availabilityDescription': instance.availabilityDescription,
        'assignedDepot': instance.assignedDepot,
        'collectionDate': instance.collectionDate,
        'latitude': instance.latitude,
        'longitude': instance.longitude,
        'retailer': instance.retailer,
        'paymentType': instance.paymentType,
        'paymentdocument': instance.paymentdocument,
        'userId': instance.userId,
        'retailerPojo': instance.retailerPojo?.toJson(),
        'merchandiseOrderPojo': instance.merchandiseOrderPojo?.toJson(),
      };
}
