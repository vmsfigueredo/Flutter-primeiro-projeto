import 'package:flutter/material.dart';
import 'package:primeiro_projeto_em_flutter/data/task_inherited.dart';
import 'package:primeiro_projeto_em_flutter/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        // home: NewTaskScreen());
        home: TaskInherited(child: const HomeScreen()));
  }
}
