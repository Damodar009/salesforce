import 'package:hive/hive.dart';

part 'availability.g.dart';

@HiveType(typeId: 13)
class Availability {
  @HiveField(0)
  final int stock;
  @HiveField(1)
  final bool availability;
  @HiveField(2)
  final String? product;
  Availability({required this.stock, required this.availability, this.product});
}
