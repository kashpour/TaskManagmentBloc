part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoadingState extends TaskState {}

final class TaskLoadedSuccessState extends TaskState {
  final List<TaskModel> taskModel;

  TaskLoadedSuccessState({required this.taskModel});
}

final class TaskFailureSate extends TaskState {
  final String failureMessage;

  TaskFailureSate({required this.failureMessage});
}

final class UserLogOutState extends TaskState {}

final class UserCredintialsState extends TaskState {}

final class TaskAddNewTaskState extends TaskState {}

final class TaskAddNewTaskDialogState extends TaskState {}

final class TaskUpdateTaskDialogState extends TaskState {}

final class TaskDeleteTaskDialogState extends TaskState {}

final class TaskCompleteTaskState extends TaskState {}

final class TaskNavigateToCompletedTasksState extends TaskState {}
