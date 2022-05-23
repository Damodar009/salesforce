import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'retailer.g.dart';

@HiveType(typeId: 5)
class Retailer extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double latitude;
  @HiveField(2)
  final double longitude;
  @HiveField(3)
  final String address;
  @HiveField(4)
  final String contactPerson;
  @HiveField(5)
  final String contactNumber;
  @HiveField(6)
  final String retailerClass;
  @HiveField(7)
  final String retailerType;
  @HiveField(8)
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
