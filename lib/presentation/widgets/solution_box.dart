import 'package:flutter/material.dart';

class SolutionBox extends StatelessWidget {
  final bool isOk;
  final String correctAnswer;

  SolutionBox({
    this.isOk,
    this.correctAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: isOk ? Colors.green : Colors.red,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              isOk ? 'Correct' : 'Bad!',
              style: theme.textTheme.bodyText1.copyWith(color: Colors.white),
            ),
            Text(
              'Correct answer: $correctAnswer',
              style: theme.textTheme.bodyText1.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
