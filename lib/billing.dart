import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/pages/payment.dart';
import 'package:morningmagic/pages/payment_trial.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'my_const.dart';

class BillingService {
  PurchaserInfo purchaserInfo;
  Offerings offerings;

  init() async {
    await Purchases.setDebugLogsEnabled(false);
    await Purchases.setup(REVENUE_KEY);
    purchaserInfo = await Purchases.getPurchaserInfo();
    offerings = await Purchases.getOfferings();
  }

  bool isPro() {
    return purchaserInfo?.entitlements?.all["all_features"]?.isActive ?? false;
  }

  Package getMonthlyTarif() {
    if (offerings == null) return null;
    final offering = offerings.current;
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

  startPaymentPageTrial(BuildContext context) async {
    print('start payemt trial page');
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => PaymentPageTrial()));
  }
}
