part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

//Initial States
final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthLoadedSuccessState extends AuthState {}

final class AuthLoadedFailureSate extends AuthState {
  final String failureMessage;

  AuthLoadedFailureSate({required this.failureMessage});
}

//Navigation States
final class AuthNavigateToSignupState extends AuthState {}

final class AuthNavigateToLoginState extends AuthState {}

//Login SignUp Sates
final class AuthSignupState extends AuthState {}

final class AuthLoginState extends AuthState {}

//Actions State

final class AuthPasswordRevealState extends AuthState {
  final bool isObscure;

  AuthPasswordRevealState({required this.isObscure});
}

final class AuthForgetPasswordState extends AuthState {}
