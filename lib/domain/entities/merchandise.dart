import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'merchandise.g.dart';

@HiveType(typeId: 8)
class MerchandiseDropDown extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String id;
  MerchandiseDropDown({required this.name, required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [name, id];
}
