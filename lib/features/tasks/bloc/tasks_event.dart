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

class TaskInitialUpdateEvent extends TasksEvent {}

class TaskUpdateEvent extends TasksEvent {
  final int id;
  TaskUpdateEvent({required this.id});
}
