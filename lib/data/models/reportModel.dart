import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/report.dart';

part 'reportModel.g.dart';

@JsonSerializable()
class ReportModel extends Report {
  ReportModel(String date, int quantity) : super(date, quantity);

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}
