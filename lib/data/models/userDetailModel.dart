import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/userDetail.dart';

part 'userDetailModel.g.dart';

@JsonSerializable()
class UserDetailsModel extends UserDetails {
  UserDetailsModel(
      {required String fullName,
      DateTime? dob,
      required String gender,
      String? path,
      required String permanentAddress,
      required String temporaryAddress,
      String? userDocument,
      String? user_detail_id,
      required String contactNumber2})
      : super(
            fullName: fullName,
            dob: dob,
            path: path,
            userDocument: userDocument,
            user_detail_id: user_detail_id,
            gender: gender,
            permanentAddress: permanentAddress,
            temporaryAddress: temporaryAddress,
            contactNumber2: contactNumber2);

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsModelToJson(this);
}
