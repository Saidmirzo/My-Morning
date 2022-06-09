import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:adapty_flutter/models/adapty_paywall.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:morningmagic/components/dialog_component.dart';
import 'package:morningmagic/pages/welcome/welcome_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/my_const.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/services/notifications.dart';
import 'package:morningmagic/utils/shared_preferences.dart';
import 'package:morningmagic/widgets/my_url.dart';

import '../../storage.dart';

class PaymentSalePage extends StatefulWidget {
  @override
  State<PaymentSalePage> createState() => _PaymentSalePageState();
}

class _PaymentSalePageState extends State<PaymentSalePage> {
  int _minute = 1;
  int _seconds = 59;
  @override
  void initState() {
    startTimer();
    super.initState();
    CustomSharedPreferences().isFirstOpen().then((value) {
      if (value) {
        AppMetrica.reportEvent('paywall_discount_open');
      } else {
        AppMetrica.reportEvent('paywall_inapp_discount_open');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            child: SvgPicture.asset("assets/images/paywall/paywall_bg.svg", fit: BoxFit.cover),
            width: double.infinity,
            height: double.infinity,
          ),
          FutureBuilder(
            future: billingService.getPaywall("discount_month"),
            builder: (context, AsyncSnapshot<AdaptyPaywall> snapshot) {
              if (snapshot.hasError) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snapshot.error)));
              if (!snapshot.hasData || snapshot.hasError) return SizedBox.shrink();
              List products = snapshot.data.customPayload['products'];
              return ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  Navigator.popUntil(context, (route) => route.isFirst);
                                  if (await CustomSharedPreferences().isFirstOpen()) {
                                    AppMetrica.reportEvent('paywall_discount_close');
                                    Get.to(WelcomePage());
                                    pushNotifications = PushNotifications();
                                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                                      if (GetPlatform.isIOS) {
                                        AppMetrica.reportEvent('idfa_notification_show');
                                        var result = await AppTrackingTransparency.requestTrackingAuthorization();
                                        if (result == TrackingStatus.authorized) {
                                          AppMetrica.reportEvent('idfa_notification_endabled');
                                        }
                                      }
                                    });
                                  } else {
                                    AppMetrica.reportEvent('paywall_inapp_discount_close');
                                  }
                                },
                                icon: Icon(Icons.close),
                                constraints: BoxConstraints(),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            snapshot.data.customPayload['title'][Get.locale.languageCode == "ru" ? "ru" : "en"].toString(),
                            style: TextStyle(fontSize: Platform.isIOS ? 25 : 22, color: Colors.white, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            snapshot.data.customPayload['body'][Get.locale.languageCode == "ru" ? "ru" : "en"].toString(),
                            style: TextStyle(fontSize: Platform.isIOS ? 17 : 15, color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Chip(
                                avatar: Icon(Icons.access_time, color: Colors.white),
                                label: Text(
                                  "$_minute:$_seconds",
                                  style: TextStyle(fontSize: Platform.isIOS ? 22 : 20, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                backgroundColor: HexColor("#6B0496"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              for (var i = 0; i < products.length; i++) ...[
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: HexColor("#8400FF"), width: 4),
                                    boxShadow: [
                                      BoxShadow(
                                        color: HexColor("#592F72").withOpacity(0.4),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: Offset(0, 0),
                                      )
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: Platform.isIOS ? 25 : 20, horizontal: 15),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                products[i]['title'][Get.locale.languageCode == "ru" ? "ru" : "en"]
                                                    .toString()
                                                    .replaceAll("@price", "${snapshot.data.products[i].price} ${snapshot.data.products[i].currencySymbol}"),
                                                style: TextStyle(fontSize: Platform.isIOS ? 18 : 17, fontWeight: FontWeight.bold, color: AppColors.VIOLET)),
                                            Text(
                                                products[i]['body'][Get.locale.languageCode == "ru" ? "ru" : "en"]
                                                    .toString()
                                                    .replaceAll("@price_month", "${(snapshot.data.products[i].price / 12).toStringAsFixed(2)} ${snapshot.data.products[i].currencySymbol}")
                                                    .replaceAll("@price", "${snapshot.data.products[i].price} ${snapshot.data.products[i].currencySymbol}"),
                                                style: TextStyle(fontSize: Platform.isIOS ? 15 : 14, color: AppColors.VIOLET)),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: HexColor("#FF7791"),
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(15)),
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                                          child: Text(
                                            "profitable".tr,
                                            style: TextStyle(color: Colors.white, fontSize: Platform.isIOS ? 14 : 13),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              new RichText(text: myUrl('privacy_title'.tr, UrlPrivacy, textColor: AppColors.VIOLET, underline: false)),
                              // const SizedBox(height: 5),
                              new RichText(text: myUrl('agreement_title'.tr, UrlAgreement, textColor: AppColors.VIOLET, underline: false)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 6,
                                  blurRadius: 60,
                                  offset: Offset(0, 0),
                                )
                              ],
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.VIOLET_ONB,
                                minimumSize: Size(double.infinity, Platform.isIOS ? 70 : 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () async {
                                try {
                                  DialogComponent().loading();
                                  AppMetrica.reportEvent('paywall_inapp_discount_open');
                                  await billingService.purchase(snapshot.data.products.first);
                                  appAnalitics.logEvent('first_trial');
                                  AnalyticService.analytics.logEcommercePurchase(value: snapshot.data.products.first.price, currency: snapshot.data.products.first.currencyCode);
                                  billingService.init();
                                  Get.back();
                                  if (await CustomSharedPreferences().isFirstOpen()) {
                                    AppMetrica.reportEvent('subscription_discount_trial');
                                    Get.to(WelcomePage());
                                    pushNotifications = PushNotifications();
                                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                                      if (GetPlatform.isIOS) {
                                        AppTrackingTransparency.requestTrackingAuthorization();
                                      }
                                    });
                                  } else {
                                    AppMetrica.reportEvent('subscription_inapp_discount_trial');
                                  }
                                } catch (e) {
                                  AppMetrica.reportEvent('paywall_inapp_discount_close');
                                  Navigator.pop(context);
                                  print(e);
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 25),
                                  const Spacer(),
                                  Text(
                                    billingService.isPro() ? 'change_tarif'.tr : 'continue'.tr,
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Icon(Icons.arrow_forward, size: 25),
                                ],
                              ),
                            ),
                          ),
                          CupertinoButton(
                            child: Text(
                              'restore'.tr,
                              style: TextStyle(color: AppColors.primary, decoration: TextDecoration.underline),
                            ),
                            onPressed: billingService.restore,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds == 0) {
          _minute--;
          _seconds = 60;
        } else {
          _seconds--;
        }
      });
      if (_minute == 0 && _seconds == 0) {
        timer.cancel();
        Get.back();
      }
    });
  }
}
