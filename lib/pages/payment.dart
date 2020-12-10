import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/analyticService.dart';
import 'package:morningmagic/app_states.dart';
import 'package:morningmagic/my_const.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/my_url.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../storage.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Size size;
  AppStates appStates = Get.put(AppStates());
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    String monthPrice =
        billingService.getPrice(billingService.getMonthlyTarif());
    return Scaffold(
      backgroundColor: AppColors.CREAM,
      appBar: AppBar(
        backgroundColor: AppColors.CREAM,
        elevation: 0,
        iconTheme: IconThemeData(
          color: AppColors.GRAY,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    paragraph('paragraph1'.tr()),
                    const SizedBox(height: 10),
                    paragraph('paragraph2'.tr()),
                    const SizedBox(height: 10),
                    paragraph('paragraph3'.tr()),
                    const SizedBox(height: 10),
                    paragraph('paragraph4'.tr()),
                  ],
                ),
                const SizedBox(height: 50),
                Column(
                  children: [
                    period(
                        'vip_price_card'.tr(namedArgs: {'price': monthPrice}),
                        120),
                    const SizedBox(height: 20),
                    Container(
                        width: 300,
                        child: Text(
                          'try_vip_desc'.tr(namedArgs: {'price': monthPrice}),
                          textAlign: TextAlign.center,
                        )),
                    const SizedBox(height: 20),
                    btnBuy()
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    new RichText(text: myUrl('privacy_title'.tr(), UrlPrivacy)),
                    new RichText(
                        text: myUrl('agreement_title'.tr(), UrlAgreement)),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget btnBuy() {
    return Container(
      width: size.width * 0.7,
      height: 60,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text('continue'.tr(),
            style: TextStyle(color: Colors.white, fontSize: 23)),
        color: AppColors.PINK,
        onPressed: () async {
          try {
            await Purchases.purchasePackage(billingService.getMonthlyTarif());
            await AnalyticService.analytics.logEcommercePurchase(
              value: 75,
              currency: 'RUB',
            );
          } on PlatformException catch (e) {
            var errorCode = PurchasesErrorHelper.getErrorCode(e);
            if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
              print("User cancelled");
            } else if (errorCode ==
                PurchasesErrorCode.purchaseNotAllowedError) {
              print("User not allowed to purchase");
            } else {
              print('Error purchase, code $errorCode');
            }
          }
        },
      ),
    );
  }

  Widget period(String text, double size) {
    return Container(
      alignment: Alignment.center,
      width: size,
      height: size,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.VIOLET, fontWeight: FontWeight.w600, fontSize: 20),
      ),
      decoration: BoxDecoration(
          color: AppColors.LIGHT_CREAM,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black)),
    );
  }

  Widget paragraph(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.done),
        const SizedBox(width: 10),
        Container(
          width: size.width * 0.8,
          child: Text(
            text,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(fontSize: 17),
          ),
        )
      ],
    );
  }
}
