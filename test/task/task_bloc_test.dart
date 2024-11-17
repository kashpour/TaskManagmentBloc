import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_managment_bloc/data/repositories/auth_repo/auth_repo.dart';
import 'package:task_managment_bloc/data/repositories/task_repo/task_repo.dart';
import 'package:task_managment_bloc/features/home/bloc/task_bloc.dart';
import 'package:task_managment_bloc/features/home/models/task_model.dart';

class MockTaskRepo extends Mock implements TaskRepo {}

class MockAuthRepo extends Mock implements AuthRepo {}

class TaskBlocTest {
  static final MockTaskRepo _mockTaskRepo = MockTaskRepo();
  static final MockAuthRepo _mockAuthRepo = MockAuthRepo();

  TaskBloc _taskBloc =
      TaskBloc(authRepo: _mockAuthRepo, taskRepo: _mockTaskRepo);

  Future<void> init() async {
    await _taskBloc.close();
    _taskBloc = TaskBloc(authRepo: _mockAuthRepo, taskRepo: _mockTaskRepo);
  }

  TaskBloc taskFetchTasks() {
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
    when(() => _mockTaskRepo.loadTask()).thenAnswer(
        (_) => Stream.fromIterable(tasks as Iterable<QuerySnapshot<Object?>>));

    return _taskBloc;
  }
}
