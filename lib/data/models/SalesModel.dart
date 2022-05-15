import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/sales.dart';

part 'SalesModel.g.dart';

@JsonSerializable()
class SalesModel extends Sales {
  SalesModel({required int sales, required String product})
      : super(sales: sales, product: product);

  factory SalesModel.fromJson(Map<String, dynamic> json) =>
      _$SalesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesModelToJson(this);
}
