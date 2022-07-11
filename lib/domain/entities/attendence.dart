import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'attendence.g.dart';

@HiveType(typeId: 0)
class Attendence extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? macAddress;
  @HiveField(2)
  final String? checkin;
  @HiveField(3)
  final double? checkin_latitude;
  @HiveField(4)
  final double? checkin_longitude;
  @HiveField(5)
  final String? checkout;
  @HiveField(6)
  final double? checkout_latitude;
  @HiveField(7)
  final double? checkout_longitude;
  @HiveField(8)
  final String? user;

  Attendence(
      {this.id,
      this.macAddress,
      this.checkin,
      this.checkin_latitude,
      this.checkin_longitude,
      this.checkout,
      this.checkout_latitude,
      this.checkout_longitude,
      this.user});

  Attendence copyWith({
    String? id,
    String? macAddress,
    String? checkin,
    double? checkin_latitude,
    double? checkin_longitude,
    String? checkout,
    double? checkout_latitude,
    double? checkout_longitude,
    user,
  }) =>
      Attendence(
          id: id ?? this.id,
          macAddress: macAddress ?? this.macAddress,
          checkin: checkin ?? this.checkin,
          checkin_latitude: checkin_latitude ?? this.checkout_latitude,
          checkin_longitude: checkin_longitude ?? this.checkin_longitude,
          checkout: checkout ?? this.checkout,
          checkout_latitude: checkout_latitude ?? this.checkout_latitude,
          checkout_longitude: checkout_longitude ?? this.checkout_longitude,
          user: user ?? this.user);

  @override
  List<Object?> get props => [
        id,
        macAddress,
        checkin,
        checkin_latitude,
        checkin_longitude,
        checkout,
        checkout_latitude,
        checkout_longitude,
        user
      ];
}
