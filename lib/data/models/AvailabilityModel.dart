import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/availability.dart';
part 'AvailabilityModel.g.dart';

@JsonSerializable()
class AvailabilityModel extends Availability {
  AvailabilityModel({required int stock, required bool availability})
      : super(stock: stock, availability: availability);

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityModelFromJson(json);

  Map<String, dynamic> toJson() => _$AvailabilityModelToJson(this);
}
