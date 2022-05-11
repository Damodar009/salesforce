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
      this.latitude, this.longitude, this.trackingDate, this.userId);

  @override
  List<Object?> get props => [latitude, longitude, trackingDate, userId];
}
