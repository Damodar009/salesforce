import 'package:hive/hive.dart';
part 'sales.g.dart';

@HiveType(typeId: 10)
class Sales {
  @HiveField(0)
  final int sales;
  @HiveField(1)
  final String product;
  Sales({required this.sales, required this.product});
}
