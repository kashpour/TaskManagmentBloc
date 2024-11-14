import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task_managment_bloc/data/data_provider/network/network_result_state.dart';
import '../../../data/repositories/auth_repo/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  AuthBloc({required this.authRepo}) : super(AuthInitialState()) {
    on<AuthInitialEvent>(_authInitialEvent);
    on<AuthNavigateToLoginPressedEvent>(_authNavigateToLoginPressedEvent,
        transformer: droppable());
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
    emit(AuthLoadingState());
    try {
      final NetworkResultState resutlState =
          await authRepo.loginWithEmailAndPassword(
              email: event.email, password: event.password);
      if (resutlState is SuccessState) {
        emit(AuthLoginState());
      } else {
        emit(AuthLoadedFailureSate(failureMessage: 'error happned'));
      }
    } catch (e) {
      emit(AuthLoadedFailureSate(failureMessage: e.toString()));
    }
  }

  FutureOr<void> _authSignupButtonPressedEvent(
      AuthSignupButtonPressedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    try {
      final NetworkResultState resutlState = await authRepo
          .signupWithEmailAndPassword(event.email, event.password);
      if (resutlState is SuccessState) {
        emit(AuthSignupState());
      } else {
        emit(AuthLoadedFailureSate(failureMessage: 'error happened'));
      }
    } catch (e) {
      emit(AuthLoadedFailureSate(failureMessage: e.toString()));
    }
  }

  FutureOr<void> _authForgetPasswordButtonPressedEvent(
      AuthForgetPasswordButtonPressedEvent event,
      Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    try {
      final NetworkResultState resutlState =
          await authRepo.forgetUserPassword(event.email);
      if (resutlState is SuccessState) {
        emit(AuthForgetPasswordState());
      } else {
        emit(AuthLoadedFailureSate(failureMessage: 'error happened'));
      }
    } catch (e) {
      emit(AuthLoadedFailureSate(failureMessage: e.toString()));
    }
  }

  FutureOr<void> _authPasswordRevealIconButtonPressedEvent(
      AuthPasswordRevealIconButtonPressedEvent event, Emitter<AuthState> emit) {
    emit(AuthPasswordRevealState(isObscure: !event.isObscure));
  }
}
