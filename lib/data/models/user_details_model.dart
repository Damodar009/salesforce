import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/user_details.dart';

part 'user_details_model.g.dart';

@JsonSerializable()

class UserDetailsModel extends UserDetails {
  UserDetailsModel(
      {required String full_name,
      required String gender,
      required String path,
      required String permanent_address,
      required String temporary_address,
      required String user_details_id,
      required String contact_number})
      : super(
            full_name: full_name,
            gender: gender,
            path: path,
            permanent_address: permanent_address,
            temporary_address: temporary_address,
            user_details_id: user_details_id,
            contact_number: contact_number);

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsModelToJson(this);           
}
