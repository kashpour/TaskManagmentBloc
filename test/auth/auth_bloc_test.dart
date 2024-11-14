import 'package:mocktail/mocktail.dart';
import 'package:task_managment_bloc/data/data_provider/network/network_result_state.dart';
import 'package:task_managment_bloc/data/repositories/auth_repo/auth_repo.dart';
import 'package:task_managment_bloc/features/auth/bloc/auth_bloc.dart';
import 'package:task_managment_bloc/features/auth/models/user_model.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

class AuthTestBloc {
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

  AuthBloc loginFailureState() {
    when(() => _mockAuthRepo.loginWithEmailAndPassword(email: '', password: ''))
        .thenThrow((_) async => FailureState(errorMessage: 'errorMessage'));
    return _authBloc;
  }

  AuthBloc signupSuccessState() {
    when(() => _mockAuthRepo.signupWithEmailAndPassword('', ''))
        .thenAnswer((_) async => SuccessState(data: ''));
    return _authBloc;
  }

  AuthBloc signupFailureState() {
    when(() => _mockAuthRepo.signupWithEmailAndPassword('', ''))
        .thenThrow((_) async => FailureState(errorMessage: ''));

    return _authBloc;
  }

  AuthBloc forgetPasswordSuccessState() {
    when(() => _mockAuthRepo.forgetUserPassword(''))
        .thenAnswer((_) async => SuccessState(data: ''));

    return _authBloc;
  }

  AuthBloc forgetPasswordFailureState() {
    when(() => _mockAuthRepo.forgetUserPassword(''))
        .thenThrow((_) async => FailureState(errorMessage: ''));
    return _authBloc;
  }

  UserModel getUserInfo() {
    final userModel = UserModel(email: 'ibrahim@gmail.com', username: 'kashpour');
    when(() => _mockAuthRepo.getUserInfo()).thenAnswer((_) => userModel);
    return userModel;
  }
}
