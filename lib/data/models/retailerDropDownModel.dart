import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/retailerDropDown.dart';
part 'retailerDropDownModel.g.dart';

@JsonSerializable()
class RetailerDropDownModel extends RetailerDropDown {
  RetailerDropDownModel(
      {required String name,
      required double latitude,
      required double longitude,
      required String address,
      required String contact_person,
      required String contact_number,
      required String retailer_class,
      required String retailer_type_name,
      required String id,
      required String retailer_type_id,
      required bool status})
      : super(
            name: name,
            latitude: latitude,
            longitude: longitude,
            address: address,
            contact_person: contact_person,
            contact_number: contact_number,
            retailer_class: retailer_class,
            retailer_type_name: retailer_type_name,
            id: id,
            retailer_type_id: retailer_type_id,
            status: status);

  factory RetailerDropDownModel.fromJson(Map<String, dynamic> json) =>
      _$RetailerDropDownModelFromJson(json);

  Map<String, dynamic> toJson() => _$RetailerDropDownModelToJson(this);
}
