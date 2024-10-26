import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/repositories/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  AuthBloc({required this.authRepo}) : super(AuthInitialState()) {
    on<AuthInitialEvent>(_authInitialEvent);
    on<AuthNavigateToLoginPressedEvent>(_authNavigateToLoginPressedEvent);
    on<AuthNavigateToSignupPressedEvent>(_authNavigateToSignupPressedEvent);
    on<AuthLoginButtonPressedEvent>(_authLoginButtonPressedEvent);
    on<AuthForgetPasswordButtonPressedEvent>(
        _authForgetPasswordButtonPressedEvent);
    on<AuthSignupButtonPressedEvent>(_authSignupButtonPressedEvent);
    on<AuthPasswordRevealIconButtonPressedEvent>(
        _authPasswordRevealIconButtonPressedEvent);
  }
  FutureOr<void> _authInitialEvent(event, Emitter<AuthState> emit) async {
    emit(AuthInitialState());
    await Future.delayed(const Duration(seconds: 2));
    emit(AuthLoadedSuccessState());
  }

  FutureOr<void> _authNavigateToLoginPressedEvent(
      AuthNavigateToLoginPressedEvent event, Emitter<AuthState> emit) {
    emit(AuthNavigateToLoginState());
  }

  FutureOr<void> _authNavigateToSignupPressedEvent(
      AuthNavigateToSignupPressedEvent event, Emitter<AuthState> emit) {
    emit(AuthNavigateToSignupState());
  }

  FutureOr<void> _authLoginButtonPressedEvent(
      AuthLoginButtonPressedEvent event, Emitter<AuthState> emit) async {
    try {
      await authRepo.lgoinWithEmailAndPassword(event.email, event.password);
      emit(AuthLoadingState());
      emit(AuthLoginState());
    } catch (e) {
      emit(AuthLoadedFailureSate(failureMessage: e.toString()));
    }
  }

  FutureOr<void> _authSignupButtonPressedEvent(
      AuthSignupButtonPressedEvent event, Emitter<AuthState> emit) async {
    try {
      await authRepo.signupWithEmailAndPassword(event.email, event.password);
      emit(AuthSignupState());
    } catch (e) {
      emit(AuthLoadedFailureSate(failureMessage: e.toString()));
    }
  }

  FutureOr<void> _authForgetPasswordButtonPressedEvent(
      AuthForgetPasswordButtonPressedEvent event, Emitter<AuthState> emit) {
    authRepo.forgetUserPassword(event.email);
    emit(AuthForgetPasswordState());
  }

  FutureOr<void> _authPasswordRevealIconButtonPressedEvent(
      AuthPasswordRevealIconButtonPressedEvent event, Emitter<AuthState> emit) {
    emit(AuthPasswordRevealState(isObscure: !event.isObscure));
  }
}
