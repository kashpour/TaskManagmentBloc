part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

final class TaskLogOutButtonPressedEvent extends TaskEvent {}

//actions
final class TaskAddNewTaskButtonPressedEvent extends TaskEvent {}

final class TaskUpdateTaskButtonPressedEvent extends TaskEvent {
  final TaskModel task;
  final String documentId;

  TaskUpdateTaskButtonPressedEvent(
      {required this.task, required this.documentId});
}

final class TaskDeleteTaskButtonPressedEvent extends TaskEvent {
  final String taskID;

  TaskDeleteTaskButtonPressedEvent({required this.taskID});
}

final class TaskCompletedButtonPressedEvent extends TaskEvent {
  final TaskModel task;

  TaskCompletedButtonPressedEvent({required this.task});
}
final class TaskAddNewTaskEvent extends TaskEvent {
  final String title;
  final String description;
  final String dateTime;
  final bool isCompleted;

  TaskAddNewTaskEvent(
      {required this.title,
      required this.description,
      required this.dateTime,
      required this.isCompleted});
}

final class TaskFetchTasksEvent extends TaskEvent {}

final class TaskFetchComletedTasksEvent extends TaskEvent{}

final class TaskUpdatedTaskEvent extends TaskEvent {
  final TaskModel task;
  final String documentId;

  TaskUpdatedTaskEvent({required this.task, required this.documentId});
}
