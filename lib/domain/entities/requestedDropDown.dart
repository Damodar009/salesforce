import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:salesforce/domain/entities/productName.dart';

part 'requestedDropDown.g.dart';

@HiveType(typeId: 16)
class RequestedDropDown extends Equatable {
  @HiveField(0)
  final String retailerName;
  @HiveField(1)
  final List<ProductName> productName;
  const RequestedDropDown(
      {required this.retailerName, required this.productName});

  @override
  // TODO: implement props
  List<Object?> get props => [retailerName, productName];
}
