import 'analyticService.dart';
import 'facebook_analitics.dart';

class AppAnalitics {
  // Объединим отправку но оставим возможность отключить в отдельную сеть
  void logEvent(String name,
      {bool logFacebook = true,
      bool logFirebase = true,
      Map<String, dynamic> params}) {
    if (logFacebook) fbAppEvents.logEvent(name: name, parameters: params);
    if (logFirebase) {
      AnalyticService.analytics.logEvent(name: name, parameters: params);
    }
  }
}

AppAnalitics appAnalitics = AppAnalitics();
