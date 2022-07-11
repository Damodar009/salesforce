class AttendanceDashboard {
  double percentile;
  double present_days;
  double absent_days;
  AttendanceDashboard(
    this.percentile,
    this.present_days,
    this.absent_days,
  );

  // AttendanceDashboard.fromJson(dynamic json) {
  //   _percentile = json['percentile'];
  //   _presentDays = json['present_days'];
  //   _absentDays = json['absent_days'];
  // }
  //
  // AttendanceDashboard copyWith({
  //   double? percentile,
  //   int? presentDays,
  //   int? absentDays,
  // }) =>
  //     AttendanceDashboard(
  //       percentile: percentile ?? _percentile,
  //       presentDays: presentDays ?? _presentDays,
  //       absentDays: absentDays ?? _absentDays,
  //     );
  // double? get percentile => _percentile;
  // int? get presentDays => _presentDays;
  // int? get absentDays => _absentDays;
  //
  // Map<String, dynamic> toJson() {
  //   final map = <String, dynamic>{};
  //   map['percentile'] = _percentile;
  //   map['present_days'] = _presentDays;
  //   map['absent_days'] = _absentDays;
  //   return map;
  // }
}
