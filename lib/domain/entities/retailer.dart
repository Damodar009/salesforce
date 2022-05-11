import 'package:equatable/equatable.dart';

class Retailer extends Equatable {
  final String name;
  final double latitude;
  final double longitude;
  final String address;
  final String contactPerson;
  final String contactNumber;
  final String retailerClass;
  final String retailerType;
  final String region;
  const Retailer(
      {required this.name,
      required this.latitude,
      required this.longitude,
      required this.address,
      required this.contactPerson,
      required this.contactNumber,
      required this.retailerClass,
      required this.retailerType,
      required this.region});
  @override
  List<Object> get props => [
        name,
        latitude,
        longitude,
        address,
        contactPerson,
        contactNumber,
        retailerClass,
        retailerType,
        region
      ];
}
