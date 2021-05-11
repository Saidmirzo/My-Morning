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
      PageController(viewportFraction: .9, initialPage: 1);
  int _page = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      _page = _pageController.page.round();
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
                    child: Image.asset('assets/images/purchase/bonuses_ru.png',
                        fit: BoxFit.fitWidth),
                  ),
                  Spacer(),
                  buildDesc(),
                  Spacer(),
                  btnBuy(),
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
              width: Get.width * 0.6,
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
    return Container(
      width: Get.width,
      height: Get.height * 0.2,
      child: PageView(
        controller: _pageController,
        children: [
          tarif(billingService.monthlyTarif),
          tarif(billingService.yearTarif),
        ],
      ),
    );
  }

  Widget tarif(Package _package) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.purchaseDesc.withOpacity(0.64),
          borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$tryalDays дней бесплатно',
            style: TextStyle(
                color: Colors.white,
                fontSize: Get.height * 0.023,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '• ${_package?.product?.price} рублей в месяц после триала\n• Отмена в любое время бесплатно',
              style:
                  TextStyle(color: Colors.white, fontSize: Get.height * 0.017),
            ),
          )
        ],
      ),
    );
  }

  Widget btnBuy() {
    return PrimaryButton(
      text: 'continue'.tr,
      pWidth: 0.5,
      onPressed: () async {
        Package _package;
        try {
          switch (_page) {
            case 0:
              _package = billingService.monthlyTarif;
              break;
            case 1:
              _package = billingService.yearTarif;
              break;
            default:
          }
          await Purchases.purchasePackage(_package);
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
