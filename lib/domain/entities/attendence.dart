import 'package:equatable/equatable.dart';

class Attendence extends Equatable {
  final String? id;
  final String? macAddress;
  final String? checkin;
  final double? checkin_latitude;
  final double? checkin_longitude;
  final String? checkout;
  final double? checkout_latitude;
  final double? checkout_longitude;
  final String? user;

  Attendence(
      this.id,
      this.macAddress,
      this.checkin,
      this.checkin_latitude,
      this.checkin_longitude,
      this.checkout,
      this.checkout_latitude,
      this.checkout_longitude,
      this.user);

  @override
  // TODO: implement props
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
