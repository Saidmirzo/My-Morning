import 'package:flutter/material.dart';

class PickerProvider extends ChangeNotifier {
  int hour = TimeOfDay.now().hour;
  int minute = TimeOfDay.now().minute;

  bool isSelectedHour = true;

  void changeHour(double val) {
    hour = val.toInt();
    notifyListeners();
  }

  void changeMinute(double val) {
    minute = val.toInt();
    notifyListeners();
  }

  void selectTimeType(bool isSelectedHour){
    this.isSelectedHour = isSelectedHour;
    notifyListeners();
  }
}
