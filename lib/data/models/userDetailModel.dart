import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/userDetail.dart';
part 'userDetailModel.g.dart';

@JsonSerializable()
class UserDetailModel extends UserDetails {
  UserDetailModel(
      {required String fullName,
      required String gender,
      required String dob,
      required String permanentAddress,
      required String temporaryAddress,
      required String contactNumber2})
      : super(
            fullName: fullName,
            gender: gender,
            dob: dob,
            permanentAddress: permanentAddress,
            temporaryAddress: temporaryAddress,
            contactNumber2: contactNumber2);

  factory UserDetailModel.fromJson(Map<String, dynamic> json) =>
      _$UserDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailModelToJson(this);
}
