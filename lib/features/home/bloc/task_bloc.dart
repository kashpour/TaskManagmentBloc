import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_managment_bloc/features/home/models/task_model.dart';

import '../../../data/repositories/auth_repo.dart';
import '../../../data/repositories/task_repo.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AuthRepo authRepo;
  final TaskRepo taskRepo;

  TaskBloc({required this.authRepo, required this.taskRepo})
      : super(TaskInitial()) {
    on<TaskLogOutButtonPressedEvent>(_taskLogOutButtonPressedEvent);
    on<TaskAddNewTaskButtonPressedEvent>(_taskAddNewTaskButtonPressedEvent);
    on<TaskAddNewTaskEvent>(_taskAddNewTaskEvent);
    on<TaskFetchTasksEvent>(_taskFetchTasksEvent);
  }

  FutureOr<void> _taskLogOutButtonPressedEvent(
      TaskLogOutButtonPressedEvent event, Emitter<TaskState> emit) {
    try {
      authRepo.signOutUser();
      emit(UserLogOutState());
    } catch (e) {
      emit(TaskFailureSate(
        failureMessage: e.toString(),
      ));
    }
  }

  FutureOr<void> _taskAddNewTaskButtonPressedEvent(
      TaskAddNewTaskButtonPressedEvent event, Emitter<TaskState> emit) {
    emit(TaskAddNewTaskDialogState());
  }

  FutureOr<void> _taskAddNewTaskEvent(
      TaskAddNewTaskEvent event, Emitter<TaskState> emit) {
    final TaskModel newTask = TaskModel(
        title: event.title, body: event.body, dateTime: event.dateTime);
    taskRepo.addTask(newTask);
    emit(TaskAddNewTaskState());
  }

  FutureOr<void> _taskFetchTasksEvent(
      TaskFetchTasksEvent event, Emitter<TaskState> emit) async {
    try {
      final Stream loadTasks = taskRepo.loadTask();
      await emit.forEach(
        loadTasks,
        onData: (snapshot) {
          final task =
              snapshot.docs.map((doc) => TaskModel.fromJson(doc)).toList();
          return TaskLoadedSuccessState(taskModel: task);
        },
      );
    } catch (e) {
      emit(TaskFailureSate(failureMessage: e.toString()));
    }
  }
}
