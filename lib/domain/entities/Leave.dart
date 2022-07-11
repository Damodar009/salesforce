import 'package:equatable/equatable.dart';

class Leave extends Equatable {
  String fromDate;
  String toDate;
  String userId;
  String reason;
  Leave({
    required this.fromDate,
    required this.toDate,
    required this.userId,
    required this.reason,
  });

  @override
  List<Object?> get props => [fromDate, toDate, userId, reason];
}
