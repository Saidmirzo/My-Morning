import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../storage.dart';

const int maxFailedLoadAttempts = 5;

class AdmobService {
  static final String interstitialId = kDebugMode
      ? 'ca-app-pub-3940256099942544/8691691433'
      : Platform.isAndroid
          ? 'ca-app-pub-8444251353824953/5675746746'
          : 'ca-app-pub-8444251353824953/8111156632';

  InterstitialAd _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  AdmobService() {
    createInterstitialAd();
  }

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        },
      ),
    );
  }

  void showInterstitial() async {
    if (billingService.isVip.value) {
      print('Notice: мы не будем показывать рекламу ВИП юзерам');
      return;
    }

    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd?.show();
    _interstitialAd = null;
  }
}

AdmobService admobService = AdmobService();
