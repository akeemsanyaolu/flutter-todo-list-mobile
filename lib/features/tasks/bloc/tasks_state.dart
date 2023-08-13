part of 'tasks_bloc.dart';

@immutable
abstract class TasksState {}

abstract class TasksActionState extends TasksState {}

class TasksInitial extends TasksState {}

class TasksFetchingLoadingState extends TasksState {}

class TasksFetchingSuccesfulState extends TasksState {
  final List<TaskDataUiModel> tasks;
  TasksFetchingSuccesfulState({required this.tasks});
}

class TaskInitialAddState extends TasksActionState {}

class TasksAdditionSuccessState extends TasksActionState {}

class TasksAdditionErrorState extends TasksActionState {}

class TaskDeleteState extends TasksActionState {}

class TaskInitialUpdateState extends TasksActionState {
  final int id;
  final String initialText;
  final String initialDescription;

  TaskInitialUpdateState({
    required this.id,
    required this.initialText,
    required this.initialDescription,
  });
}

class TaskUpdateState extends TasksActionState {}
