import 'package:json_annotation/json_annotation.dart';

import 'package:salesforce/domain/entities/retailerPojo.dart';

part 'RetailerPojo.g.dart';

@JsonSerializable()
class RetailerPojoModel extends RetailerPojo {
  const RetailerPojoModel(
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

  factory RetailerPojoModel.fromJson(Map<String, dynamic> json) =>
      _$RetailerPojoModelFromJson(json);

  Map<String, dynamic> toJson() => _$RetailerPojoModelToJson(this);
}
