import 'dart:collection';

import 'package:flutter/material.dart';

import '../services/question_service.dart';
import '../models/question.dart';

class QuestionProvider extends ChangeNotifier {
  final QuestionService _questionService;

  List<Question> _currentQuestions = [];

  bool _isCurrentQuestionAnswered = false;
  bool _isCurrentQuestionAnsweredOk = false;
  bool _isEnded = false;
  bool _isLoadingQuestions = false;
  bool _isSuccessLoaded = true;

  int _currentQuestionIndex = 0;
  int _correctAnswersCounter = 0;

  String _errorMessage = 'Failed to fetch';

  QuestionProvider({
    QuestionService questionService,
  })  : assert(questionService != null),
        _questionService = questionService;

  UnmodifiableListView<Question> get questions =>
      UnmodifiableListView(_currentQuestions);

  Question get currentQuestion =>
      _currentQuestions?.elementAt(_currentQuestionIndex);

  int get currentQuestionNumber => _currentQuestionIndex + 1;
  int get totalQuestions => _currentQuestions.length;
  int get correctAnswersCounter => _correctAnswersCounter;

  bool get isEnded => _isEnded;
  bool get isLoadingQuestions => _isLoadingQuestions;
  bool get isSuccessLoaded => _isSuccessLoaded;
  bool get isFinalQuestion =>
      _currentQuestions.isNotEmpty &&
      _currentQuestionIndex == _currentQuestions.length - 1;
  bool get isCurrentQuestionAnswered => _isCurrentQuestionAnswered;
  bool get isCurrentQuestionAnsweredOk => _isCurrentQuestionAnsweredOk;

  String get errorMessage => _errorMessage;

  void _initializeState() {
    _isSuccessLoaded = true;
    _currentQuestionIndex = 0;
    _correctAnswersCounter = 0;
    _isCurrentQuestionAnswered = false;
    _isCurrentQuestionAnsweredOk = false;
    _isEnded = false;
  }

  Future<void> loadQuestions() async {
    _isLoadingQuestions = true;
    notifyListeners();

    try {
      _currentQuestions = await _questionService.getQuestions();
      _initializeState();
    } on Exception catch (_) {
      _isSuccessLoaded = false;
    } finally {
      _isLoadingQuestions = false;
      notifyListeners();
    }
  }

  void checkAnswer(String answer) {
    _isCurrentQuestionAnswered = true;
    if (currentQuestion.correctAnswer == answer) {
      _isCurrentQuestionAnsweredOk = true;
      _correctAnswersCounter++;
    } else {
      _isCurrentQuestionAnsweredOk = false;
    }
    notifyListeners();
  }

  void nextQuestion() async {
    _isCurrentQuestionAnswered = false;
    _isCurrentQuestionAnsweredOk = false;
    _currentQuestionIndex++;

    if (_currentQuestionIndex >= _currentQuestions.length) {
      _currentQuestionIndex = 0;
      _isEnded = true;
    }

    notifyListeners();
  }
}
