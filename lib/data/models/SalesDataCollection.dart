import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/data/models/RetailerPojo.dart';
import 'package:salesforce/domain/entities/sales_data_collection.dart';

part 'SalesDataCollection.g.dart';

@JsonSerializable()

class SalesDataCollectionModel extends SalesDataCollection {
  SalesDataCollectionModel(String retailer,
      {required String collectionData,
      required int sales,
      required String salesDescription,
      required String returned,
      required String returnedDescription,
      required int stock,
      required String stockDescription,
      required bool availability,
      required String availabilityDescriptionl,
      required String product,
      required double latitude,
      required double longitude,
      required String paymentType,
      required String paymentDocument,
      required String userId,
      required String assignedDepot,
      required RetailerPojoModel retailerPojo})
      : super(retailer,
            collectionData: collectionData,
            sales: sales,
            salesDescription: salesDescription,
            returned: returned,
            returnedDescription: returnedDescription,
            stock: stock,
            stockDescription: stockDescription,
            availability: availability,
            availabilityDescriptionl: availabilityDescriptionl,
            product: product,
            latitude: latitude,
            longitude: longitude,
            paymentType: paymentType,
            paymentDocument: paymentDocument,
            userId: userId,
            assignedDepot: assignedDepot,
            retailerPojo: retailerPojo);

  factory SalesDataCollectionModel.fromJson(Map<String, dynamic> json) =>
      _$SalesDataCollectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesDataCollectionModelToJson(this);             
}
