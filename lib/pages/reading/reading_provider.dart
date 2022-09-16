import 'package:flutter/foundation.dart';

class ReadingProvider extends ChangeNotifier {
  int selectedButtonIndex = 0;

  void onSelect(int i){
    selectedButtonIndex = i;
    notifyListeners();
  }
}