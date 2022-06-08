part of 'attendence_cubit.dart';

abstract class AttendenceState extends Equatable {
  const AttendenceState();
}

class AttendenceInitial extends AttendenceState {
  List<Object?> get props => [];
}

class CheckedInState extends AttendenceState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CheckedOutState extends AttendenceState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AttendenceLoading extends AttendenceState {
  @override
  List<Object> get props => [];
}

class AttendenceSucess extends AttendenceState {
  @override
  List<Object> get props => [];
}

class AttendenceFailed extends AttendenceState {
  @override
  List<Object> get props => [];
}
//
// class UserGetFailed extends AttendenceState {
//   @override
//   List<Object?> get props => [];
// }
//
// class ApiFailed extends AttendenceState {
//   @override
//   List<Object?> get props => [];
// }
//
// class HiveSaveFailed extends AttendenceState {
//   @override
//   List<Object?> get props => [];
// }
//
// class LocationGetFailed extends AttendenceState {
//   @override
//   List<Object?> get props => [];
// }
