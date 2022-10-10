import 'package:flutter/material.dart';

class AreaButtonProvider extends ChangeNotifier {
  late bool displayRect = true;
  late bool displayRound = false;
  late bool displayFlat = false;

  void closeRect() {
    displayRect = true;
    displayRound = false;
    displayFlat = false;
    notifyListeners();
  }

  void closeRound() {
    displayRect = false;
    displayRound = true;
    displayFlat = false;
    notifyListeners();
  }

  void closeFlat() {
    displayRect = false;
    displayRound = false;
    displayFlat = true;
    notifyListeners();
  }
}
