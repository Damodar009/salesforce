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

  // Leave.fromJson(dynamic json) {
  //   _fromDate = json['from_date'];
  //   _toDate = json['to_date'];
  //   _userId = json['user_id'];
  //   _reason = json['reason'];
  // }
  //
  // Leave copyWith({
  //   String? fromDate,
  //   String? toDate,
  //   String? userId,
  //   String? reason,
  // }) =>
  //     Leave(
  //       fromDate: fromDate ?? _fromDate,
  //       toDate: toDate ?? _toDate,
  //       userId: userId ?? _userId,
  //       reason: reason ?? _reason,
  //     );
  // String? get fromDate => _fromDate;
  // String? get toDate => _toDate;
  // String? get userId => _userId;
  // String? get reason => _reason;
  //
  // Map<String, dynamic> toJson() {
  //   final map = <String, dynamic>{};
  //   map['from_date'] = _fromDate;
  //   map['to_date'] = _toDate;
  //   map['user_id'] = _userId;
  //   map['reason'] = _reason;
  //   return map;
  // }

  @override
  List<Object?> get props => [fromDate, toDate, userId, reason];
}
