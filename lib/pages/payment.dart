import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
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
  bool isInterviewed = false;
  int tryalDays = 7;
  PageController _pageController =
      PageController(viewportFraction: .9, initialPage: 0);
  RxInt _page = 0.obs;

  @override
  void initState() {
    _pageController.addListener(() {
      _page.value = _pageController.page.round();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isInterviewed =
        MyDB().getBox().get(MyResource.IS_DONE_INTERVIEW, defaultValue: false);
    tryalDays = isInterviewed ? 14 : 7;
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
              Column(
                children: [
                  buildHeader(),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Image.asset('purchase_bonuses_image'.tr,
                        fit: BoxFit.fitWidth),
                  ),
                  Spacer(),
                  buildDesc(),
                  Spacer(),
                  btnBuy(),
                  const SizedBox(height: 5),
                  restoreBtn(),
                  Spacer(),
                  buildFooter(),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      width: Get.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryCircleButton(
            icon: Icon(Icons.arrow_back, color: AppColors.primary),
            size: 30,
            onPressed: () {
              Get.back();
              appAnalitics.logEvent('first_skip_pay');
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: Get.width * 0.62,
              child: Text(
                'purchase_page_title'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: Get.height * 0.025),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDesc() {
    var monthProd = billingService.monthlyTarif?.product;
    var annualProd = billingService.yearTarif?.product;
    List<Widget> tarifs = [
      tarif('tarif_month_title'.trParams({'days': tryalDays.toString()}),
          'tarif_month_desc'.trParams({'price': '${monthProd?.priceString}'})),
      tarif(
          'tarif_annual_title'
              .trParams({'price': '${annualProd?.priceString}'}),
          'tarif_annual_desc'
              .trParams({'price': '${annualProd?.priceString}'})),
    ];
    return Column(
      children: [
        Container(
          width: Get.width,
          height: Get.height * 0.2,
          child: PageView(
            controller: _pageController,
            children: tarifs,
          ),
        ),
        const SizedBox(height: 5),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              tarifs.length,
              (index) {
                bool isActive = index == _page.value;
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: CircleAvatar(
                    radius: isActive ? 5 : 4,
                    backgroundColor:
                        isActive ? AppColors.primary : Colors.black26,
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget tarif(String title, String desc) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.purchaseDesc.withOpacity(0.64),
          borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: Get.height * 0.023,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              desc,
              style: TextStyle(color: Colors.white, fontSize: Get.width * .033),
            ),
          )
        ],
      ),
    );
  }

  Widget btnBuy() {
    return PrimaryButton(
      text: billingService.isPro() ? 'change_tarif'.tr : 'continue'.tr,
      pWidth: 0.5,
      onPressed: () async {
        Package _package;
        try {
          switch (_page.value) {
            case 0:
              _package = billingService.monthlyTarif;
              break;
            case 1:
              _package = billingService.yearTarif;
              break;
            default:
          }
          await billingService.purchase(_package);
          appAnalitics.logEvent('first_trial');
          //TODO: статистика будет кривой.
          // Это нужно переделать, цена и валюта всегда разная может быть
          await AnalyticService.analytics
              .logEcommercePurchase(value: 75, currency: 'RUB');
        } catch (e) {
          print("Payment error: $e");
        }
      },
    );
  }

  Widget restoreBtn() {
    return CupertinoButton(
      child: Text(
        'restore'.tr,
        style: TextStyle(
            color: AppColors.primary, decoration: TextDecoration.underline),
      ),
      onPressed: () async {
        billingService.restore();
        appAnalitics.logEvent('restore_click');
      },
    );
  }

  Column buildFooter() {
    return Column(
      children: [
        new RichText(
            text: myUrl('privacy_title'.tr, UrlPrivacy,
                textColor: Colors.white, underline: false)),
        const SizedBox(height: 5),
        new RichText(
            text: myUrl('agreement_title'.tr, UrlAgreement,
                textColor: Colors.white, underline: false)),
      ],
    );
  }
}
