import 'dart:io';

import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:adapty_flutter/models/adapty_paywall.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/components/dialog_component.dart';
import 'package:morningmagic/dialog/connection_dialog.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/pages/paywall/components/bottom_text_buttons.dart';
import 'package:morningmagic/pages/paywall/components/close_button.dart';
import 'package:morningmagic/pages/paywall/components/features_block.dart';
import 'package:morningmagic/pages/paywall/components/products_block.dart';
import 'package:morningmagic/pages/paywall/components/start_button.dart';
import 'package:morningmagic/pages/paywall/components/title_subtitle.dart';
import 'package:morningmagic/pages/paywall/paywall_provider.dart';
import 'package:morningmagic/pages/settings/settingsPage.dart';
import 'package:morningmagic/pages/welcome/welcome_page.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/services/connection_service/connection_service.dart';
import 'package:morningmagic/services/notifications.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../services/ab_testing_service.dart';

class NewPaywall extends StatefulWidget {
  final bool isSettings;

  const NewPaywall({
    Key key,
    this.isSettings = false,
  }) : super(key: key);

  @override
  State<NewPaywall> createState() => _NewPaywallState();
}

class _NewPaywallState extends State<NewPaywall> {
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
    PayWallProvider prov = context.watch<PayWallProvider>();
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MyImages.newPaywallBg),
            fit: BoxFit.fill,
          ),
        ),
        child: FutureBuilder<AdaptyPaywall>(
            future: ABTestingService.getTest("My_Morning_Paywall_ID"),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              }
              Adapty.logShowPaywall(paywall: snapshot.data);
              return Stack(
                children: [
                  SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: Column(
                      children: [
                        const Spacer(
                          flex: 3,
                        ),
                        TitleSubtitlePaywall(),
                        const Spacer(
                          flex: 2,
                        ),
                        FeaturesBlockPaywall(),
                        const Spacer(
                          flex: 2,
                        ),
                        ProductsBlockPaywall(
                          productsList: [
                            {
                              "name": "Monthly".tr,
                              "description":
                                  "${snapshot.data.products[0].currencySymbol}${snapshot.data.products[0].price}${'/month,\ncancel anytime'.tr}",
                              "img": MyImages.newPaywallOffer1Img,
                            },
                            {
                              "name": "Annually".tr,
                              "description":
                                  "${snapshot.data.products[1].currencySymbol}${snapshot.data.products[1].price}${'/year,\ncancel anytime'.tr}",
                              "img": MyImages.newPaywallOffer2Img,
                              "isPopular": true,
                            },
                            {
                              "name": "Lifetime".tr,
                              "description":
                                  "${snapshot.data.products[2].currencySymbol}${snapshot.data.products[2].price}${', one-\ntime payment'.tr}",
                              "img": MyImages.newPaywallOffer3Img,
                            },
                          ],
                        ),
                        const Spacer(),
                        StartButtonPaywall(
                          onClick: () async {
                            if (await ConnectionRepo.isConnected()) {
                              try {
                                DialogComponent().loading();
                                AppMetrica.reportEvent('paywall_inapp_close');
                                await billingService.purchase(snapshot.data.products[prov.openedProductIndex]);
                                appAnalitics.logEvent('first_trial');
                                AnalyticService.analytics.logEcommercePurchase(
                                    value: snapshot.data.products[prov.openedProductIndex].price,
                                    currency: snapshot.data.products[prov.openedProductIndex].currencyCode);
                                billingService.init();
                                Navigator.popUntil(context, (route) => route.isFirst);
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
                        const Spacer(),
                        TextButtonsPayWall(
                          restore: () async {
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
                        const Spacer(),
                      ],
                    ),
                  ),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CloseButtonPaywall(
                        onClick: () async {
                          Navigator.popUntil(context, (route) => route.isFirst);
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
                            Get.to(() => const MainMenuPage());
                          }
                        },
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
