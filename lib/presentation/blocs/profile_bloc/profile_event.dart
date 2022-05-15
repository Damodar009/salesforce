part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class SaveUserDetailsEvent extends ProfileEvent {
  final UserDetails userDetails;

  const SaveUserDetailsEvent({required this.userDetails});
  @override
  List<Object> get props => [userDetails];
}
