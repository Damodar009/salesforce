import 'package:equatable/equatable.dart';
import 'package:salesforce/domain/entities/products.dart';
import 'package:salesforce/domain/entities/retailerType.dart';

import 'depot.dart';

class DepotProductRetailer extends Equatable {
  final List<Products> products;
  final List<RetailerType> retailerType;
  final List<Depot> depots;
  DepotProductRetailer(
      {required this.products,
      required this.retailerType,
      required this.depots});

  @override

  List<Object?> get props => [products , retailerType , depots];
}
