import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/returns.dart';
part 'returnModel.g.dart';

@JsonSerializable()
class ReturnsModel extends Returns {
  ReturnsModel({required int returned, required String product})
      : super(returned: returned, product: product);
  factory ReturnsModel.fromJson(Map<String, dynamic> json) =>
      _$ReturnsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnsModelToJson(this);
}
