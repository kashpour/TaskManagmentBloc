import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
  }

  FutureOr<void> _taskLogOutButtonPressedEvent(
      TaskLogOutButtonPressedEvent event, Emitter<TaskState> emit) {
    try {
      authRepo.signOutUser();
      emit(UserLogOutState());
    } catch (e) {
      emit(TaskFailureSate(failureMessage: e.toString()));
    }
  }

  FutureOr<void> _taskAddNewTaskButtonPressedEvent(
      TaskAddNewTaskButtonPressedEvent event, Emitter<TaskState> emit) {
    emit(TaskAddNewTaskDialogState());
  }
}
