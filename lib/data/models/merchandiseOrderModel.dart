import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/merchndiseOrder.dart';

part 'merchandiseOrderModel.g.dart';

@JsonSerializable()
class MerchandiseOrderModel extends MerchandiseOrder {
  MerchandiseOrderModel(
      {required String image,
      required String description,
      required String merchandise_id})
      : super(
            image: image,
            description: description,
            merchandise_id: merchandise_id);

  factory MerchandiseOrderModel.fromJson(Map<String, dynamic> json) =>
      _$MerchandiseOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$MerchandiseOrderModelToJson(this);
}
