part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

//get

class GetProfileLoadingState extends ProfileState {}

class GetProfileLoadedState extends ProfileState {
  final UserDetailsData userDetailsdata;
  const GetProfileLoadedState({required this.userDetailsdata});

  @override
  List<Object> get props => [userDetailsdata];
}

class GetProfileFailedState extends ProfileState {}

//save

class SaveUserDetailsLoadingState extends ProfileState {}

class SaveUserDetailsLoadedState extends ProfileState {}

class SaveUserDetailsFailedState extends ProfileState {}
