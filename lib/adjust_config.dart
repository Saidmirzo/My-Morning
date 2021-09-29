import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event.dart';
import 'package:flutter/foundation.dart';

class AdJust {
  static String tokenApp = 'b4fyvunr8g00';
  static String paySubsEvent = 'gxo7bc';
  static String trialEvent = 'hkop7u';
  static String installEvent = 'qlztiw';

  static trackevent(String event) {
    AdjustEvent adjustEvent = new AdjustEvent(event);
    Adjust.trackEvent(adjustEvent);
    print('track $event');
  }

  static initConfigAdJust() {
    print('init AdJust sdk');
    //AdjustEnvironment.sandbox - debug
    //AdjustEnvironment.production - release

    AdjustConfig config = new AdjustConfig(AdJust.tokenApp,
        kDebugMode ? AdjustEnvironment.sandbox : AdjustEnvironment.production);
    Adjust.start(config);
  }

  static getAdId() {
    Adjust.getGoogleAdId().then((value) {
      print('google ad: $value');
    });
  }
}
