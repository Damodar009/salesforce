part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoadingState extends AuthState {}


//login state

class LoginSuccessState extends AuthState {}

class LoginFailedState extends AuthState {}


//Change Password State

class ChangePasswordSuccessState extends AuthState {}

class ChangePasswordFailedState extends AuthState {}


//Reset Password State

class ResetPasswordSuccessState extends AuthState {}

class ResetPasswordFailedState extends AuthState {}
