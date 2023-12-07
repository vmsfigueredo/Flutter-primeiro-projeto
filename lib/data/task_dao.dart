import 'package:primeiro_projeto_em_flutter/components/task.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_title TEXT, '
      '$_difficulty INTEGER, '
      '$_picture TEXT)';

  static const String _tablename = 'tasks';
  static const String _title = 'title';
  static const String _difficulty = 'difficulty';
  static const String _picture = 'picture';

  save(Task task) async {
    print('Iniciando o save: ');
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(task.title);
    Map<String, dynamic> taskMap = toMap(task);
    if (itemExists.isEmpty) {
      print('a Tarefa não Existia.');
      return await bancoDeDados.insert(_tablename, taskMap);
    } else {
      print('a Tarefa existia!');
      return await bancoDeDados.update(
        _tablename,
        taskMap,
        where: '$_title = ?',
        whereArgs: [task.title],
      );
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    print('Convertendo to Map: ');
    final Map<String, dynamic> mapaDeTarefas = {};
    mapaDeTarefas[_title] = tarefa.title;
    mapaDeTarefas[_difficulty] = tarefa.difficulty;
    mapaDeTarefas[_picture] = tarefa.picture;
    print('Mapa de Tarefas: $mapaDeTarefas');
    return mapaDeTarefas;
  }

  Future<List<Task>> findAll() async {
    print('Acessando o findAll: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print('Procurando dados no banco de dados... encontrado: $result');
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print('Convertendo to List:');
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(
        linha[_title],
        linha[_picture],
        linha[_difficulty],
      );
      tarefas.add(tarefa);
    }
    print('Lista de Tarefas: ${tarefas.toString()}');
    return tarefas;
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    print('Acessando find: ');
    final Database bancoDeDados = await getDatabase();
    print('Procurando tarefa com o nome: ${nomeDaTarefa}');
    final List<Map<String, dynamic>> result = await bancoDeDados
        .query(_tablename, where: '$_title = ?', whereArgs: [nomeDaTarefa]);
    print('Tarefa encontrada: ${toList(result)}');

    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    print('Deletando tarefa: $nomeDaTarefa');
    final Database bancoDeDados = await getDatabase();
    return await bancoDeDados.delete(
      _tablename,
      where: '$_title = ?',
      whereArgs: [nomeDaTarefa],
    );
  }
}
