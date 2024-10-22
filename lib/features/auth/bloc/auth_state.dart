part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthLoadedSuccessState extends AuthState {}

final class AuthLoadedFailureSate extends AuthState {}

final class AuthNavigateToSignupState extends AuthState {}

final class AuthNavigateToLoginState extends AuthState {}

final class AuthSignupState extends AuthState {}

final class AuthLoginState extends AuthState {}
