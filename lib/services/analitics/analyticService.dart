
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticService {
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static final FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  static Future<void> screenView(String screen) async {
    await analytics.setCurrentScreen(screenName: screen);
  }
}
