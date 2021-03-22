import 'package:flutter/foundation.dart';

enum Type { multiple, boolean }

extension Describer on Type {
  String get name => describeEnum(this);
}

extension TypeEnumExtension on String {
  Type toTypeEnum() => Type.values.firstWhere((d) => d.name == toLowerCase());
}
