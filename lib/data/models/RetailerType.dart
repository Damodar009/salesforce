import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/retailerType.dart';

part 'RetailerType.g.dart';

@JsonSerializable()
class RetailerTypeModel extends RetailerType {
  RetailerTypeModel(
      {required String name, required String id, required bool status})
      : super(name: name, id: id, status: status);

  factory RetailerTypeModel.fromJson(Map<String, dynamic> json) =>
      _$RetailerTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RetailerTypeModelToJson(this);
}
