import 'dart:async';

import 'package:flutter/material.dart';

import '../../db/hive.dart';
import '../../db/resource.dart';
import '../../storage.dart';
//import 'package:get/state_manager.dart';

class PayWallProvider extends ChangeNotifier {
  int openedProductIndex = 1;
  bool isShowAds = true;

  initTimerAds() {
    if (myDbBox != null && myDbBox.get(MyResource.ADS_SHOW) != null) {
      isShowAds = true;
    } else {
      isShowAds = false;
      myDbBox.put(MyResource.ADS_SHOW, true);
    }
    isShowAds = !billingService.isVip.value;
  }

  void changeIndex(int i) {
    openedProductIndex = i;
    notifyListeners();
  }

  void startTimer() {
    isShowAds = false;
    notifyListeners();
    Timer.periodic(
      const Duration(hours: 1),
      (Timer timer) {
        isShowAds = true;
        notifyListeners();
        timer.cancel();
      },
    );
  }
}
