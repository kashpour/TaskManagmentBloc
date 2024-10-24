import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_managment_bloc/data/repositories/auth_repo.dart';

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
  }
  FutureOr<void> _authInitialEvent(event, Emitter<AuthState> emit) async {
    emit(AuthInitialState());
    await Future.delayed(const Duration(seconds: 2));
    emit(AuthLoadingState());
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
    await authRepo.lgoinWithEmailAndPassword(event.email, event.password);
    emit(AuthLoadingState());
    emit(AuthLoginState());
  }

  FutureOr<void> _authForgetPasswordButtonPressedEvent(
      AuthForgetPasswordButtonPressedEvent event,
      Emitter<AuthState> emit) async {
    await authRepo.forgetUserPassword(event.email);
    // TODo make a state for forgetPassword to be able to show the snack bar
  }

  FutureOr<void> _authSignupButtonPressedEvent(
      AuthSignupButtonPressedEvent event, Emitter<AuthState> emit) async {
    await authRepo.signupWithEmailAndPassword(event.email, event.password);
    emit(AuthSignupState());
  }
}
