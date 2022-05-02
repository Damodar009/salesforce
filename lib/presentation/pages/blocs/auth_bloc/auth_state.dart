part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}


//login state
class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginFailedState extends AuthState {}


//Change Password State
class ChangePasswordLoadingState extends AuthState {}

class ChangePasswordSuccessState extends AuthState {}

class ChangePasswordFailedState extends AuthState {}


//Reset Password State

class ResetPasswordLoadingState extends AuthState {}

class ResetPasswordSuccessState extends AuthState {}

class ResetPasswordFailedState extends AuthState {}
