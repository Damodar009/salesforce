import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'products.g.dart';

@HiveType(typeId: 3)
class Products extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String? path;
  @HiveField(2)
  final String id;
  @HiveField(3)
  final List<Map<String, dynamic>?> childProducts;
  Products(
      {required this.name,
      this.path,
      required this.id,
      required this.childProducts});

  @override
  // TODO: implement props
  List<Object?> get props => [name, path, id, childProducts];
}
