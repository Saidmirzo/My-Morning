import 'dart:async';

import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:adapty_flutter/models/adapty_paywall.dart';
import 'package:adapty_flutter/models/adapty_product.dart';
import 'package:adapty_flutter/results/get_paywalls_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:install_referrer/install_referrer.dart';
import 'package:morningmagic/pages/onboarding/onboarding_version_one/onboarding_1_page.dart';
import 'package:morningmagic/pages/onboarding/onboarding_version_three/onboarding_page_1.dart';
import 'package:morningmagic/pages/onboarding/onboarding_version_two/on_boardingpage_1.dart';
import 'package:morningmagic/pages/paywall/new_paywall.dart';
import 'package:morningmagic/pages/paywall/paywall_v2/paywall_v2.dart';
import 'package:morningmagic/resources/remote_config_keys.dart';

class ABTestingService extends GetxService {
  static List<AdaptyPaywall> tests = [];
  static List<AdaptyProduct> products = [];

  static String paywallVersion = '';
  static String _onboardingVersion;

  static bool loading = false;

  ABTestingService() {
    init();
  }

  static Future<void> init() async {
    if (!loading) {
      try {
        loading = true;

        // Загружаем все пейволлы
        final GetPaywallsResult getPaywallsResult = await Adapty.getPaywalls();

        // Сохраняем в памяти данные
        tests = getPaywallsResult.paywalls;
        products = getPaywallsResult.products;

        // Определяем версию пейволла
        await fetchPaywallVersion();

        // Определяем версию онбординга
        await fetchOnboardingVersion();
      } catch (e) {
        print(e);
      } finally {
        loading = false;
      }
    }
  }

  static Future whileInit() async {
    return Future.doWhile(() => loading);
  }

  // Получаем А/Б тест по его идентификатору
  static Future<AdaptyPaywall> getTest(String param) async {
    try {
      // Если список тестов пуст
      if (tests.isEmpty) {
        // Загружаем тесты
        await init();
      }

      // Находим нужный тест
      final AdaptyPaywall bestPaywall =
          tests?.firstWhere((paywall) => paywall.developerId == param, orElse: () => null);
      if (bestPaywall != null) Adapty.logShowPaywall(paywall: bestPaywall);

      return bestPaywall;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Извлекаем версию онбординга
  static Future<void> fetchOnboardingVersion() async {
    try {
      // Определяем идентификатор А/Б теста с онбордингами
      String id = AdaptyCustomPayloadKeys.testOnboardingID;
      final InstallationAppReferrer referrer = await InstallReferrer.referrer;
      if (referrer == InstallationAppReferrer.iosTestFlight || kDebugMode) {
        id = AdaptyCustomPayloadKeys.internalABTestID;
      }

      // Извлекаем этот А/Б тест
      final AdaptyPaywall _test = await getTest(id);

      // Извлекаем данные из теста, если они есть
      if (_test != null &&
          _test.customPayload.containsKey(AdaptyCustomPayloadKeys.abTestData) &&
          _test.customPayload[AdaptyCustomPayloadKeys.abTestData]
              .containsKey(AdaptyCustomPayloadKeys.onboardingVersion)) {
        _onboardingVersion =
            _test.customPayload[AdaptyCustomPayloadKeys.abTestData][AdaptyCustomPayloadKeys.onboardingVersion];
        print('onboardingVersion $_onboardingVersion');
      }
    } catch (e) {
      print(e);
    }
  }

  // Извлекаем версию пейволла
  static Future<void> fetchPaywallVersion() async {
    try {
      // Извлекаем А/Б тест с пейволлами
      final AdaptyPaywall _test = await getTest(AdaptyCustomPayloadKeys.testPaywallID);

      // Извлекаем данные из теста, если они есть
      if (_test != null) {
        paywallVersion = _test.products.first.paywallName;
        print('paywallVersion $paywallVersion');
      }
    } catch (e) {
      print(e);
    }
  }

  // Возвращаем пейволл
  static Widget getPaywall([param]) {
    switch (paywallVersion) {
      case 'v1':
        return NewPaywall(isSettings: param ?? false);
      case 'v2':
        return PaywallV2(
          isSettings: param ?? false,
          onBack: param ?? false,
        );
      default:
        return NewPaywall(isSettings: param ?? false);
    }
  }

  // Возвращаем онбординг
  static Widget getOnboarding() {
    return const OnBoarding1Page();
    // return const OnboardingVersionSecondPage1();
    // return const OnboardingVersionThirdPageOne();
    // switch (_onboardingVersion) {
    //   case 'onbording_v1_1':
    //     return const OnBoarding1Page();
    //   case 'onbording_v2_1':
    //     return const OnboardingVersionSecondPage1();
    //   case 'onbording_v3_1':
    //     return const OnboardingVersionThirdPageOne();
    //   default:
    //     // for catch in test
    //     // throw Error();
    //     return const OnBoarding1Page();
    // }
  }
}
