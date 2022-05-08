import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/data/models/userDetailModel.dart';
import 'package:salesforce/domain/entities/userDetailsData.dart';

part 'userDetailsDataModel.g.dart';

@JsonSerializable()
class UserDetailsDataModel extends UserDetailsData {
  UserDetailsDataModel(
      {required String email,
      required String id,
      required String phone_number,
      required String role_id,
      required String role_name,
      required bool status,
      required UserDetailsModel userDetail})
      : super(
            email: email,
            id: id,
            phone_number: phone_number,
            role_id: role_id,
            role_name: role_name,
            status: status,
            userDetail: userDetail);

  factory UserDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsDataModelToJson(this);
}
