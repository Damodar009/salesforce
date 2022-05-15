import 'package:equatable/equatable.dart';
import 'package:salesforce/domain/entities/retailerPojo.dart';

import '../../data/models/RetailerPojo.dart';

class SalesDataCollection extends Equatable {
  final String assignedDepot;
  final String collectionData;
  final int sales;
  final String salesDescription;
  final String returned;
  final String returnedDescription;
  final int stock;
  final String stockDescription;
  final bool availability;
  final String availabilityDescriptionl;
  final String product;
  final double latitude;
  final double longitude;
  final String retailer;
  final String paymentType;
  final String paymentDocument;
  final String userId;
  final RetailerPojoModel retailerPojo;

  const SalesDataCollection(
    this.retailer,  {
    required this.collectionData,
    required this.sales,
    required this.salesDescription,
    required this.returned,
    required this.returnedDescription,
    required this.stock,
    required this.stockDescription,
    required this.availability,
    required this.availabilityDescriptionl,
    required this.product,
    required this.latitude,
    required this.longitude,
    required this.paymentType,
    required this.paymentDocument,
    required this.userId,
    required this.assignedDepot,
    required this.retailerPojo,
  });
  @override
  // TODO: implement props
  List<Object> get props => [
        collectionData,
        sales,
        salesDescription,
        returned,
        returnedDescription,
        stock,
        stockDescription,
        availability,
        availabilityDescriptionl,
        product,
        latitude,
        longitude,
        retailer,
        paymentType,
        paymentDocument,
        userId,
        assignedDepot,
        retailerPojo
      ];
}
