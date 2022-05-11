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
  final UserDetailsData userDetailsData;
  const GetProfileLoadedState({required this.userDetailsData});

  @override
  List<Object> get props => [userDetailsData];
}

class GetProfileFailedState extends ProfileState {}

//save

class SaveUserDetailsLoadingState extends ProfileState {}

class SaveUserDetailsLoadedState extends ProfileState {}

class SaveUserDetailsFailedState extends ProfileState {}
