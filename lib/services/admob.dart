import 'dart:io' show Platform;

import 'package:firebase_admob/firebase_admob.dart';

import '../storage.dart';

class AdmobService {
  static final String appId = Platform.isAndroid
      ? 'ca-app-pub-8444251353824953~3273634678'
      : Platform.isIOS
          ? 'ca-app-pub-8444251353824953~3943846765'
          : FirebaseAdMob.testAppId;
  static final String interstitialId = Platform.isAndroid
      ? 'ca-app-pub-8444251353824953/5675746746'
      : Platform.isIOS
          ? 'ca-app-pub-8444251353824953/8111156632'
          : InterstitialAd.testAdUnitId;

  InterstitialAd myInterstitial;

  AdmobService() {
    initInterstitial();
  }

  void initInterstitial() {
    myInterstitial?.dispose();

    myInterstitial = InterstitialAd(
      adUnitId: interstitialId,
      listener: (MobileAdEvent event) {
        switch (event) {
          case MobileAdEvent.failedToLoad:
          case MobileAdEvent.closed:
            initInterstitial();
            break;
          default:
            break;
        }
      },
    );
    myInterstitial.load();
  }

  void showInterstitial() async {
    billingService.isPro()
        ? print('Нельзя показать межстраничную рекламу, это VIP пользователь')
        : print('Пытаюсь запустить рекламу');
    if (await myInterstitial.isLoaded())
      myInterstitial.show();
    else
      print('Межстраничная реклама еще не загружена');
  }
}

AdmobService admobService = AdmobService();
