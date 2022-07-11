import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/paymentType.dart';

part 'paymentTypeModel.g.dart';

@JsonSerializable()
class PaymentTypeModel extends PaymentType {
  PaymentTypeModel({required String payment_type, required String key})
      : super(payment_type: payment_type, key: key);

  factory PaymentTypeModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTypeModelToJson(this);
}
