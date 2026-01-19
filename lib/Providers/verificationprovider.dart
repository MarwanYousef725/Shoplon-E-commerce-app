import 'package:flutter/material.dart';

class VerificationProvider with ChangeNotifier {
  String? _method;
  void selectMethod(String method) {
    _method = method;
    notifyListeners();
  }

  bool isSelected() => _method != null;
}
