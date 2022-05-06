import 'package:equatable/equatable.dart';

class SalesLocationTrack extends Equatable {
  final double latitude;
  final double longitude;
  final String trackingDate;
  final String userId;

  SalesLocationTrack(
      this.latitude, this.longitude, this.trackingDate, this.userId);

  @override
  List<Object?> get props => [latitude, longitude, trackingDate, userId];
}
