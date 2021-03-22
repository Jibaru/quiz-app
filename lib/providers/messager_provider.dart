import 'package:flutter/material.dart';

class MessagerProvider extends ChangeNotifier {
  String _errorMessage;

  String get errorMessage => _errorMessage;
  bool get hasErrorMessage => _errorMessage != null;

  void sendErrorMessage(String errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }
}
