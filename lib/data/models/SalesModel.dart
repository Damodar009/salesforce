import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/sales.dart';

part 'SalesModel.g.dart';

@JsonSerializable()
class SalesModel extends Sales {
  SalesModel(
      {required int sales,
      required String product,
      required bool orderStatus,
      String? requestedDate})
      : super(
            sales: sales,
            orderStatus: orderStatus,
            product: product,
            requestedDate: requestedDate);

  factory SalesModel.fromJson(Map<String, dynamic> json) =>
      _$SalesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesModelToJson(this);
}
