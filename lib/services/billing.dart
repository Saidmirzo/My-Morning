import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:adapty_flutter/models/adapty_product.dart';
import 'package:adapty_flutter/models/adapty_purchaser_info.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/features/visualization/data/repositories/visualization_image_repository_impl.dart';
import 'package:morningmagic/features/visualization/data/repositories/visualization_target_repository_impl.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';

import 'ab_testing_service.dart';

class BillingService {
  AdaptyPurchaserInfo purchaserInfo;
  String oferingName;
  // List<AdaptyPaywall> paywalls = [];
  // List<AdaptyPaywall> _paywalls = [];

  var isVip = false.obs;

  init() async {
    purchaserInfo = await Adapty.getPurchaserInfo();
    // _fetchPaywalls();
    isVip.value = isPro();
    liadVisuzlisations();
  }

  Future<void> purchase(AdaptyProduct product) async {
    await Adapty.makePurchase(product);
    isVip.value = isPro();
  }

  void liadVisuzlisations() {
    VisualizationController(
            hiveBox: myDbBox,
            targetRepository: VisualizationTargetRepositoryImpl(),
            imageRepository: VisualizationImageRepositoryImpl())
        .reinit();
  }

  // Future<void> _fetchPaywalls() async {
  //   try {
  //     final GetPaywallsResult getPaywallsResult = await Adapty.getPaywalls();
  //     print('getPaywallsResult ${getPaywallsResult}');
  //     paywalls = getPaywallsResult.paywalls;
  //     // _paywalls = paywalls;
  //   } catch(e) {
  //     print(e);
  //   }
  // }

  // Future<Map<String, dynamic>> fetchDataForABTest(String id) async {
  //   final AdaptyPaywall _paywall = await getPaywall(id);
  //   return _paywall == null
  //       ? {} : _paywall.customPayload[AdaptyCustomPayloadKeys.abTestData];
  // }

  // Future<AdaptyPaywall> getPaywall(String param) async {
  //   try {
  //     if (paywalls.isEmpty) {
  //       final GetPaywallsResult getPaywallsResult = await Adapty.getPaywalls();
  //       paywalls = getPaywallsResult.paywalls;
  //       // print('getPaywallsResult ${getPaywallsResult}');
  //       // for(var i in paywalls) {
  //       //   print('paywalls $i');
  //       // }
  //     }
  //     final AdaptyPaywall bestPaywall =
  //     paywalls?.firstWhere((paywall) => paywall.developerId == param,
  //         orElse: () => null
  //     );
  //     if (bestPaywall != null) Adapty.logShowPaywall(paywall: bestPaywall);
  //
  //     return bestPaywall;
  //   }
  //   catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

  bool isPro() {
    // if (kDebugMode) return true;
    if (purchaserInfo?.accessLevels == null) {
      return false;
    } else {
      return purchaserInfo?.accessLevels['premium']?.isActive ?? false;
    }
  }

  // Package get monthlyTarif => _offering?.monthly;
  // Package get yearTarif => _offering?.annual;
  // Package get lifeTimeTarif => _offering?.lifetime;

  startPaymentPage() async {
    await Get.to(() => ABTestingService);
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
