import 'package:flutter/material.dart';
import 'package:primeiro_projeto_em_flutter/data/task_inherited.dart';
import 'package:primeiro_projeto_em_flutter/screens/new_task_screen.dart';

import '../components/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Tarefas',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: Container(
        color: Colors.blue[100],
        child: ListView(
          padding: const EdgeInsets.only(top: 8, bottom: 70),
          children: TaskInherited.of(context).taskList,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (newContext) => NewTaskScreen(
                        taskContext: context,
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
