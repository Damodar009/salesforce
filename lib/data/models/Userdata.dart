import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/userData.dart';
part 'Userdata.g.dart';

@JsonSerializable()
class UserDataModel extends UserData {
  UserDataModel(
      String? access_token,
      String? token_type,
      String? refresh_token,
      int? expires_in,
      String? scope,
      String? role,
      String? full_name,
      String? name,
      String? userid,
      String? userDetailId)
      : super(access_token, token_type, refresh_token, expires_in, scope, role,
            full_name, name, userid, userDetailId);
  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);
}
