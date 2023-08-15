import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/features/tasks/bloc/tasks_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_app/features/tasks/ui/update_task_page.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  //final taskBloc = TasksBloc();
  @override
  void initState() {
    super.initState();
    //taskBloc.add(TasksInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    context.read<TasksBloc>().add(TasksInitialFetchEvent());
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case TasksFetchingSuccesfulState:
            return const TasksListPage();
          case TaskInitialAddState:
            return const AddTaskPage();
          case TaskInitialUpdateState:
            final successState =
                context.read<TasksBloc>().state as TaskInitialUpdateState;
            return UpdateTaskPage(
                initialText: successState.initialText,
                initialDescription: successState.initialDescription);
          default:
            return const LoadingPage();
        }

        //         final successState = state as TasksFetchingSuccesfulState;
        //         return ListView.builder(
        //           itemCount: successState.tasks.length,
        //           itemBuilder: (context, index) {
        //             return TasksWidget(
        //                 successState: successState, index: index);
        //           },
        //         );
        //       case TaskInitialAddState:
        //         return const AddTaskPage();

        //       case TasksAdditionSuccessState:
        //         final successState = state as TasksFetchingSuccesfulState;
        //         return ListView.builder(
        //           itemCount: successState.tasks.length,
        //           itemBuilder: (context, index) {
        //             return TasksWidget(
        //                 successState: successState, index: index);
        //           },
        //         );

        //       case TasksAdditionErrorState:
        //         return const Center(
        //           child: Text('Error Occured... Please try again later'),
        //         );

        //       default:
        //         return const SizedBox();
        //     }
        //   },
        // ),
      },
    );
  }
}

class TasksListPage extends StatelessWidget {
  const TasksListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final successState =
        context.read<TasksBloc>().state as TasksFetchingSuccesfulState;
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: ListView.builder(
          itemCount: successState.tasks.length,
          itemBuilder: (context, index) {
            return TasksWidget(successState: successState, index: index);
          }),
      floatingActionButton: FloatingActionButton(onPressed: () {
        context.read<TasksBloc>().add(TaskInitialAddEvent());
      }),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  context.read<TasksBloc>().add(TasksInitialFetchEvent());
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: Column(
            children: [
              TextField(
                decoration: const InputDecoration(hintText: 'Title'),
                controller: _title,
                autofocus: true,
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'Description'),
                controller: _description,
                keyboardType: TextInputType.multiline,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<TasksBloc>().add(TasksAddEvent(
                        title: _title.text,
                        description: _description.text,
                        complete: true));
                    context.read<TasksBloc>().add(TasksInitialFetchEvent());
                  },
                  child: const Text('Create'))
            ],
          ),
        );
      },
    );
  }
}

class TasksWidget extends StatefulWidget {
  final successState;
  final index;
  const TasksWidget(
      {super.key, required this.successState, required this.index});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent)),
      onPressed: () {
        context.read<TasksBloc>().add(TaskInitialUpdateEvent(
            id: widget.successState.tasks[widget.index].id,
            initialText: widget.successState.tasks[widget.index].title,
            initialDescription:
                widget.successState.tasks[widget.index].description));
      },
      child: Container(
        color: Colors.grey.shade200,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.successState.tasks[widget.index].title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(widget.successState.tasks[widget.index].description),
              ],
            ),
            IconButton(
                onPressed: () {
                  context.read<TasksBloc>().add(TaskDeleteEvent(
                      id: widget.successState.tasks[widget.index].id));
                },
                icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
