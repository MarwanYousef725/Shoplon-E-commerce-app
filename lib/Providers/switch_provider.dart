import 'package:flutter/material.dart';

class SwitchProvider extends ChangeNotifier {
  bool turn = false;
  void changeTurn(bool turn) {
    this.turn = turn;
    notifyListeners();
  }
}
