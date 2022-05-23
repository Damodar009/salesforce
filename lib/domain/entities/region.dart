import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'region.g.dart';

@HiveType(typeId: 7)
class RegionDropDown extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String id;
  RegionDropDown({required this.name, required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [name, id];
}
