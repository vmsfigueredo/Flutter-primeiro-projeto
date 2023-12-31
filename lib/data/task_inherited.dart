import 'package:flutter/material.dart';
import 'package:primeiro_projeto_em_flutter/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required Widget child,
  }) : super(child: child);

  final List<Task> taskList = [
    Task("Aprender Flutter", 'assets/images/flutter.png', 3),
    Task("Andar de Bike", 'assets/images/bike.jpg', 2),
    Task("Meditar", 'assets/images/meditar.jpg', 5),
    Task("Correr", 'assets/images/correr.jpg', 4),
    Task("Jogar", 'assets/images/jogar.webp', 1),
  ];

  void newTask(String name, String picture, int difficulty) {
    taskList.add(Task( name, picture, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
