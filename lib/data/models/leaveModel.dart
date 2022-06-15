import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/Leave.dart';

part 'leaveModel.g.dart';

@JsonSerializable()
class LeaveModel extends Leave {
  LeaveModel(
      {required String fromDate,
      required String toDate,
      required String userId,
      required String reason})
      : super(
            fromDate: fromDate, toDate: toDate, userId: userId, reason: reason);

  factory LeaveModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveModelToJson(this);
}
