import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'retailerDropDown.g.dart';

@HiveType(typeId: 6)
class RetailerDropDown extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double latitude;
  @HiveField(2)
  final double longitude;
  @HiveField(3)
  final String address;
  @HiveField(4)
  final String contact_person;
  @HiveField(5)
  final String contact_number;
  @HiveField(6)
  final String retailer_class;
  @HiveField(7)
  final String retailer_type_name;
  @HiveField(8)
  final String id;
  @HiveField(9)
  final String retailer_type_id;
  @HiveField(10)
  final bool status;

  RetailerDropDown(
      {required this.name,
      required this.latitude,
      required this.longitude,
      required this.address,
      required this.contact_person,
      required this.contact_number,
      required this.retailer_class,
      required this.retailer_type_name,
      required this.id,
      required this.retailer_type_id,
      required this.status});

  @override
  List<Object?> get props => [
        name,
        latitude,
        longitude,
        address,
        contact_person,
        contact_number,
        retailer_type_id,
        retailer_class,
        retailer_type_name,
        id,
        status
      ];

  // @override
  // List<Object> get props => [
  //   name,
  //   latitude,
  //   longitude,
  //   address,
  //   contactPerson,
  //   contactNumber,
  //   retailerClass,
  //   retailerType,
  //   region
  // ];
}
