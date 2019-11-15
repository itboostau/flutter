import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int _active = 0;

  int get active => active;

  void setActive(int i) {
    _active = i;
    notifyListeners();
  }
}
