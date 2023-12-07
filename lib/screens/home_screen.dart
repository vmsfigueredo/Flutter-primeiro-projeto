import 'package:flutter/material.dart';
import 'package:primeiro_projeto_em_flutter/data/task_dao.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
            color: Colors.white,
          )
        ],
        backgroundColor: Colors.blue,
        title: const Text(
          'Tarefas',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: Container(
          color: Colors.blue[100],
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 110),
            child: FutureBuilder(
                future: TaskDao().findAll(),
                builder: (context, snapshot) {
                  List<Task>? items = snapshot.data;
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      return const Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            Text(
                              'Carregando',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      );
                      break;
                    case ConnectionState.done:
                      if (snapshot.hasData && items != null) {
                        if (items.isNotEmpty) {
                          return ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (BuildContext context, int index) {
                                final Task task = items[index];
                                return task;
                              });
                        }
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 128,
                                color: Colors.white,
                              ),
                              Text(
                                'Não há nenhuma tarefa',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        );
                      }
                      break;
                  }
                  return const Center(
                    child: Text('Erro ao carregar Tarefas'),
                  );
                }),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (newContext) => NewTaskScreen(
                        taskContext: context,
                      ))).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
