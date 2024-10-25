part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

final class TaskLogOutButtonPressedEvent extends TaskEvent {}

//actions
final class TaskAddNewTaskButtonPressedEvent extends TaskEvent {}

final class TaskUpdateTaskButtonPressedEvent extends TaskEvent {}

final class TaskDeleteTaskButtonPressedEvent extends TaskEvent {}

final class TaskCompletedButtonPressedEvent extends TaskEvent {}

final class TaskNavigateToCompletedTasksButtonPressedEvent extends TaskEvent {}

final class TaskAddNewTaskEvent extends TaskEvent {
  final String title;
  final String body;
  final String dateTime;

  TaskAddNewTaskEvent(
      {required this.title, required this.body, required this.dateTime});
}
