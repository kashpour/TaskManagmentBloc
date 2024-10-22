import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
   on<AuthNavigateToLoginPressedEvent>(_authNavigateToLoginPressedEvent);
   on<AuthNavigateToSignupPressedEvent>(_authNavigateToSignupPressedEvent);

  }

  FutureOr<void> _authNavigateToLoginPressedEvent(AuthNavigateToLoginPressedEvent event, Emitter<AuthState> emit) {
    emit(AuthNavigateToLoginState());
  }

  FutureOr<void> _authNavigateToSignupPressedEvent(AuthNavigateToSignupPressedEvent event, Emitter<AuthState> emit) {
    emit(AuthNavigateToSignupState());
  }
}
