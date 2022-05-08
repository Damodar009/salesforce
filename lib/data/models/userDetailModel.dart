import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/userDetail.dart';

part 'userDetailModel.g.dart';

@JsonSerializable()
class UserDetailsModel extends UserDetails {
  UserDetailsModel(
      {required String full_name,
      required String gender,
      required String path,
      required String permanent_address,
      required String temporary_address,
      required String user_detail_id,
      required String contact_number2})
      : super(
            full_name: full_name,
            gender: gender,
            path: path,
            permanent_address: permanent_address,
            temporary_address: temporary_address,
            user_detail_id: user_detail_id,
            contact_number2: contact_number2);

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsModelToJson(this);
}
