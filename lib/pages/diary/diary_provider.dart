import 'package:flutter/material.dart';

class DiaryProvider extends ChangeNotifier {
  int i = -1;

  void selectAudio(int i){
    this.i = i;
    notifyListeners();
  }

  void onDispose(){
    i = -1;
  }
}