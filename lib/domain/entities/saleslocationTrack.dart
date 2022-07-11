import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'saleslocationTrack.g.dart';

@HiveType(typeId: 2)
class SalesLocationTrack extends Equatable {
  @HiveField(0)
  final double latitude;
  @HiveField(1)
  final double longitude;
  @HiveField(2)
  final String trackingDate;
  @HiveField(3)
  final String userId;

  SalesLocationTrack(
      {required this.latitude,
      required this.longitude,
      required this.trackingDate,
      required this.userId});

  SalesLocationTrack copyWith(
          {required double latitude,
          required double longitude,
          String? trackingDate,
          String? userId}) =>
      SalesLocationTrack(
        latitude: latitude,
        userId: userId ?? this.userId,
        longitude: longitude,
        trackingDate: trackingDate ?? this.trackingDate,
      );

  @override
  List<Object?> get props => [latitude, longitude, trackingDate, userId];
}
