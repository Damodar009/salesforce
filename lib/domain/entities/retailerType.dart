import 'package:equatable/equatable.dart';

class RetailerType extends Equatable {
  final String name;
  final String id;
  final bool status;
   RetailerType(
      {required this.name, required this.id, required this.status});

  @override
  // TODO: implement props
  List<Object?> get props => [name, id, status];
}
