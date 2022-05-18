import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/data/models/userDetailModel.dart';
import 'package:salesforce/domain/entities/saveUserDetailsData.dart';

part 'SaveUserDetailsDataModel.g.dart';

@JsonSerializable()
class SaveUserDetailsDataModel extends SaveUserDetailsData {
  SaveUserDetailsDataModel(
      {String? id,
      String? email,
      String? phoneNumber,
      String? password,
      String? roleId,
      String? roleName,
      UserDetailsModel? userDetail})
      : super(
            id: id,
            email: email,
            phoneNumber: phoneNumber,
            password: password,
            roleId: roleId,
            userDetail: userDetail,
            roleName: roleName);

  factory SaveUserDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      _$SaveUserDetailsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$SaveUserDetailsDataModelToJson(this);
}
