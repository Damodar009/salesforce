import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final String date;
  final int quantity;

  Report(this.date, this.quantity);

  @override
  List<Object?> get props => [date, quantity];
}
