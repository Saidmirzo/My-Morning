import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/visualization/data/repositories/visualization_image_repository_impl.dart';
import 'package:morningmagic/features/visualization/data/repositories/visualization_target_repository_impl.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/pages/payment.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../resources/my_const.dart';
import 'analitics/all.dart';

class BillingService {
  PurchaserInfo purchaserInfo;
  Offerings offerings;
  String oferingName;
  Offering _offering;

  var isVip = false.obs;

  init() async {
    await Purchases.setup(REVENUE_KEY);
    await Purchases.setDebugLogsEnabled(true);
    purchaserInfo = await Purchases.getPurchaserInfo();
    await getOfering();
    isVip.value = isPro();
  }

  Future<void> purchase(Package _package) async {
    purchaserInfo = await Purchases.purchasePackage(_package);
    isVip.value = isPro();
    if (isVip.value) {
      var c = Get.put(VisualizationController(
          hiveBox: myDbBox,
          targetRepository: VisualizationTargetRepositoryImpl(),
          imageRepository: VisualizationImageRepositoryImpl()));
      c.loadAllTargets();
    }
  }

  Future<void> getOfering() async {
    bool isInterviewed =
        MyDB().getBox().get(MyResource.IS_DONE_INTERVIEW, defaultValue: false);
    oferingName = !isInterviewed ? 'default' : 'vip_trial_14_days';
    offerings = await Purchases.getOfferings();
    _offering = offerings.getOffering(oferingName);
    print('offerings: $offerings');
  }

  bool isPro() {
    // Old, оставлю на время теста, может придется вернуь
    // bool isActive = (purchaserInfo?.entitlements?.active?.length ?? 0) > 0;
    // New
    bool isActive = (purchaserInfo?.activeSubscriptions?.length ?? 0) > 0;
    print('activeSubscriptions: ${purchaserInfo.activeSubscriptions}');
    return /* kDebugMode ? true : */ isActive;
  }

  Package get monthlyTarif => _offering?.monthly;
  Package get yearTarif => _offering?.annual;

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
    appAnalitics.logEvent('restore_click');
    isRestoring.value = false;
  }
}
