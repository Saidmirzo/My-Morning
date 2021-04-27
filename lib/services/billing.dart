import 'dart:developer';

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
  String monthTarif;

  init() async {
    await Purchases.setDebugLogsEnabled(false);
    await Purchases.setup(REVENUE_KEY);
    purchaserInfo = await Purchases.getPurchaserInfo();
    offerings = await Purchases.getOfferings();
    bool isInterviewed =
        MyDB().getBox().get(MyResource.IS_DONE_INTERVIEW, defaultValue: false);
    monthTarif = GetPlatform.isAndroid
        ? isInterviewed
            ? 'vip_token_key_14'
            : 'default'
        : isInterviewed
            ? "all_features_14"
            : "all_features";
  }

  bool isPro() {
    bool isActive = (purchaserInfo?.entitlements?.active?.length ?? 0) > 0;
    return kDebugMode ? true : isActive;
  }

  Package getMonthlyTarif() {
    if (offerings == null) return null;
    print('offerings: $offerings');
    print('monthtarif: $monthTarif');
    final offering = offerings.getOffering(monthTarif);
    print('offering: $offering');
    if (offering == null) return null;
    return offering.monthly;
  }

  String getPrice(Package package) {
    return package?.product?.priceString ?? "vip_def_month_price".tr;
  }

  startPaymentPage(BuildContext context) async {
    print('start payemt page');
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => PaymentPage()));
  }
}
