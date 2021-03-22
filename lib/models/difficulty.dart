import 'package:flutter/foundation.dart';

enum Difficulty { easy, medium, hard }

extension Describer on Difficulty {
  String get name => describeEnum(this);
}

extension DifficultyEnumExtension on String {
  Difficulty toDifficultyEnum() =>
      Difficulty.values.firstWhere((d) => d.name == toLowerCase());
}
