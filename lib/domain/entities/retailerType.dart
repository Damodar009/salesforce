import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'retailerType.g.dart';

@HiveType(typeId: 1)
class RetailerType extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final bool status;
  RetailerType({required this.name, required this.id, required this.status});

  @override
  // TODO: implement props
  List<Object> get props => [name, id, status];
}
