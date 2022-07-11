import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'productName.g.dart';

@HiveType(typeId: 15)
class ProductName extends Equatable {
  @HiveField(0)
  final int quantity;
  @HiveField(1)
  final String requestedDate;
  @HiveField(2)
  final String id;
  @HiveField(3)
  final String productName;
  const ProductName(
      {required this.quantity,
      required this.requestedDate,
      required this.id,
      required this.productName});

  @override
  List<Object?> get props => [quantity, requestedDate, id, productName];
}
