import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'merchndiseOrder.g.dart';

@HiveType(typeId: 12)
class MerchandiseOrder extends Equatable {
  @HiveField(0)
  final String image;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String merchandise_id;

  MerchandiseOrder(
      {required this.image,
      required this.description,
      required this.merchandise_id});
  @override
  List<Object?> get props => [];
}
