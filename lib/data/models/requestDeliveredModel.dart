import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/requestDeliver.dart';

part 'requestDeliveredModel.g.dart';

@JsonSerializable()
class RequestedDeliveredModel extends RequestDelivered {
  RequestedDeliveredModel(String id, String deliveredDate)
      : super(id, deliveredDate);

  factory RequestedDeliveredModel.fromJson(Map<String, dynamic> json) =>
      _$RequestedDeliveredModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestedDeliveredModelToJson(this);
}
