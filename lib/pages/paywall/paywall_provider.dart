import 'package:flutter/material.dart';
//import 'package:get/state_manager.dart';

class PayWallProvider extends ChangeNotifier {
  int openedProductIndex = 1;

  void changeIndex(int i) {
    openedProductIndex = i;
    notifyListeners();
  }
}
