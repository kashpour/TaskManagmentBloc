import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/auth_repo.dart';
import '../../../data/repositories/task_repo.dart';
import '../models/task_model.dart';

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
    on<TaskDeleteTaskButtonPressedEvent>(_taskDeleteTaskButtonPressedEvent);
    on<TaskUpdateTaskButtonPressedEvent>(_taskUpdateTaskButtonPressedEvent);
    on<TaskUpdatedTaskEvent>(_taskUpdatedTaskEvent);
    on<TaskCompletedButtonPressedEvent>(_taskCompletedButtonPressedEvent);
    on<TaskFetchComletedTasksEvent>(_taskFetchComletedTasksEvent);
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
      title: event.title,
      description: event.description,
      dateTime: event.dateTime,
      isCompleted: event.isCompleted,
    );
    taskRepo.addTask(newTask);
    emit(TaskAddNewTaskState());
  }

  FutureOr<void> _taskFetchTasksEvent(
      TaskFetchTasksEvent event, Emitter<TaskState> emit) async {
    try {
      final taskStream = taskRepo.loadTask().map((snapshot) {
        final tasks =
            snapshot.docs.map((doc) => TaskModel.fromJson(doc, doc.id)).where(
          (element) {
            return element.isCompleted != true;
          },
        ).toList();
        return TaskLoadedSuccessState(
            taskModel: tasks,
            email: authRepo.getUserInfo().email!,
            userName: authRepo.getUserInfo().username!);
      });
      await emit.forEach(taskStream, onData: (state) => state);
    } catch (e) {
      emit(TaskFailureSate(failureMessage: e.toString()));
    }
  }

  FutureOr<void> _taskDeleteTaskButtonPressedEvent(
      TaskDeleteTaskButtonPressedEvent event, Emitter<TaskState> emit) {
    taskRepo.deleteTask(event.taskID);
  }

  FutureOr<void> _taskUpdateTaskButtonPressedEvent(
      TaskUpdateTaskButtonPressedEvent event, Emitter<TaskState> emit) {
    emit(TaskUpdateTaskDialogState(task: event.task));
  }

  FutureOr<void> _taskUpdatedTaskEvent(
      TaskUpdatedTaskEvent event, Emitter<TaskState> emit) {
    taskRepo.updateTask(event.task, event.documentId);
  }

  FutureOr<void> _taskCompletedButtonPressedEvent(
      TaskCompletedButtonPressedEvent event, Emitter<TaskState> emit) {
    if (event.task.isCompleted) {
      event.task.isCompleted = false;
    } else {
      event.task.isCompleted = true;
    }
    taskRepo.updateTask(event.task, event.task.id);
    emit(TaskUpdateTaskState());
  }

  FutureOr<void> _taskFetchComletedTasksEvent(
      TaskFetchComletedTasksEvent event, Emitter<TaskState> emit) async {
    try {
      final taskStream = taskRepo.loadTask().map((snapshot) {
        final tasks =
            snapshot.docs.map((doc) => TaskModel.fromJson(doc, doc.id)).where(
          (element) {
            return element.isCompleted == true;
          },
        ).toList();
        return TaskLoadedSuccessState(
            taskModel: tasks,
            email: authRepo.getUserInfo().email!,
            userName: authRepo.getUserInfo().username!);
      });
      await emit.forEach(taskStream, onData: (state) => state);
    } catch (e) {
      emit(TaskFailureSate(failureMessage: e.toString()));
    }
  }
}
