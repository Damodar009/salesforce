import 'package:hive/hive.dart';
part 'returns.g.dart';
@HiveType(typeId: 11)
class Returns {
  @HiveField(0)
  final int returned;
  @HiveField(1)
  final String product;
  Returns({required this.returned, required this.product});
}
