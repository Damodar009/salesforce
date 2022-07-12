import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'requestDeliver.g.dart';

@HiveType(typeId: 19)
class RequestDelivered extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String deliveredDate;
  RequestDelivered(this.id, this.deliveredDate);

  @override
  List<Object?> get props => [id, deliveredDate];
}
