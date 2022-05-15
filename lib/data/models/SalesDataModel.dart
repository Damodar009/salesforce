import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/data/models/AvailabilityModel.dart';
import 'package:salesforce/data/models/RetailerModel.dart';
import 'package:salesforce/data/models/SalesModel.dart';
import 'package:salesforce/data/models/returnModel.dart';
import 'package:salesforce/domain/entities/SalesData.dart';
import 'package:salesforce/domain/entities/availability.dart';
import 'package:salesforce/domain/entities/returns.dart';
import 'package:salesforce/domain/entities/sales.dart';

part 'SalesDataModel.g.dart';

@JsonSerializable(explicitToJson: true)
class SalesDataModel extends SalesData {
  SalesDataModel(
      {required List<SalesModel> sales,
      required List<AvailabilityModel> availability,
      required List<ReturnsModel> returns,
      required String salesDescription,
      required String returnedDescription,
      required String stockDescription,
      required String availabilityDescription,
      required String assignedDepot,
      required String collectionDate,
      required double latitude,
      required double longitude,
      required String paymentType,
      required String paymentdocument,
      required String userId,
      required RetailerModel retiler})
      : super(
            sales: sales,
            availability: availability,
            returns: returns,
            salesDescription: salesDescription,
            returnedDescription: returnedDescription,
            stockDescription: stockDescription,
            availabilityDescription: availabilityDescription,
            assignedDepot: assignedDepot,
            collectionDate: collectionDate,
            latitude: latitude,
            longitude: longitude,
            paymentType: paymentType,
            paymentdocument: paymentdocument,
            userId: userId,
            retiler: retiler);

  factory SalesDataModel.fromJson(Map<String, dynamic> json) =>
      _$SalesDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesDataModelToJson(this);
}
