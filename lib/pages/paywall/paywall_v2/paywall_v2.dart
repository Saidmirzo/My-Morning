import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:adapty_flutter/models/adapty_paywall.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/components/app_loading.dart';
import 'package:morningmagic/components/dialog_component.dart';
import 'package:morningmagic/dialog/connection_dialog.dart';
import 'package:morningmagic/pages/paywall/components/action_button.dart';
import 'package:morningmagic/pages/settings/settingsPage.dart';
import 'package:morningmagic/pages/welcome/welcome_page.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/connection_service/connection_service.dart';
import 'package:morningmagic/services/notifications.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/utils/shared_preferences.dart';

import '../../../services/ab_testing_service.dart';
import '../components/bottom_buttons.dart';
import '../components/feature_item.dart';
import '../components/products.dart';
import 'paywall_v2_oto.dart';

class PaywallV2 extends StatefulWidget {
  final bool isSettings;
  final bool onBack;

  const PaywallV2({
    Key key,
    this.isSettings = false,
    this.onBack = false,
  }) : super(key: key);

  @override
  State<PaywallV2> createState() => _PaywallV2State();
}

class _PaywallV2State extends State<PaywallV2> {
  @override
  void initState() {
    AppMetrica.reportEvent('paywall_open');
    CustomSharedPreferences().isFirstOpen().then((value) {
      if (value) {
        AppMetrica.reportEvent('paywall_open');
      } else {
        AppMetrica.reportEvent('paywall_inapp_open');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(MyImages.newPaywallBg),
          fit: BoxFit.cover,
        ),
      ),
      child: FutureBuilder<AdaptyPaywall>(
          future: ABTestingService.getTest('paywalls_1'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              print('Loading');
              return const AppLoading();
            }

            Adapty.logShowPaywall(paywall: snapshot.data);

            var product;

            try {
              product = snapshot.data.products.firstWhere((e) => e.vendorProductId == 'subscription_yearly_no_trial');
            } catch (e) {
              product ??= snapshot.data.products.firstWhere((e) => e.vendorProductId == 'subscription_yearly');
            }

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 37.4, right: 37.4, top: 60.1, bottom: MediaQuery.of(context).size.height * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ??????????????
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(8),
                          child: Image.asset(
                            MyImages.newPaywallCloseIcon,
                            width: 10.33,
                            height: 10.33,
                          ),
                        ),
                        onTap: () async {
                          // Navigator.popUntil(context, (route) => route.isFirst);
                          if (widget.onBack) {
                            Get.back();
                          } else {
                            if (await CustomSharedPreferences().isFirstOpen()) {
                              AppMetrica.reportEvent('paywall_discount_close');
                              Get.to(() => const WelcomePage());
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
                            } else if (widget.isSettings) {
                              Get.to(() => const SettingsPage());
                              // AppMetrica.reportEvent('paywall_inapp_discount_close');
                            } else {
                              Get.to(() => PaywallV2OneTimeOffer());
                            }
                          }
                        },
                      ),
                      GestureDetector(
                        child: Text(
                          'Restore'.tr,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat',
                            // height: 14.63,
                          ),
                        ),
                        onTap: () async {
                          if (await ConnectionRepo.isConnected()) {
                            billingService.restore();
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const ConnectionDialog();
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // ???????????????????????????? ?????? ??????????????
                Text(
                  'Unlock all features'.tr.replaceAll('   ', ' ').toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                ),
                // ?????????????????? ????????????????????, ?????????????????? ?????? ??????
                SizedBox(
                  height: 23,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Create your perfect morning".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 39,
                    left: 39,
                    top: 23.5,
                  ),
                  child: Column(
                    children: [
                      // ?????????? 1
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FeatureItem(
                            img: MyImages.onboardingV2page12Icon1,
                            text: "Fitness".tr,
                          ),
                          FeatureItem(
                            img: MyImages.onboardingV2page12Icon2,
                            text: "Visualization".tr,
                          ),
                          FeatureItem(
                            img: MyImages.onboardingV2page12Icon3,
                            text: "Meditations".tr,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // ?????????? 2
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FeatureItem(
                            img: MyImages.onboardingV2page12Icon4,
                            text: "Reading".tr,
                          ),
                          FeatureItem(
                            img: MyImages.onboardingV2page12Icon5,
                            text: "Notes".tr,
                          ),
                          FeatureItem(
                            img: MyImages.onboardingV2page12Icon6,
                            text: "Affirmations".tr,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // ???????????? ????????????
                Products(
                  productsList: [
                    {
                      "name": "Payment every 12 months".tr,
                      "description":
                          "${(100 * product.price / 12).round() / 100} ${product.currencyCode} / ${'month'.tr}",
                    },
                  ],
                ),
                const SizedBox(height: 20),

                // ?????????? ?????????????????????????? ??????????
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Let's go
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 14,
                      ),
                      child: ActionButton(
                        title: 'lets go'.tr,
                        onTap: () async {
                          if (await ConnectionRepo.isConnected()) {
                            try {
                              DialogComponent().loading();
                              AppMetrica.reportEvent('paywall_inapp_close');
                              await billingService.purchase(product);
                              billingService.init();
                              Get.back();
                              appAnalitics.logEvent('first_trial');
                              Get.back();

                              // Navigator.popUntil(
                              //     context, (route) => route.isFirst);
                              if (await CustomSharedPreferences().isOpenSale() ||
                                  await CustomSharedPreferences().isFirstOpen()) {
                                AppMetrica.reportEvent('subscription_trial');
                                Get.to(() => const WelcomePage());
                                pushNotifications = PushNotifications();
                                WidgetsBinding.instance.addPostFrameCallback(
                                  (timeStamp) async {
                                    if (GetPlatform.isIOS) {
                                      AppTrackingTransparency.requestTrackingAuthorization();
                                    }
                                  },
                                );
                              } else {
                                AppMetrica.reportEvent('subscription_inapp_trial');
                              }
                            } catch (e) {
                              Get.back();
                              print(e);
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const ConnectionDialog();
                              },
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    const BottomButtons(),
                  ],
                ),
              ],
            );
          }),
    ));
  }
}
