import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/depot.dart';

part 'DepotModel.g.dart';

@JsonSerializable()
class DepotModel extends Depot {
  DepotModel(
      {required String id,
      required String name,
      required double longitude,
      required double latitude})
      : super(id: id, name: name, longitude: longitude, latitude: latitude);

  factory DepotModel.fromJson(Map<String, dynamic> json) =>
      _$DepotModelFromJson(json);

  Map<String, dynamic> toJson() => _$DepotModelToJson(this);
}
