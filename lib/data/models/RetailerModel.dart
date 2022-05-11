import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/retailer.dart';

part 'RetailerModel.g.dart';

@JsonSerializable()
class RetailerModel extends Retailer {
  RetailerModel(
      {required String name,
      required double latitude,
      required double longitude,
      required String address,
      required String contactPerson,
      required String contactNumber,
      required String retailerClass,
      required String retailerType,
      required String region})
      : super(
            name: name,
            latitude: latitude,
            longitude: longitude,
            address: address,
            contactPerson: contactPerson,
            contactNumber: contactNumber,
            retailerClass: retailerClass,
            retailerType: retailerType,
            region: region);

  factory RetailerModel.fromJson(Map<String, dynamic> json) =>
      _$RetailerModelFromJson(json);

  Map<String, dynamic> toJson() => _$RetailerModelToJson(this);
}
