import 'package:flutter/material.dart';

class Onboarding extends ChangeNotifier {
  int selectedind = 0;
  void ChangeInd(int ind) {
    selectedind = ind;
    notifyListeners();
  }
}
