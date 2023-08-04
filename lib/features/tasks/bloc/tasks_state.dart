part of 'tasks_bloc.dart';

@immutable
abstract class TasksState {}

abstract class TasksActionState extends TasksState {}

class TasksInitial extends TasksState {}

class TasksFetchingLoadingState extends TasksState {}

class TasksFetchingSuccesfulState extends TasksState {
  List<TaskDataUiModel> tasks;
  TasksFetchingSuccesfulState({required this.tasks});
}

class TaskInitialAddState extends TasksActionState {}

class TasksAdditionSuccessState extends TasksActionState {}

class TasksAdditionErrorState extends TasksActionState {}

class TaskDeleteState extends TasksActionState {}
