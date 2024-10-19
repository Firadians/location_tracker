part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class RegisterUserEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterUserEvent({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [username, email, password, confirmPassword];
}

class LoginUserEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginUserEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class LogoutEvent extends AuthEvent {}
