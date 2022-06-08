import 'package:salesforce/data/models/AvailabilityModel.dart';
import 'package:salesforce/data/models/RetailerModel.dart';
import 'package:salesforce/data/models/RetailerPojo.dart';
import 'package:salesforce/data/models/SalesModel.dart';
import 'package:salesforce/data/models/returnModel.dart';
import 'package:salesforce/domain/entities/SalesData.dart';

import '../../domain/entities/availability.dart';
import '../../domain/entities/merchndiseOrder.dart';
import '../../domain/entities/retailer.dart';
import '../../domain/entities/returns.dart';
import '../../domain/entities/sales.dart';
import 'merchandiseOrderModel.dart';

class SalesDataModel extends SalesData {
  SalesDataModel({
    List<Sales>? salesPojo,
    List<Availability>? availabilityPojo,
    List<Returns>? returnsPojo,
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
    Retailer? retailerPojo,
    MerchandiseOrder? merchandiseOrderPojo,
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

  Map<String, dynamic> toJson(SalesDataModel salesDataModel) =>
      <String, dynamic>{
        'salesPojo': salesDataModel.sales != null
            ? salesDataModel.sales
                ?.map((e) =>
                    SalesModel(sales: e.sales, product: e.product).toJson())
                .toList()
            : [],
        'availabilityPojo': salesDataModel.availability != null
            ? salesDataModel.availability
                ?.map((e) => AvailabilityModel(
                        stock: e.stock,
                        availability: e.availability,
                        product: e.product)
                    .toJson())
                .toList()
            : [],
        'returnPojo': salesDataModel.returns != null
            ? salesDataModel.returns
                ?.map((e) =>
                    ReturnsModel(returned: e.returned, product: e.product)
                        .toJson())
                .toList()
            : [],
        'salesDescription': salesDataModel.salesDescription,
        'returnedDescription': salesDataModel.returnedDescription,
        'availabilityDescription': salesDataModel.availabilityDescription,
        'assignedDepot': salesDataModel.assignedDepot,
        'collectionDate': salesDataModel.collectionDate,
        'latitude': salesDataModel.latitude,
        'longitude': salesDataModel.longitude,
        'retailer': salesDataModel.retailer,
        'paymentType': salesDataModel.paymentType,
        'paymentdocument': salesDataModel.paymentdocument,
        'userId': salesDataModel.userId,
        'retailerPojo': salesDataModel.retailerPojo != null
            ? RetailerPojoModel(
                    name: salesDataModel.retailerPojo!.name,
                    retailerType: salesDataModel.retailerPojo!.retailerType,
                    longitude: salesDataModel.retailerPojo!.longitude,
                    contactPerson: salesDataModel.retailerPojo!.contactPerson,
                    region: salesDataModel.retailerPojo!.region,
                    contactNumber: salesDataModel.retailerPojo!.contactNumber,
                    retailerClass: salesDataModel.retailerPojo!.retailerClass,
                    address: salesDataModel.retailerPojo!.address,
                    latitude: salesDataModel.retailerPojo!.latitude)
                .toJson()
            : null,
        'merchandiseOrderPojo': salesDataModel.merchandiseOrderPojo != null
            ? MerchandiseOrderModel(
                    merchandise_id:
                        salesDataModel.merchandiseOrderPojo!.merchandise_id,
                    description:
                        salesDataModel.merchandiseOrderPojo!.description,
                    image: salesDataModel.merchandiseOrderPojo!.image)
                .toJson()
            : null,
      };

  SalesDataModel copyWith({
    List<SalesModel>? salesPojo,
    List<AvailabilityModel>? availabilityPojo,
    List<ReturnsModel>? returnsPojo,
    String? salesDescription,
    String? returnedDescription,
    String? availabilityDescription,
    String? assignedDepot,
    String? collectionDate,
    double? latitude,
    double? longitude,
    String? retailer,
    String? paymentType,
    String? paymentdocument,
    String? userId,
    RetailerModel? retailerPojo,
    MerchandiseOrderModel? merchandiseOrderPojo,
  }) {
    return SalesDataModel(
        salesPojo: salesPojo,
        availabilityPojo: availabilityPojo,
        returnsPojo: returnsPojo,
        salesDescription: salesDescription ?? this.salesDescription,
        returnedDescription: returnedDescription ?? this.returnedDescription,
        availabilityDescription:
            availabilityDescription ?? this.availabilityDescription,
        longitude: longitude ?? this.longitude,
        assignedDepot: assignedDepot ?? this.assignedDepot,
        retailer: retailer ?? this.retailer,
        paymentType: paymentType ?? this.paymentType,
        paymentdocument: paymentdocument ?? this.paymentdocument,
        retailerPojo: retailerPojo,
        merchandiseOrderPojo: merchandiseOrderPojo,
        userId: userId ?? this.userId,
        latitude: latitude ?? this.latitude,
        collectionDate: collectionDate ?? this.collectionDate);
  }
}
//?.map((e) => e.toJson()).toList(),
