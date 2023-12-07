import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:primeiro_projeto_em_flutter/components/task.dart';
import 'package:primeiro_projeto_em_flutter/data/task_dao.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key, required this.taskContext});

  final BuildContext taskContext;

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  bool difficultyValidator(String? value) {
    if (value != null && value.isEmpty) {
      if (int.parse(value) > 5 || int.parse(value) < 1) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Nova Tarefa',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          centerTitle: false,
        ),
        body: Container(
          color: Colors.blue[100],
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: 375,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (String? value) {
                            if (valueValidator(value)) {
                              return "Insira o nome da tarefa";
                            }
                            return null;
                          },
                          controller: titleController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                            hintText: 'Título da tarefa',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (String? value) {
                            if (difficultyValidator(value)) {
                              return "Insira uma dificuldade válida (1 a 5)";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          controller: difficultyController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                            hintText: 'Dificuldade da Tarefa',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (text) {
                            setState(() {});
                          },
                          validator: (String? value) {
                            if (valueValidator(value)) {
                              return "Insira uma imagem para a tarefa";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.url,
                          controller: imageController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                            hintText: 'Imagem',
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 72,
                        decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(4)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            imageController.text,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Image.asset(
                                'assets/images/noPhoto.jpg',
                                fit: BoxFit.cover,
                              );
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (kDebugMode) {
                              print(titleController.text);
                              print(int.parse(difficultyController.text));
                              print(imageController.text);
                            }

                            TaskDao().save(Task(
                                titleController.text,
                                imageController.text,
                                int.parse(difficultyController.text)));

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Tarefa adicionada!')));

                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Salvar'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
