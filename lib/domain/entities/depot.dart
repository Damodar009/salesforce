import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'depot.g.dart';

@HiveType(typeId: 4)
class Depot extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final double longitude;
  @HiveField(3)
  final double latitude;
  Depot(
      {required this.id,
      required this.name,
      required this.longitude,
      required this.latitude});
  @override
  List<Object?> get props => [name, id, longitude, latitude];
}
