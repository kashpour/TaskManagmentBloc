import 'package:mocktail/mocktail.dart';
import 'package:task_managment_bloc/data/data_provider/network/network_result_state.dart';
import 'package:task_managment_bloc/data/repositories/auth_repo/auth_repo.dart';
import 'package:task_managment_bloc/data/repositories/task_repo/task_repo.dart';
import 'package:task_managment_bloc/features/auth/models/user_model.dart';
import 'package:task_managment_bloc/features/home/bloc/task_bloc.dart';
import 'package:task_managment_bloc/features/home/models/task_model.dart';

class MockTaskRepo extends Mock implements TaskRepo {}

class MockTaskModel extends Mock implements TaskModel {}

class MockAuthRepo extends Mock implements AuthRepo {}

class TaskBlocTest {
  static final MockTaskRepo _mockTaskRepo = MockTaskRepo();
  static final MockAuthRepo _mockAuthRepo = MockAuthRepo();
  TaskBloc _taskBloc =
      TaskBloc(authRepo: _mockAuthRepo, taskRepo: _mockTaskRepo);

  Future<void> init() async {
    await _taskBloc.close();
    registerFallbackValue(MockTaskModel());
    _taskBloc = TaskBloc(authRepo: _mockAuthRepo, taskRepo: _mockTaskRepo);
  }

  TaskBloc taskFetchTasksSuccessState() {
    final List<TaskModel> tasks = [
      TaskModel(
          title: 'title 1',
          description: 'description 1',
          dateTime: 'dateTime 1',
          isCompleted: false),
      TaskModel(
          title: 'title 2',
          description: 'description 2',
          dateTime: 'dateTime 2',
          isCompleted: false),
      TaskModel(
          title: 'title 3',
          description: 'description 3',
          dateTime: 'dateTime 3',
          isCompleted: false),
    ];
    when(() => _mockTaskRepo.loadTask(eventIsCompleted: false))
        .thenAnswer((_) => Stream.value(SuccessState(data: tasks)));
    when(() => _mockAuthRepo.getUserInfo()).thenAnswer(
        (_) => UserModel(email: 'ibrahim@gmail.com', username: 'kashpour'));

    return _taskBloc;
  }

  TaskBloc taskFetchTasksFailureState() {
    when(() => _mockTaskRepo.loadTask(eventIsCompleted: false)).thenAnswer(
        (_) =>
            Stream.value(FailureState(errorMessage: 'Failed Loading tasks')));

    when(() => _mockAuthRepo.getUserInfo()).thenAnswer(
        (_) => UserModel(email: 'ibrahim@gmail.com', username: 'kashpour'));

    return _taskBloc;
  }

  TaskBloc taskAddTaskSuccessState() {
    when(() => _mockAuthRepo.getUserInfo()).thenAnswer(
        (_) => UserModel(email: 'ibrahim@gmail.com', username: 'kashpour'));

    when(() => _mockTaskRepo.addTask(any())).thenAnswer(
      (_) async => SuccessState(data: {}),
    );

    return _taskBloc;
  }

  TaskBloc taskAddTaskFailureState() {
    when(() => _mockAuthRepo.getUserInfo()).thenAnswer(
        (_) => UserModel(email: 'ibrahim@gmail.com', username: 'kashpour'));

    when(() => _mockTaskRepo.addTask(any()))
        .thenAnswer((_) async => FailureState(errorMessage: ''));

    return _taskBloc;
  }

  TaskBloc taskUpdateTaskSuccessState() {
    when(() => _mockAuthRepo.getUserInfo()).thenAnswer(
        (_) => UserModel(email: 'ibrahim@gmail.com', username: 'kashpour'));

    when(() => _mockTaskRepo.updateTask(any(), any()))
        .thenAnswer((_) async => SuccessState(data: {}));

    return _taskBloc;
  }

  TaskBloc taskUpdateTaskFailureState() {
    when(() => _mockAuthRepo.getUserInfo()).thenAnswer(
        (_) => UserModel(email: 'ibrahim@gmail.com', username: 'kashpour'));

    when(() => _mockTaskRepo.updateTask(any(), any()))
        .thenAnswer((_) async => FailureState(errorMessage: ''));

    return _taskBloc;
  }

  TaskBloc taskDeleteTaskSuccsessState() {
    when(() => _mockAuthRepo.getUserInfo()).thenAnswer(
        (_) => UserModel(email: 'ibrahim@gmail.com', username: 'kashpour'));

    when(() => _mockTaskRepo.deleteTask(any()))
        .thenAnswer((_) async => SuccessState(data: {}));

    return _taskBloc;
  }

  TaskBloc taskDeleteTaskFailureState() {
    when(() => _mockAuthRepo.getUserInfo()).thenAnswer(
        (_) => UserModel(email: 'ibrahim@gmail.com', username: 'kashpour'));

    when(() => _mockTaskRepo.deleteTask(any()))
        .thenAnswer((_) async => FailureState(errorMessage: ''));

    return _taskBloc;
  }
}
