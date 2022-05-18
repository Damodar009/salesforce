import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/userDetail.dart';

part 'userDetailModel.g.dart';

@JsonSerializable()
class UserDetailsModel extends UserDetails {
  UserDetailsModel(
      {String? fullName,
      String? id,
      String? dob,
      String? gender,
      String? path,
      String? permanentAddress,
      String? temporaryAddress,
      String? userDocument,
      String? user_detail_id,
      String? contactNumber2,
      String? designationId,
      String? employee_contract})
      : super(
            fullName: fullName,
            id: id,
            dob: dob,
            path: path,
            userDocument: userDocument,
            user_detail_id: user_detail_id,
            gender: gender,
            permanentAddress: permanentAddress,
            temporaryAddress: temporaryAddress,
            contactNumber2: contactNumber2,
            designationId: designationId,
            employee_contract: employee_contract);

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsModelToJson(this);
}
