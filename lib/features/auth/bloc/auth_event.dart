part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthInitialEvent extends AuthEvent {}

final class AuthSignupButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignupButtonPressedEvent({required this.email, required this.password});
}

final class AuthLoginButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginButtonPressedEvent({required this.email, required this.password});
}

final class AuthForgetPasswordButtonPressedEvent extends AuthEvent {
  final String email;

  AuthForgetPasswordButtonPressedEvent({required this.email});
}

final class AuthPasswordRevealIconButtonPressedEvent extends AuthEvent {
  final bool isObscure;

  AuthPasswordRevealIconButtonPressedEvent({required this.isObscure});
}

final class AuthNavigateToSignupPressedEvent extends AuthEvent {}

final class AuthNavigateToLoginPressedEvent extends AuthEvent {}

