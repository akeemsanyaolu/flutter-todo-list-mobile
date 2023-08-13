part of 'tasks_bloc.dart';

@immutable
abstract class TasksEvent {}

class TasksInitialFetchEvent extends TasksEvent {}

class TasksAddEvent extends TasksEvent {
  final String title;
  final String description;
  final bool complete;
  TasksAddEvent(
      {required this.title, required this.description, required this.complete});
}

class TaskInitialAddEvent extends TasksEvent {}

class TaskDeleteEvent extends TasksEvent {
  final int id;
  TaskDeleteEvent({required this.id});
}

class TaskInitialUpdateEvent extends TasksEvent {
  final int id;
  final String initialText;
  final String initialDescription;

  TaskInitialUpdateEvent(
      {required this.id,
      required this.initialText,
      required this.initialDescription});
}

class TaskUpdateEvent extends TasksEvent {
  final int id;
  final String title;
  final String description;
  TaskUpdateEvent(
      {required this.id, required this.title, required this.description});
}
