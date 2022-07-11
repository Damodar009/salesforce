import 'package:equatable/equatable.dart';

class RequestDelivered extends Equatable {
  final String id;
  final String deliveredDate;
  RequestDelivered(this.id, this.deliveredDate);

  @override
  // TODO: implement props
  List<Object?> get props => [id, deliveredDate];
}
