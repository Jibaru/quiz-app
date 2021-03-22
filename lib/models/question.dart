import './difficulty.dart';
import './type.dart';

class Question {
  final String category;
  final Type type;
  final Difficulty difficulty;
  final String content;
  final List<String> answers;
  final String correctAnswer;

  Question({
    this.category,
    this.type,
    this.difficulty,
    this.content,
    this.answers,
    this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      category: json['category'] as String,
      type: (json['type'] as String).toTypeEnum(),
      difficulty: (json['difficulty'] as String).toDifficultyEnum(),
      content: json['question'] as String,
      answers: List.from(json['incorrect_answers'])
        ..add(json['correct_answer']),
      correctAnswer: json['correct_answer'] as String,
    );
  }
}
