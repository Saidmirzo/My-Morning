import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/resources/localization_service.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/services/notifications.dart';

Future<void> main() async {
  // Для выполнение действия через N время на андроид
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _initializeHiveStore();
  pushNotifications = PushNotifications();

  final _initialLocale = await LocalizationService.getInitialLocale();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(GetMaterialApp(
      initialRoute: AppRouting.initialRoute,
      onGenerateRoute: (settings) => AppRouting.generateRoute(settings),
      translations: LocalizationService(),
      locale: _initialLocale,
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
