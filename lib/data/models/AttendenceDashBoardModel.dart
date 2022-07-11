import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/AttendendenceDashbard.dart';

part 'AttendenceDashBoardModel.g.dart';

@JsonSerializable()
class AttendanceDashboardModel extends AttendanceDashboard {
  AttendanceDashboardModel(
      double percentile, double present_days, double absent_days)
      : super(percentile, present_days, absent_days);

  factory AttendanceDashboardModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDashboardModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceDashboardModelToJson(this);
}
