import 'package:equatable/equatable.dart';
import 'package:salesforce/data/models/RetailerModel.dart';
import 'package:salesforce/data/models/merchandiseOrderModel.dart';
import 'package:salesforce/data/models/returnModel.dart';
import '../../data/models/AvailabilityModel.dart';
import '../../data/models/SalesModel.dart';

class SalesData extends Equatable {
  final List<SalesModel>? sales;
  final List<AvailabilityModel>? availability;
  final List<ReturnsModel>? returns;
  final String? salesDescription;
  final String? returnedDescription;
  final String? availabilityDescription;
  final String assignedDepot;
  final String collectionDate;
  final double latitude;
  final double longitude;
  final String? retailer;
  final String? paymentType;
  final String? paymentdocument;
  final String userId;
  final RetailerModel? retailerPojo;
  final MerchandiseOrderModel? merchandiseOrderPojo;
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
}
