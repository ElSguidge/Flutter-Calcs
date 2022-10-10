import 'package:flutter/material.dart';

class AirFlowButtonProvider extends ChangeNotifier {
  late bool displayArea = true;
  late bool displayRect = false;
  late bool displayRound = false;
  late bool displayFlat = false;
  late bool isStandardAir = true;
  late bool isKnownAirChange = true;

  void closeArea() {
    displayArea = true;
    displayRect = false;
    displayRound = false;
    displayFlat = false;
    notifyListeners();
  }

  void closeRect() {
    displayArea = false;
    displayRect = true;
    displayRound = false;
    displayFlat = false;
    notifyListeners();
  }

  void closeRound() {
    displayArea = false;
    displayRect = false;
    displayRound = true;
    displayFlat = false;
    notifyListeners();
  }

  void closeFlat() {
    displayArea = false;
    displayRect = false;
    displayRound = false;
    displayFlat = true;
    notifyListeners();
  }

  void standardAir(bool value) {
    isStandardAir = value;
    notifyListeners();
  }

  void knownACH(bool value) {
    isKnownAirChange = value;
    notifyListeners();
  }
}