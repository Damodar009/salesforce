import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/data/models/RetailerModel.dart';
import 'package:salesforce/data/models/merchandiseOrderModel.dart';
import 'package:salesforce/data/models/returnModel.dart';
import 'package:salesforce/domain/entities/retailer.dart';
import 'package:salesforce/domain/entities/returns.dart';
import 'package:salesforce/domain/entities/sales.dart';
import '../../data/models/AvailabilityModel.dart';
import '../../data/models/SalesModel.dart';
import 'availability.dart';
import 'merchndiseOrder.dart';

part 'SalesData.g.dart';

@JsonSerializable()
@HiveType(typeId: 9)
class SalesData extends Equatable {
  @HiveField(0)
  final List<Sales>? sales;
  @HiveField(1)
  final List<Availability>? availability;
  @HiveField(2)
  final List<Returns>? returns;
  @HiveField(3)
  final String? salesDescription;
  @HiveField(4)
  final String? returnedDescription;
  @HiveField(5)
  final String? availabilityDescription;
  @HiveField(6)
  final String assignedDepot;
  @HiveField(7)
  final String collectionDate;
  @HiveField(8)
  final double latitude;
  @HiveField(9)
  final double longitude;
  @HiveField(10)
  final String? retailer;

  @HiveField(11)
  final String? paymentType;
  @HiveField(12)
  final String? paymentdocument;
  @HiveField(13)
  final String userId;
  @HiveField(14)
  final Retailer? retailerPojo;
  @HiveField(15)
  final MerchandiseOrder? merchandiseOrderPojo;
  SalesData(
      {this.sales,
      this.availability,
      this.returns,
      this.salesDescription,
      this.returnedDescription,
      this.availabilityDescription,
      required this.assignedDepot,
      required this.collectionDate,
      required this.latitude,
      required this.longitude,
      this.retailer,
      this.paymentType,
      this.paymentdocument,
      required this.userId,
      this.retailerPojo,
      this.merchandiseOrderPojo});

  SalesData copyWith({
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
    return SalesData(
        sales: salesPojo ?? sales,
        availability: availabilityPojo ?? availability,
        returns: returnsPojo ?? returns,
        salesDescription: salesDescription ?? this.salesDescription,
        returnedDescription: returnedDescription ?? this.returnedDescription,
        availabilityDescription:
            availabilityDescription ?? this.availabilityDescription,
        longitude: longitude ?? this.longitude,
        assignedDepot: assignedDepot ?? this.assignedDepot,
        retailer: retailer ?? this.retailer,
        paymentType: paymentType ?? this.paymentType,
        paymentdocument: paymentdocument ?? this.paymentdocument,
        retailerPojo: retailerPojo ?? this.retailerPojo,
        merchandiseOrderPojo: merchandiseOrderPojo ?? this.merchandiseOrderPojo,
        userId: userId ?? this.userId,
        latitude: latitude ?? this.latitude,
        collectionDate: collectionDate ?? this.collectionDate);
  }

  @override
  List<Object?> get props => [
        sales,
        availability,
        returns,
        salesDescription,
        returnedDescription,
        availabilityDescription,
        assignedDepot,
        collectionDate,
        latitude,
        longitude,
        retailer,
        paymentType,
        paymentdocument,
        userId,
        retailerPojo,
        merchandiseOrderPojo
      ];

  // factory SalesData.fromJson(Map<String, dynamic> json) =>
  //     _$SalesDataFromJson(json);

  // Map<String, dynamic> toJson() => _$SalesDataToJson(this);
}
