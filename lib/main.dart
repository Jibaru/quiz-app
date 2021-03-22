import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/providers.dart';
import './services/services.dart';
import './app.dart';

void main() {
  final QuestionService questionService = QuestionService();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => QuestionProvider(questionService: questionService),
      ),
      ChangeNotifierProvider(
        create: (context) => MessagerProvider(),
      ),
    ],
    child: MyApp(),
  ));
}
