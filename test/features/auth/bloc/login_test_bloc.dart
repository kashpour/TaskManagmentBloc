import 'package:mocktail/mocktail.dart';
import 'package:task_managment_bloc/data/data_provider/network/network_result_state.dart';
import 'package:task_managment_bloc/data/repositories/auth_repo/auth_repo.dart';
import 'package:task_managment_bloc/features/auth/bloc/auth_bloc.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

class LoginTestBloc {
  static final MockAuthRepo _mockAuthRepo = MockAuthRepo();
  AuthBloc _authBloc = AuthBloc(authRepo: _mockAuthRepo);

  Future<void> init() async {
    await _authBloc.close();
    _authBloc = AuthBloc(authRepo: _mockAuthRepo);
  }

  AuthBloc loginSuccessState() {
    when(() => _mockAuthRepo.loginWithEmailAndPassword(email: '', password: ''))
        .thenAnswer((_) async => SuccessState(data: ''));
    return _authBloc;
  }
}
