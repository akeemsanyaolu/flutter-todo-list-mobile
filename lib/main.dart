import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_app/features/tasks/bloc/tasks_bloc.dart';
import 'package:flutter_todo_list_app/features/tasks/ui/tasks_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<TasksBloc>(
        create: (context) => TasksBloc(),
        child: const TasksPage(),
      ),
    );
  }
}
