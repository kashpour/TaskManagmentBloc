import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_managment_bloc/data/data_provider/network/network_result_state.dart';
import 'package:task_managment_bloc/data/repositories/auth_repo/auth_repo.dart';
import 'package:task_managment_bloc/features/auth/bloc/auth_bloc.dart';

import 'login_test_bloc.dart';

void main() {
  final LoginTestBloc authBloc = LoginTestBloc();
  setUp(() async {
    await authBloc.init();
  });
  group('Auth Bloc Test', () {
    blocTest<AuthBloc, AuthState>(
      'emits AuthNavigateToLogin state when AuthNavigateToLoginPressed Event is added.',
      build: () => authBloc.loginSuccessState(),
      act: (AuthBloc bloc) =>
          bloc.add(AuthLoginButtonPressedEvent(email: '', password: '')),
      expect: () => [isA<AuthLoadingState>(), isA<AuthLoginState>()],
    );
  });
}
