import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/saleslocationTrack.dart';
part 'SalesLocationTrackModel.g.dart';

@JsonSerializable()
class SalesLocationTrackModel extends SalesLocationTrack {
  SalesLocationTrackModel(
      double latitude, double longitude, String trackingDate, String userId)
      : super(latitude, longitude, trackingDate, userId);

  factory SalesLocationTrackModel.fromJson(Map<String, dynamic> json) =>
      _$SalesLocationTrackModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesLocationTrackModelToJson(this);
}
