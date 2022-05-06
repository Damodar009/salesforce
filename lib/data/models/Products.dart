import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/products.dart';

part 'Products.g.dart';

@JsonSerializable()
class ProductsModel extends Products {
  ProductsModel(
      {required String name,
      required String path,
      required String id,
      required List<Map<String, dynamic>> childProducts})
      : super(name: name, path: path, id: id, childProducts: childProducts);

  factory ProductsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsModelToJson(this);
}
