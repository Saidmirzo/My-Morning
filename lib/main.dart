import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:adapty_flutter/models/adapty_enums.dart';
import 'package:adapty_flutter/models/adapty_error.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:appodeal_flutter/appodeal_flutter.dart' as appo;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:morningmagic/can_save.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/pages/diary/diary_provider.dart';
import 'package:morningmagic/pages/paywall/paywall_provider.dart';
import 'package:morningmagic/pages/reading/reading_provider.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/services/injections.dart';
import 'package:morningmagic/services/localization/localization_service.dart';
import 'package:morningmagic/services/notifications.dart';
import 'package:morningmagic/utils/app_keys.dart';
import 'package:provider/provider.dart';

import 'db/resource.dart';
import 'services/progress.dart';

Future<void> main() async {
  // Для выполнение действия через N время на андроид
  WidgetsFlutterBinding.ensureInitialized();
  await setInjections();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  Adapty.activate();
  try {
    Adapty.setLogLevel(AdaptyLogLevel.verbose);
  } on AdaptyError {}
  AppMetrica.activate(
    const AppMetricaConfig("d0444ec3-134e-4d78-a896-8f82dbfe24e9"),
  );
  AppMetrica.reportEvent('session_start');
  await _initializeHiveStore();
  if (myDbBox != null && myDbBox.get(MyResource.USER_KEY) != null) {
    pushNotifications = PushNotifications();
  }
  Get.put(ProgressController());
  appo.Appodeal.setAppKeys(
    androidAppKey: '3ff46b9b1c8e9177665c6f5e3c70fe466ffc0c5539f0c476',
    iosAppKey: '985706b731e5dfc16d5208cc6ed049c49b54c20065b6491d',
  );

  await appo.Appodeal.initialize(
    hasConsent: true,
    adTypes: [
      appo.AdType.banner,
      appo.AdType.mrec,
      appo.AdType.interstitial,
      appo.AdType.reward,
      appo.AdType.nonSkippable
    ],
    testMode: true,
    verbose: true,
  );

  final _initialLocale = await LocalizationService.getInitialLocale();
  CanSave.savingModel = myDbBox.get('savingModel') != null
      ? SavingModel.fromMap(Map<String, dynamic>.from(myDbBox.get('savingModel')))
      : SavingModel();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) async {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => PayWallProvider()..initTimerAds(),
            ),
            ChangeNotifierProvider(
              create: (context) => ReadingProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => DiaryProvider(),
            ),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: AppKeys.navigatorKey,
            initialRoute: AppRouting.initialRoute,
            // home: OTO(),
            // home: const NewPaywall(),
            // home: PaywallPage(),
            onGenerateRoute: (settings) => AppRouting.generateRoute(settings),
            translations: LocalizationService(),
            locale: _initialLocale,
            theme: ThemeData(fontFamily: 'Montserrat'),
            supportedLocales: const [
              Locale(LocalizationService.EN),
              Locale(LocalizationService.RU),
              Locale(LocalizationService.GE),
              Locale(LocalizationService.PO),
            ],
            fallbackLocale: const Locale(LocalizationService.EN),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          ),
        ),
      );
    },
  );
}

_initializeHiveStore() async {
  try {
    await MyDB().initHiveDatabase();
  } catch (e) {
    debugPrint('Hive error: $e');
  }
}
