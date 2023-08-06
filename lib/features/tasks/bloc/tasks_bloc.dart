import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_todo_list_app/features/tasks/models/task_data_ui_model.dart';
import 'package:flutter_todo_list_app/features/tasks/repos/task_repo.dart';
import 'package:meta/meta.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksInitial()) {
    on<TasksInitialFetchEvent>(tasksInitialFetchEvent);
    on<TasksAddEvent>(tasksAddEvent);
    on<TaskInitialAddEvent>(taskInitialAddEvent);
    on<TaskDeleteEvent>(taskDeleteEvent);
    on<TaskInitialUpdateEvent>(taskInitialUpdateEvent);
  }

  FutureOr<void> tasksInitialFetchEvent(
      TasksInitialFetchEvent event, Emitter<TasksState> emit) async {
    emit(TasksFetchingLoadingState());
    //await Future.delayed(const Duration(seconds: 1));
    var tasks = await TasksRepo.fetchTasks();
    emit(TasksFetchingSuccesfulState(tasks: tasks));
  }

  FutureOr<void> tasksAddEvent(
      TasksAddEvent event, Emitter<TasksState> emit) async {
    final title = event.title;
    final description = event.description;
    final complete = event.complete;
    final successBool = await TasksRepo.addTask(title, description, complete);
    if (successBool) {
      emit(TasksAdditionSuccessState());
    } else {
      emit(TasksAdditionErrorState());
    }
  }

  FutureOr<void> taskInitialAddEvent(
      TaskInitialAddEvent event, Emitter<TasksState> emit) {
    emit(TaskInitialAddState());
  }

  FutureOr<void> taskDeleteEvent(
      TaskDeleteEvent event, Emitter<TasksState> emit) async {
    final id = event.id;
    emit(TasksFetchingLoadingState());

    var response = await TasksRepo.deleteTask(id);

    if (response) {
      var tasks = await TasksRepo.fetchTasks();
      emit(TasksFetchingLoadingState());
      emit(TasksFetchingSuccesfulState(tasks: tasks));
    }
  }

  FutureOr<void> taskInitialUpdateEvent(
      TaskInitialUpdateEvent event, Emitter<TasksState> emit) {
    emit(TaskInitialUpdateState());
  }
}
