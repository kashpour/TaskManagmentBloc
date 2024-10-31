part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {}

final class AuthInitialEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

final class AuthSignupButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignupButtonPressedEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

final class AuthLoginButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginButtonPressedEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

final class AuthForgetPasswordButtonPressedEvent extends AuthEvent {
  final String email;

  AuthForgetPasswordButtonPressedEvent({required this.email});
  @override
  List<Object?> get props => [email];
}

final class AuthPasswordRevealIconButtonPressedEvent extends AuthEvent {
  final bool isObscure;

  AuthPasswordRevealIconButtonPressedEvent({required this.isObscure});
  @override
  List<Object?> get props => [isObscure];
}

final class AuthNavigateToSignupPressedEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

final class AuthNavigateToLoginPressedEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
