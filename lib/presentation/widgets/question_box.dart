import 'package:flutter/material.dart';

class QuestionBox extends StatelessWidget {
  final String question;
  final String difficulty;
  final List<String> answers;
  final void Function(String selectedAnswer) onPressAnswer;

  QuestionBox({
    this.question,
    this.difficulty,
    this.answers,
    this.onPressAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Chip(
                  label: Text(
                    '${difficulty.toUpperCase()}',
                  ),
                ),
              ],
            ),
            Text(
              question,
              style: theme.textTheme.headline1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        SizedBox(
          height: 40.0,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...answers.map<Widget>((answer) {
              return Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Text(
                    answer,
                    style: theme.textTheme.button,
                  ),
                  onPressed: onPressAnswer != null
                      ? () => onPressAnswer.call(answer)
                      : null,
                ),
              );
            }).toList()
          ],
        ),
      ],
    );
  }
}
