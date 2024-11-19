import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_managment_bloc/features/home/bloc/task_bloc.dart';
import 'package:task_managment_bloc/features/home/models/task_model.dart';

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

  group('Update Task States', () {
    blocTest<TaskBloc, TaskState>(
      'emits Task update state when task update event is added.',
      build: () => taskBlocTest.taskUpdateTaskSuccessState(),
      act: (bloc) => bloc.add(TaskUpdatedTaskEvent(
          task: TaskModel(
              title: 'title',
              description: 'description',
              dateTime: 'dateTime',
              isCompleted: false),
          documentId: 'documentId')),
      expect: () => [isA<TaskUpdateTaskState>()],
    );

    blocTest<TaskBloc, TaskState>(
      'emits Task failure state when task update event is added.',
      build: () => taskBlocTest.taskUpdateTaskFailureState(),
      act: (bloc) => bloc.add(TaskUpdatedTaskEvent(
          task: TaskModel(
              title: 'title',
              description: 'description',
              dateTime: 'dateTime',
              isCompleted: false),
          documentId: 'documentId')),
      expect: () => [isA<TaskFailureSate>()],
    );
  });
  group('Delete Task States', () {
    blocTest<TaskBloc, TaskState>(
      'emits task delete state when task delete event is added.',
      build: () => taskBlocTest.taskDeleteTaskSuccsessState(),
      act: (bloc) =>
          bloc.add(TaskDeleteTaskButtonPressedEvent(taskID: 'taskID')),
      expect: () => [isA<TaskDeleteTaskState>()],
    );

    blocTest<TaskBloc, TaskState>(
      'emits failure state when task delete event is added.',
      build: () => taskBlocTest.taskDeleteTaskFailureState(),
      act: (bloc) =>
          bloc.add(TaskDeleteTaskButtonPressedEvent(taskID: 'taskID')),
      expect: () => [isA<TaskFailureSate>()],
    );
  });
}
