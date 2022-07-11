import 'package:salesforce/data/models/productNameModel.dart';
import 'package:salesforce/domain/entities/productName.dart';
import 'package:salesforce/domain/entities/requestedDropDown.dart';

class RequestedDropDownModel extends RequestedDropDown {
  const RequestedDropDownModel(
      {required String retailerName, required List<ProductName> productName})
      : super(retailerName: retailerName, productName: productName);

  factory RequestedDropDownModel.fromJson(Map<String, dynamic> json) =>
      RequestedDropDownModel(
        retailerName: json["retailer_name"],
        productName: (json["product_name"] as List)
            .map((e) => ProductNameModel.fromJson(e))
            .toList(),
      );
}
