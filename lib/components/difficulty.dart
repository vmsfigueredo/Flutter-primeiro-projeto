import 'package:flutter/material.dart';

class Difficulty extends StatelessWidget {
  final int totalDifficulty;

  const Difficulty({
    required this.totalDifficulty,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 15,
          color: (totalDifficulty >= 1) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (totalDifficulty >= 2) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (totalDifficulty >= 3) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (totalDifficulty >= 4) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (totalDifficulty >= 5) ? Colors.blue : Colors.blue[100],
        ),
      ],
    );
  }
}
