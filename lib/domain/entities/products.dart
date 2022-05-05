import 'package:equatable/equatable.dart';

class Products extends Equatable {
  final String name;
  final String path;
  final String id;
  final List<Map<String, dynamic>> childProducts;
  Products(
      {required this.name,
      required this.path,
      required this.id,
      required this.childProducts});

  @override
  // TODO: implement props
  List<Object?> get props => [name, path, id, childProducts];
}
