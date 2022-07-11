import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/productName.dart';

part 'productNameModel.g.dart';

@JsonSerializable()
class ProductNameModel extends ProductName {
  const ProductNameModel(
      {required int quantity,
      required String requestedDate,
      required String id,
      required String productName})
      : super(
            quantity: quantity,
            requestedDate: requestedDate,
            id: id,
            productName: productName);

  factory ProductNameModel.fromJson(Map<String, dynamic> json) =>
      _$ProductNameModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductNameModelToJson(this);
}
