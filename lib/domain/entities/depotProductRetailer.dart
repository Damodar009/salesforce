import 'package:equatable/equatable.dart';
import 'package:salesforce/domain/entities/products.dart';
import 'package:salesforce/domain/entities/retailerDropDown.dart';
import 'package:salesforce/domain/entities/retailerType.dart';

import 'depot.dart';

class DepotProductRetailer extends Equatable {
  final List<Products> products;
  final List<RetailerType> retailerType;
  final List<Depot> depots;
  final List<RetailerDropDown> retailerDropDown;
  final List<RetailerDropDown> region;
  final List<RetailerDropDown> merchandise;

  DepotProductRetailer(
      {required this.region,
      required this.merchandise,
      required this.products,
      required this.retailerType,
      required this.depots,
      required this.retailerDropDown});

  @override
  List<Object?> get props => [products, retailerType, depots, retailerDropDown];
}
//
// "merchandiseDropDown": [
// {
// "name": "Banner",
// "id": "NGBifEuwYylJoyRt7a8bkA=="
// },
// {
// "name": "No Banner1",
// "id": "ZRlecVfxmjPY1xs!@sHCIgXP2Q=="
// }
// ]

// "regionDropDown": [
// {
// "name": "Jhapa",
// "id": "NGBifEuwYylJoyRt7a8bkA=="
// },
// {
// "name": "Jhapa123",
// "id": "506buVWacVShn32ccOHCTw=="
// },
// {
// "name": "new region",
// "id": "qPWtEiyT68yE6UxLJU21Hw=="
// }
// ],

// todo add
