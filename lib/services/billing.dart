import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:adapty_flutter/models/adapty_error.dart';
import 'package:adapty_flutter/models/adapty_paywall.dart';
import 'package:adapty_flutter/models/adapty_product.dart';
import 'package:adapty_flutter/models/adapty_purchaser_info.dart';
import 'package:adapty_flutter/results/get_paywalls_result.dart';
import 'package:adapty_flutter/results/make_purchase_result.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:morningmagic/adjust_config.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/features/visualization/data/repositories/visualization_image_repository_impl.dart';
import 'package:morningmagic/features/visualization/data/repositories/visualization_target_repository_impl.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/pages/paywall/payment.dart';
import 'analitics/all.dart';

class BillingService {
  AdaptyPurchaserInfo purchaserInfo;
  String oferingName;

  var isVip = false.obs;

  init() async {
    purchaserInfo = await Adapty.getPurchaserInfo();
    isVip.value = isPro();
    liadVisuzlisations();
  }

  Future<void> purchase(AdaptyProduct product) async {
    await Adapty.makePurchase(product);
    isVip.value = isPro();
    AdJust.trackevent(AdJust.trialEvent);
  }

  void liadVisuzlisations() {
    VisualizationController(hiveBox: myDbBox, targetRepository: VisualizationTargetRepositoryImpl(), imageRepository: VisualizationImageRepositoryImpl()).reinit();
  }

  Future<AdaptyPaywall> getPaywall(String param) async {
    final GetPaywallsResult getPaywallsResult = await Adapty.getPaywalls();
    final List<AdaptyPaywall> paywalls = getPaywallsResult.paywalls;
    final AdaptyPaywall bestPaywall = paywalls?.firstWhere((paywall) => paywall.developerId == param);
    try {
      if (bestPaywall != null) Adapty.logShowPaywall(paywall: bestPaywall);
    } catch (e) {}

    return bestPaywall;
  }

  bool isPro() {
    // if (kDebugMode) return true;
    return purchaserInfo?.accessLevels['premium']?.isActive ?? false;
  }

  // Package get monthlyTarif => _offering?.monthly;
  // Package get yearTarif => _offering?.annual;
  // Package get lifeTimeTarif => _offering?.lifetime;

  startPaymentPage() async {
    await Get.to(PaymentPage());
  }

  var isRestoring = false.obs;
  void restore() async {
    isRestoring.value = true;
    // У нас автоматически восстанавливаются покупки
    // Но для большего спокойствия пользователей добавили кнопку
    // Эта кнопка повторно инициализирует сервис и проверяет наличие покупок
    await init();
    Get.snackbar('success'.tr, 'vip_restored'.tr);
    // appAnalitics.logEvent('restore_click');
    isRestoring.value = false;
  }
}
