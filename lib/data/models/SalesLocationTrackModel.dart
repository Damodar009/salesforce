import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/saleslocationTrack.dart';
part 'SalesLocationTrackModel.g.dart';

@JsonSerializable()
class SalesLocationTrackModel extends SalesLocationTrack {
  SalesLocationTrackModel(
      {required double latitude,
      required double longitude,
      required String trackingDate,
      required String userId})
      : super(
            latitude: latitude,
            longitude: longitude,
            trackingDate: trackingDate,
            userId: userId);

  factory SalesLocationTrackModel.fromJson(Map<String, dynamic> json) =>
      _$SalesLocationTrackModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesLocationTrackModelToJson(this);
}
