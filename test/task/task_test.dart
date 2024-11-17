import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_managment_bloc/features/home/bloc/task_bloc.dart';

import 'task_bloc_test.dart';

void main() {
  final TaskBlocTest taskBlocTest = TaskBlocTest();
  setUp(() async {
    await taskBlocTest.init();
  });
  group('Task Bloc Test', () {

    group('Fetching Tasks  ', (){
      blocTest<TaskBloc, TaskState>(
        'emits Stream of Tasks when fetch tasks event is added.',
        build: () => taskBlocTest.taskFetchTasks(),
        act: (bloc) => bloc.add(TaskFetchTasksEvent(isTaskCompleteEvent: false)),
        expect: () => [isA<TaskLoadedSuccessState>()],
      );

    });

  });
}
