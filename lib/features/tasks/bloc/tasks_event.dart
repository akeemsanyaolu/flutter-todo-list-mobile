part of 'tasks_bloc.dart';

@immutable
abstract class TasksEvent {}

class TasksInitialFetchEvent extends TasksEvent {}

class TasksAddEvent extends TasksEvent {
  String title;
  String description;
  bool complete;
  TasksAddEvent(
      {required this.title, required this.description, required this.complete});
}

class TaskInitialAddEvent extends TasksEvent {}

class TaskDeleteEvent extends TasksEvent {
  int id;
  TaskDeleteEvent({required this.id});
}
