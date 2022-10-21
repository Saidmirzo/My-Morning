// ignore_for_file: constant_identifier_names

import 'dart:ui';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'langs/es.dart';
import 'langs/fr.dart';
import 'langs/ge.dart';
import 'langs/it.dart';
import 'langs/jp.dart';
import 'langs/po.dart';
import 'langs/ru.dart';
import 'langs/en.dart';

class LocalizationService extends Translations {
  static const String LOCALIZATION_KEY = 'localization_key';
  static const String RU = 'ru';
  static const String EN = 'en';
  static const String GE = 'de';
  static const String PO = 'pt';
  static const String JP = 'jp';
  static const String FR = 'fr';
  static const String ES = 'es';
  static const String IT = 'it';

  @override
  Map<String, Map<String, String>> get keys => {
        RU: translations_ru,
        EN: translations_en,
        GE: translations_ge,
        PO: translations_po,
        JP: translations_jp,
        FR: translations_fr,
        ES: translations_es,
        IT: translations_it,
      };

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
