import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_managment_bloc/features/home/bloc/task_bloc.dart';

import 'task_bloc_test.dart';

void main() {
  final TaskBlocTest taskBlocTest = TaskBlocTest();
  setUp(() async {
    await taskBlocTest.init();
  });
  group('Task Bloc Test', () {
    group('Fetching Tasks  ', () {
      blocTest<TaskBloc, TaskState>(
        'emits Stream of Tasks when fetch tasks event is added.',
        build: () => taskBlocTest.taskFetchTasksSuccessState(),
        act: (bloc) =>
            bloc.add(TaskFetchTasksEvent(isTaskCompleteEvent: false)),
        expect: () => [isA<TaskLoadedSuccessState>()],
      );

      blocTest<TaskBloc, TaskState>(
        'emits Stream of Failure states when fetch tasks event is added.',
        build: () => taskBlocTest.taskFetchTasksFailureState(),
        act: (bloc) =>
            bloc.add(TaskFetchTasksEvent(isTaskCompleteEvent: false)),
        expect: () => [isA<TaskFailureSate>()],
      );
    });

    group('Add Task States', () {
      blocTest<TaskBloc, TaskState>(
        'emits Success state when add new task event is added.',
        build: () => taskBlocTest.taskAddTaskSuccessState(),
        act: (bloc) => bloc.add(TaskAddNewTaskEvent(
            title: 'title',
            description: 'description',
            dateTime: 'dateTime',
            isCompleted: false)),
        expect: () => [isA<TaskAddNewTaskState>()],
      );
      blocTest<TaskBloc, TaskState>(
        'emits Failure State when add new task event is added.',
        build: () => taskBlocTest.taskAddTaskFailureState(),
        act: (bloc) => bloc.add(TaskAddNewTaskEvent(
            title: 'title',
            description: 'description',
            dateTime: 'dateTime',
            isCompleted: false)),
        expect: () => [isA<TaskFailureSate>()],
      );
    });
  });
}
