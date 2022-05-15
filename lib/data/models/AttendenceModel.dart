import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/attendence.dart';

part 'AttendenceModel.g.dart';

@JsonSerializable()
class AttendenceModel extends Attendence {
  AttendenceModel(
      {String? id,
      String? macAddress,
      String? checkin,
      double? checkin_latitude,
      double? checkin_longitude,
      String? checkout,
      double? checkout_latitude,
      double? checkout_longitude,
      String? user})
      : super(id, macAddress, checkin, checkin_latitude, checkin_longitude,
            checkout, checkout_latitude, checkout_longitude, user);

  factory AttendenceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendenceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendenceModelToJson(this);
}
