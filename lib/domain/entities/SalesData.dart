import 'package:equatable/equatable.dart';
import 'package:salesforce/data/models/RetailerModel.dart';
import 'package:salesforce/data/models/returnModel.dart';
import '../../data/models/AvailabilityModel.dart';
import '../../data/models/SalesModel.dart';

class SalesData extends Equatable {
  final List<SalesModel> sales;
  final List<AvailabilityModel> availability;
  final List<ReturnsModel> returns;
  final String salesDescription;
  final String returnedDescription;
  final String stockDescription;
  final String availabilityDescription;
  final String assignedDepot;
  final String collectionDate;
  final double latitude;
  final double longitude;
  final String? retailer;
  final String paymentType;
  final String paymentdocument;
  final String userId;
  final RetailerModel retiler;
  SalesData(
      {required this.sales,
      required this.availability,
      required this.returns,
      required this.salesDescription,
      required this.returnedDescription,
      required this.stockDescription,
      required this.availabilityDescription,
      required this.assignedDepot,
      required this.collectionDate,
      required this.latitude,
      required this.longitude,
      this.retailer,
      required this.paymentType,
      required this.paymentdocument,
      required this.userId,
      required this.retiler});
  @override
  List<Object?> get props => [sales, availability, returns];
}
