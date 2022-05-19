part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginAttemptEvent extends AuthEvent {
  const LoginAttemptEvent(
      {required this.username, required this.password});

  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];
}

class ChangePasswordEvent extends AuthEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordEvent(
      {required this.oldPassword, required this.newPassword});

  @override
  // TODO: implement props
  List<Object> get props => [oldPassword, newPassword];
}

class ResetPasswordEvent extends AuthEvent {
  final String newPassword;

  ResetPasswordEvent({required this.newPassword});

  @override
  // TODO: implement props
  List<Object> get props => [newPassword];
}
