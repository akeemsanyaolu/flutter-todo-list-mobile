import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_app/features/tasks/bloc/tasks_bloc.dart';

class UpdateTaskPage extends StatefulWidget {
  final String initialText;
  final String initialDescription;
  const UpdateTaskPage(
      {super.key, required this.initialText, required this.initialDescription});

  @override
  State<UpdateTaskPage> createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                context.read<TasksBloc>().add(TaskUpdateEvent(
                      id: 1,
                      title: _title.text,
                      description: _description.text,
                    ));
                context.read<TasksBloc>().add(TasksInitialFetchEvent());
              },
              child: const Text('Update'))
        ],
      ),
    );
  }
}
