import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeiro_projeto_em_flutter/components/task.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  int timesPressed = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          timesPressed.toString(),
          style: const TextStyle(
              color: Colors.red,
              fontSize: 60,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none),
        ),
        CupertinoButton(onPressed: () {}, child: const Icon(CupertinoIcons.add))
      ],
    ));
  }
}
