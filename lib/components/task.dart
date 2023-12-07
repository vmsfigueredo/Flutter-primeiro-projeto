import 'package:flutter/material.dart';
import 'package:primeiro_projeto_em_flutter/data/task_dao.dart';

import 'difficulty.dart';

class Task extends StatefulWidget {
  final String title;
  final String picture;
  final int difficulty;

  Task(this.title, this.picture, this.difficulty, {super.key});

  int level = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool isNetwork() {
    if (widget.picture.contains('http')) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(4)),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(4)),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: isNetwork()
                            ? Image.network(
                                widget.picture,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                widget.picture,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(
                              widget.title,
                              style: const TextStyle(
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis),
                            )),
                        Difficulty(totalDifficulty: widget.difficulty)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(
                        onLongPress: (){
                          TaskDao().delete(widget.title);
                        },
                        onPressed: () {
                          setState(() {
                            widget.level++;
                          });
                        },
                        child: const SizedBox(
                          width: 25,
                          height: 52,
                          child: Column(
                            children: [
                              Icon(Icons.arrow_drop_up),
                              Text(
                                'UP',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 200,
                        child: LinearProgressIndicator(
                          value: widget.difficulty > 0
                              ? (widget.level / widget.difficulty) / 10
                              : widget.level / 10,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Nível: ${widget.level}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
