import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthInitialEvent>(_authInitialEvent);
    on<AuthNavigateToLoginPressedEvent>(_authNavigateToLoginPressedEvent);
    on<AuthNavigateToSignupPressedEvent>(_authNavigateToSignupPressedEvent);
  }

  FutureOr<void> _authNavigateToLoginPressedEvent(
      AuthNavigateToLoginPressedEvent event, Emitter<AuthState> emit) {
    emit(AuthNavigateToLoginState());
  }

  FutureOr<void> _authNavigateToSignupPressedEvent(
      AuthNavigateToSignupPressedEvent event, Emitter<AuthState> emit) {
    emit(AuthNavigateToSignupState());
  }

  FutureOr<void> _authInitialEvent(event, Emitter<AuthState> emit) async {
    emit(AuthInitialState());
    await Future.delayed(const Duration(seconds: 2));
    emit(AuthLoadingState());
  }
}
