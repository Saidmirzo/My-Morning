import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:adapty_flutter/models/adapty_enums.dart';
import 'package:adapty_flutter/models/adapty_error.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/services/localization/localization_service.dart';
import 'package:morningmagic/services/notifications.dart';
import 'package:morningmagic/utils/app_keys.dart';
import 'db/resource.dart';
import 'services/progress.dart';

Future<void> main() async {
  // Для выполнение действия через N время на андроид
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  Adapty.activate();
  try {
    Adapty.setLogLevel(AdaptyLogLevel.verbose);
  } on AdaptyError catch (adaptyError) {
  } catch (e) {}
  AppMetrica.activate(AppMetricaConfig("d0444ec3-134e-4d78-a896-8f82dbfe24e9"));
  AppMetrica.reportEvent('session_start');
  await _initializeHiveStore();
  if (myDbBox != null && myDbBox.get(MyResource.USER_KEY) != null) pushNotifications = PushNotifications();
  Get.put(ProgressController());

  final _initialLocale = await LocalizationService.getInitialLocale();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async {
    runApp(GetMaterialApp(
      navigatorKey: AppKeys.navigatorKey,
      initialRoute: AppRouting.initialRoute,
      onGenerateRoute: (settings) => AppRouting.generateRoute(settings),
      translations: LocalizationService(),
      locale: _initialLocale,
      theme: ThemeData(fontFamily: 'Montserrat'),
      supportedLocales: [
        Locale(LocalizationService.EN),
        Locale(LocalizationService.RU),
      ],
      fallbackLocale: Locale(LocalizationService.EN),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    ));
  });
}

_initializeHiveStore() async {
  try {
    await MyDB().initHiveDatabase();
  } catch (e) {
    print('Hive initialization error: $e');
  }
}
