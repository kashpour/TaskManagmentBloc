part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {}

//Initial States
final class AuthInitialState extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthLoadedSuccessState extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthLoadedFailureSate extends AuthState {
  final String failureMessage;

  AuthLoadedFailureSate({required this.failureMessage});
  @override
  List<Object?> get props => [failureMessage];
}

//Navigation States
final class AuthNavigateToSignupState extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthNavigateToLoginState extends AuthState {
  @override
  List<Object?> get props => [];
}

//Login SignUp Sates
final class AuthSignupState extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthLoginState extends AuthState {
  @override
  List<Object?> get props => [];
}

//Actions State

final class AuthPasswordRevealState extends AuthState {
  final bool isObscure;

  AuthPasswordRevealState({required this.isObscure});
  @override
  List<Object?> get props => [isObscure];
}

final class AuthForgetPasswordState extends AuthState {
  @override
  List<Object?> get props => [];
}
