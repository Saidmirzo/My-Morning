import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/services/analyticService.dart';
import 'package:morningmagic/app_states.dart';
import 'package:morningmagic/resources/my_const.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/my_url.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../resources/colors.dart';
import '../storage.dart';
import '../widgets/primary_button.dart';
import '../widgets/primary_circle_button.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  AppStates appStates = Get.put(AppStates());
  @override
  Widget build(BuildContext context) {
    String monthPrice =
        billingService.getPrice(billingService.getMonthlyTarif());
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(gradient: AppColors.Bg_Gradient_Payments),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  width: Get.width,
                  child: Image.asset(
                    'assets/images/purchase/clouds1.png',
                    fit: BoxFit.cover,
                  )),
              Positioned(
                  bottom: 0,
                  width: Get.width,
                  child: Image.asset(
                    'assets/images/purchase/clouds2.png',
                    fit: BoxFit.cover,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    buildHeader(),
                    Spacer(),
                    buildBonuses(),
                    // Spacer(),
                    const SizedBox(height: 10),
                    period('vip_price_card'.tr, monthPrice),
                    const SizedBox(height: 10),
                    // Spacer(),
                    buildDesc(monthPrice),
                    Spacer(),
                    btnBuy(),
                    Spacer(),
                    buildFooter(),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildBonuses() {
    return Column(
      children: [
        bonusLine('fitness'.tr, 'paragraph2'.tr,
            image: 'assets/images/purchase/fitness.png'),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            bonusSquare('visualization'.tr, 'paragraph4'.tr,
                image: 'assets/images/purchase/eye.png'),
            const SizedBox(height: 10),
            bonusSquare('reading'.tr, 'paragraph3'.tr,
                image: 'assets/images/purchase/book.png'),
            const SizedBox(height: 10),
            bonusSquare('note'.tr, 'paragraph1'.tr,
                image: 'assets/images/purchase/note.png'),
          ],
        ),
      ],
    );
  }

  Widget buildHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryCircleButton(
                icon: Icon(Icons.arrow_back, color: AppColors.primary),
                onPressed: () => Get.back()),
            Container(
              width: Get.width * 0.40,
              child: Text(
                'purchase_page_title'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: Get.height * 0.022),
              ),
            ),
            const SizedBox(width: 70),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'purchase_page_desc'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: Get.height * 0.017),
        ),
      ],
    );
  }

  Widget bonusSquare(String title, String desc, {String image}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18), color: Colors.white),
      width: Get.width * 0.28,
      height: Get.height * 0.16,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (image != null) Image.asset(image, height: Get.height * 0.03),
          const SizedBox(height: 10),
          Text(title,
              style: TextStyle(
                  fontSize: Get.height * 0.011,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary)),
          const SizedBox(height: 6),
          Text(desc,
              style: TextStyle(
                fontSize: Get.height * 0.011,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              )),
        ],
      ),
    );
  }

  Widget bonusLine(String title, String desc, {String image}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18), color: Colors.white),
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Get.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: Get.height * 0.013,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary)),
                const SizedBox(height: 8),
                Text(desc,
                    style: TextStyle(
                      fontSize: Get.height * 0.013,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    )),
              ],
            ),
          ),
          if (image != null) Image.asset(image, height: Get.height * 0.05),
        ],
      ),
    );
  }

  Widget period(String period, String price) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        children: [
          Text(
            period,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: Get.height * 0.022),
          ),
          Spacer(),
          Text(
            price,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: Get.height * 0.022),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: AppColors.primary, borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    );
  }

  Container buildDesc(String monthPrice) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.purchaseDesc.withOpacity(0.64),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          'try_vip_desc'.trParams({'price': monthPrice}),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: Get.height * 0.015),
        ));
  }

  Widget btnBuy() {
    return PrimaryButton(
      text: 'continue'.tr,
      pWidth: 0.5,
      onPressed: () async {
        try {
          await Purchases.purchasePackage(billingService.getMonthlyTarif());
          await AnalyticService.analytics
              .logEcommercePurchase(value: 75, currency: 'RUB');
        } on PlatformException catch (e) {
          var errorCode = PurchasesErrorHelper.getErrorCode(e);
          if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
            print("User cancelled");
          } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
            print("User not allowed to purchase");
          } else {
            print('Error purchase, code $errorCode');
          }
        }
      },
    );
  }

  Column buildFooter() {
    return Column(
      children: [
        new RichText(text: myUrl('privacy_title'.tr, UrlPrivacy)),
        const SizedBox(height: 5),
        new RichText(text: myUrl('agreement_title'.tr, UrlAgreement)),
      ],
    );
  }
}
