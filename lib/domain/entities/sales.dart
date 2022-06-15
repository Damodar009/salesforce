import 'package:hive/hive.dart';
part 'sales.g.dart';

@HiveType(typeId: 10)
class Sales {
  @HiveField(0)
  final int sales;
  @HiveField(1)
  final String product;
  @HiveField(2)
  final bool orderStatus;
  @HiveField(3)
  final String? requestedDate;
  Sales(
      {required this.orderStatus,
      this.requestedDate,
      required this.sales,
      required this.product});
}
