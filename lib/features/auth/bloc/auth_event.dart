part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignupButtonPressedEvent extends AuthEvent {}

final class AuthLoginButtonPressedEvent extends AuthEvent {}

final class AuthForgetPasswordButtonPressedEvent extends AuthEvent {}

final class AuthNavigateToSignupPressedEvent extends AuthEvent {}

final class AuthNavigateToLoginPressedEvent extends AuthEvent {}
