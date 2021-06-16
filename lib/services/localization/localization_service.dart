import 'dart:ui';

import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';

import 'langs/ru.dart';
import 'langs/en.dart';

class LocalizationService extends Translations {
  static const String LOCALIZATION_KEY = 'localization_key';
  static const String RU = 'ru';
  static const String EN = 'en';

  @override
  Map<String, Map<String, String>> get keys =>
      {RU: translations_ru, EN: translations_en};

  static Future<Locale> getInitialLocale() async {
    String _langCode = await MyDB()
        .getBox()
        .get(LOCALIZATION_KEY, defaultValue: Get.deviceLocale.languageCode);
    return Locale(_langCode);
  }

  static void switchLocale(String newLangCode) {
    final _newLocale = Locale(newLangCode);
    Get.updateLocale(_newLocale);
    MyDB().getBox().put(LOCALIZATION_KEY, newLangCode);
  }
}
