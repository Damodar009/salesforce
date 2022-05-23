import 'package:equatable/equatable.dart';

class MerchandiseOrder extends Equatable {
  final String image;
  final String description;
  final String merchandise_id;

  MerchandiseOrder(
      {required this.image,
      required this.description,
      required this.merchandise_id});
  @override
  List<Object?> get props => [];
}
