import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/payment.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../resources/my_const.dart';

class BillingService {
  PurchaserInfo purchaserInfo;
  Offerings offerings;
  String oferingName;
  Offering _offering;

  init() async {
    await Purchases.setup(REVENUE_KEY);
    await Purchases.setDebugLogsEnabled(true);
    purchaserInfo = await Purchases.getPurchaserInfo();
    bool isInterviewed =
        MyDB().getBox().get(MyResource.IS_DONE_INTERVIEW, defaultValue: false);
    oferingName = !isInterviewed ? 'default' : 'vip_trial_14_days';
    offerings = await Purchases.getOfferings();
    _offering = offerings.getOffering(oferingName);
    print('offerings: $offerings');
  }

  bool isPro() {
    bool isActive = (purchaserInfo?.entitlements?.active?.length ?? 0) > 0;
    return kDebugMode ? true : isActive;
  }

  Package get monthlyTarif => _offering?.monthly;
  Package get yearTarif => _offering?.annual;

  startPaymentPage() async {
    await Get.to(PaymentPage());
  }
}
