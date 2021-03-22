import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';
import '../../models/difficulty.dart';
import '../widgets/question_box.dart';
import '../widgets/solution_box.dart';

import './results_view.dart';

class QuestionView extends StatefulWidget {
  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  final EdgeInsets _scrollPadding = const EdgeInsets.all(20.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: mediaQuery.size.height,
          child: SingleChildScrollView(
            padding: _scrollPadding,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: mediaQuery.size.height -
                    _scrollPadding.top -
                    _scrollPadding.bottom -
                    mediaQuery.padding.top,
              ),
              child: Consumer<QuestionProvider>(
                builder: (context, quiz, child) {
                  final question = quiz.currentQuestion;

                  if (question == null) {
                    return Center(
                      child: Text('Empty'),
                    );
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      QuestionBox(
                        question: question.content,
                        difficulty: question.difficulty.name,
                        answers: question.answers,
                        onPressAnswer: quiz.isCurrentQuestionAnswered
                            ? null
                            : (answer) => _answerQuestion(answer, quiz),
                      ),
                      if (quiz.isCurrentQuestionAnswered)
                        SolutionBox(
                          isOk: quiz.isCurrentQuestionAnsweredOk,
                          correctAnswer: question.correctAnswer,
                        ),
                      RaisedButton(
                        child: Text(
                          'Next Question',
                          style: theme.textTheme.button,
                        ),
                        onPressed: quiz.isCurrentQuestionAnswered
                            ? (quiz.isFinalQuestion
                                ? _toResults
                                : () => _nextQuestion(quiz))
                            : null,
                      ),
                      Text(
                        '${quiz.currentQuestionNumber}/${quiz.totalQuestions}',
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  _answerQuestion(String answer, QuestionProvider quiz) {
    quiz.checkAnswer(answer);
  }

  _nextQuestion(QuestionProvider quiz) {
    quiz.nextQuestion();
  }

  _toResults() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: ResultsView(),
        );
      },
    );
  }
}
