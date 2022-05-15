import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/data/models/userDetailModel.dart';
import 'package:salesforce/domain/entities/userDetailsData.dart';

part 'userDetailsDataModel.g.dart';

@JsonSerializable()
class UserDetailsDataModel extends UserDetailsData {
  UserDetailsDataModel(
      {String? email,
      String? id,
      String? phoneNumber,
      String? roleId,
      String? roleName,
      bool ? status,
      UserDetailsModel? userDetail})
      : super(
            email: email,
            id: id,
            phoneNumber: phoneNumber,
            roleId: roleId,
            roleName: roleName,
            status: status,
            userDetail: userDetail);

  factory UserDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsDataModelToJson(this);
}
