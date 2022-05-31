import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/merchandise.dart';

part 'merchandiseModel.g.dart';

@JsonSerializable()
class MerchandiseDropDownModel extends MerchandiseDropDown {
  const MerchandiseDropDownModel({required String name, required String id})
      : super(name: name, id: id);

  factory MerchandiseDropDownModel.fromJson(Map<String, dynamic> json) =>
      _$MerchandiseDropDownModelFromJson(json);

  Map<String, dynamic> toJson() => _$MerchandiseDropDownModelToJson(this);
}
