part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthInitialEvent extends AuthEvent{}
final class AuthSignupButtonPressedEvent extends AuthEvent {
  final String userName;
  final String password;

  AuthSignupButtonPressedEvent(
      {required this.userName, required this.password});
}

final class AuthLoginButtonPressedEvent extends AuthEvent {
  final String userName;
  final String password;

  AuthLoginButtonPressedEvent({required this.userName, required this.password});
}

final class AuthForgetPasswordButtonPressedEvent extends AuthEvent {
  final String userName;

  AuthForgetPasswordButtonPressedEvent({required this.userName});
}

final class AuthNavigateToSignupPressedEvent extends AuthEvent {}

final class AuthNavigateToLoginPressedEvent extends AuthEvent {}
