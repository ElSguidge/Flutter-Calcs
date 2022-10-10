import 'package:flutter/material.dart';

class AirTempButtons extends ChangeNotifier {
  late bool isCelcius = true;
  late bool isCelcius1 = true;
  late bool isFahrenheit = false;
  late bool isFahrenheit1 = false;
  late bool isR = false;
  late bool isR1 = false;
  late bool isK = false;
  late bool isK1 = false;

  void isC() {
    isCelcius = true;
    isFahrenheit = false;
    isR = false;
    isK = false;
    notifyListeners();
  }

  void isF() {
    isFahrenheit = true;
    isCelcius = false;
    isR = false;
    isK = false;
    notifyListeners();
  }

  void isRankine() {
    isCelcius = false;
    isR = true;
    isK = false;
    isFahrenheit = false;
    notifyListeners();
  }

  void isKelvin() {
    isCelcius = false;
    isFahrenheit = false;
    isK = true;
    isR = false;
    notifyListeners();
  }

  void isLowerCelcius() {
    isCelcius1 = true;
    isFahrenheit1 = false;
    isR1 = false;
    isK1 = false;
    notifyListeners();
  }

  void isLowerFahrenhiet() {
    isFahrenheit1 = true;
    isCelcius1 = false;
    isR1 = false;
    isK1 = false;
    notifyListeners();
  }

  void isLowerRankine() {
    isCelcius1 = false;
    isR1 = true;
    isK1 = false;
    isFahrenheit1 = false;
    notifyListeners();
  }

  void isLowerKelvin() {
    isCelcius1 = false;
    isFahrenheit1 = false;
    isK1 = true;
    isR1 = false;
    notifyListeners();
  }
}
