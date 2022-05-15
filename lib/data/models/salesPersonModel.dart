import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/data/models/userDetailModel.dart';
import 'package:salesforce/domain/entities/salesPerson.dart';

part 'salesPersonModel.g.dart';

@JsonSerializable(explicitToJson: true)
class SalesPersonModel extends SalesPerson {
  SalesPersonModel(
      {required String id,
      required String email,
      required String phoneNumber,
      required String password,
      required String roleId,
      required UserDetailsModel userDetails})
      : super(
            id: id,
            email: email,
            phoneNumber: phoneNumber,
            password: password,
            roleId: roleId,
            userDetails: userDetails);

  factory SalesPersonModel.fromJson(Map<String, dynamic> json) =>
      _$SalesPersonModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesPersonModelToJson(this);
}
