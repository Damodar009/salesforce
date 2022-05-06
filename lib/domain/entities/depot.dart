import 'package:equatable/equatable.dart';

class Depot extends Equatable {
  final String name;
  final String id;
  final double longitude;
  final double latitude;
  Depot(
      {required this.id,
      required this.name,
      required this.longitude,
      required this.latitude});
  @override
  List<Object?> get props => [name , id , longitude , latitude ];
}
