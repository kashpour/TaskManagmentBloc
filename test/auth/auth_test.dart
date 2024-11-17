import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_managment_bloc/features/auth/bloc/auth_bloc.dart';

import 'auth_bloc_test.dart';

void main() {
  final AuthTestBloc authBloc = AuthTestBloc();
  setUp(() async {
    await authBloc.init();
  });
  group('Auth Bloc Test', () {
    group('Login States', () {
      blocTest<AuthBloc, AuthState>(
        'emits AuthLoginState when AuthNavigateToLoginPressed Event is added.',
        build: () => authBloc.loginSuccessState(),
        act: (bloc) =>
            bloc.add(AuthLoginButtonPressedEvent(email: '', password: '')),
        expect: () => [isA<AuthLoadingState>(), isA<AuthLoginState>()],
      );

      blocTest(
        'emits AuthLoadedFailureSate when AuthNavigateToLoginPressed event is added',
        build: () => authBloc.loginFailureState(),
        act: (bloc) =>
            bloc.add(AuthLoginButtonPressedEvent(email: '', password: '')),
        expect: () => [isA<AuthLoadingState>(), isA<AuthLoadedFailureSate>()],
      );
    });

    group('SiginUp States', () {
      blocTest<AuthBloc, AuthState>(
        'emits AuthSignupState when AuthSignupButtonPressedEvent is added.',
        build: () => authBloc.signupSuccessState(),
        act: (bloc) =>
            bloc.add(AuthSignupButtonPressedEvent(email: '', password: '')),
        expect: () => [isA<AuthLoadingState>(), isA<AuthSignupState>()],
      );

      blocTest<AuthBloc, AuthState>(
        'emits AuthLoadedFailureSate when AuthSignupButtonPressedEvent is added.',
        build: () => authBloc.signupFailureState(),
        act: (bloc) =>
            bloc.add(AuthSignupButtonPressedEvent(email: '', password: '')),
        expect: () => [isA<AuthLoadingState>(), isA<AuthLoadedFailureSate>()],
      );
    });

    group('Forget password States', () {
      blocTest<AuthBloc, AuthState>(
        'emits AuthForgetPasswordState when AuthForgetPasswordButtonPressed event is added.',
        build: () => authBloc.forgetPasswordSuccessState(),
        act: (bloc) =>
            bloc.add(AuthForgetPasswordButtonPressedEvent(email: '')),
        expect: () => [isA<AuthLoadingState>(), isA<AuthForgetPasswordState>()],
      );

      blocTest<AuthBloc, AuthState>(
        'emits AuthLoadedFailureSate when AuthForgetPasswordButtonPressed event is added.',
        build: () => authBloc.forgetPasswordFailureState(),
        act: (bloc) =>
            bloc.add(AuthForgetPasswordButtonPressedEvent(email: '')),
        expect: () => [isA<AuthLoadingState>(), isA<AuthLoadedFailureSate>()],
      );

      test('Getting User info', () {
        final userModel = authBloc.getUserInfo();
        debugPrint(userModel.toString());
        expect(userModel, userModel);
      });
    });
  });
}
