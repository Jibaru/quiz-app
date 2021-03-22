import 'dart:convert';

import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;

import '../config/api.dart';
import '../models/question.dart';

class QuestionService {
  final HtmlUnescape unescape = HtmlUnescape();

  Future<List<Question>> getQuestions() async {
    try {
      final response = await http.get('$TRIVIA_API?amount=10');

      if (response.statusCode != 200) {
        throw new Exception('Data not found');
      }

      final jsonResponse = jsonDecode(response.body);

      return List.generate(
        (jsonResponse["results"] as List).length,
        (index) {
          _formatQuestionData(jsonResponse["results"][index]);
          return Question.fromJson(jsonResponse["results"][index]);
        },
      );
    } on Exception catch (e) {
      throw e;
    }
  }

  _formatQuestionData(Map<String, dynamic> question) {
    question['question'] = unescape.convert(question['question']);
    question['category'] = unescape.convert(question['category']);
    question['correct_answer'] = unescape.convert(question['correct_answer']);

    for (var i = (question['incorrect_answers'] as List).length - 1;
        i >= 0;
        i--) {
      question['incorrect_answers'][i] =
          unescape.convert(question['incorrect_answers'][i]);
    }
  }
}
