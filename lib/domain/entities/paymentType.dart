import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'paymentType.g.dart';

@HiveType(typeId: 17)
class PaymentType extends Equatable {
  @HiveField(0)
  String payment_type;
  @HiveField(1)
  String key;

  PaymentType({required this.payment_type, required this.key});

  @override
  // TODO: implement props
  List<Object?> get props => [payment_type, key];
}
