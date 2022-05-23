import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/region.dart';

part 'regionModel.g.dart';

@JsonSerializable()
class RegionDropDownModel extends RegionDropDown {
  RegionDropDownModel({required String name, required String id})
      : super(name: name, id: id);

  factory RegionDropDownModel.fromJson(Map<String, dynamic> json) =>
      _$RegionDropDownModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegionDropDownModelToJson(this);
}
