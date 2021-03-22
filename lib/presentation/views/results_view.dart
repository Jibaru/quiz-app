import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';

import './home_view.dart';

class ResultsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Results',
                style: theme.textTheme.headline3,
              ),
              Consumer<QuestionProvider>(
                builder: (context, quiz, _) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total Score: ${quiz.correctAnswersCounter}/${quiz.totalQuestions}',
                          style: theme.textTheme.headline1.copyWith(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              RaisedButton(
                  child: Text(
                    'Return to Home',
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () => _toHome(context)),
            ],
          ),
        ),
      ),
    );
  }

  void _toHome(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeView()));
  }
}
