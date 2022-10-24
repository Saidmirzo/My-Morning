import 'dart:async';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:adapty_flutter/models/adapty_paywall.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/paywall/components/action_button.dart';
import 'package:morningmagic/pages/paywall/components/bottom_buttons.dart';
import 'package:morningmagic/pages/paywall/components/counter_item.dart';
import 'package:morningmagic/pages/paywall/components/safety_shield.dart';
import 'package:morningmagic/services/analitics/all.dart';
import '../../../components/dialog_component.dart';
import '../../../dialog/connection_dialog.dart';
import '../../../resources/colors.dart';
import '../../../resources/svg_assets.dart';
import '../../../services/ab_testing_service.dart';
import '../../../services/analitics/analyticService.dart';
import '../../../services/connection_service/connection_service.dart';
import '../../../services/notifications.dart';
import '../../../storage.dart';
import '../../../utils/shared_preferences.dart';
import '../../menu/main_menu.dart';

class PaywallV2OneTimeOffer extends StatefulWidget {

  final startDt = DateTime.now();
  final stopDt = DateTime.now().add(const Duration(minutes: 5));

  PaywallV2OneTimeOffer({Key key}) : super(key: key);

  @override
  _PaywallV2OneTimeOfferState createState() => _PaywallV2OneTimeOfferState();
}

class _PaywallV2OneTimeOfferState extends State<PaywallV2OneTimeOffer> {

  final textStyle = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 36,
    color: Colors.white,
    fontFamily: 'Montserrat',
  );
  final Rx<Duration> dt = const Duration(minutes: 4, seconds: 49).obs;
  Timer _timer; // Таймер

  // Запускает таймер
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      final _dt = widget.stopDt.difference(DateTime.now());
      if (_dt <= Duration.zero) {
        // Останавливаем таймер
        setState(() {
          timer.cancel();
        });
        // Переходим на главную
        Get.offAll(() => const MainMenuPage());
      }
      else {
        // Обновляем время на экране
        dt.value = _dt;
      }
    });
  }

  @override
  void initState() {
    // Запускаем таймер
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // Останавливаем таймер
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: SafeArea(child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              height: 784,
              width: 312,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // Верхняя фиксированная часть
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        // Закрыть
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            child: Container(
                              margin: const EdgeInsets.only(right: 27, top: 20),
                              child: Image.asset(
                                MyImages.newPaywallCloseIcon,
                                width: 10.33,
                                height: 10.33,
                              ),
                            ),
                            onTap: () => Get.to(() => const MainMenuPage()),
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Попробуйте premium
                        Container(
                          // padding: const EdgeInsets.fromLTRB(33, 0, 33, 4),
                          height: 40,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('Try premium'.tr.toUpperCase()
                                .replaceAll('\n', '').toUpperCase(),
                              textAlign: TextAlign.center,
                              style: textStyle,
                            ),
                          ),
                        ),
                        // Бесплатно!
                        Container(
                          // padding: const EdgeInsets.fromLTRB(33, 0, 33, 0),
                          height: 40,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('Free!'.tr.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: textStyle.copyWith(
                                color: const Color(0xFF661B85),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Полоса с текстом
                    Container(
                      margin: const EdgeInsets.only(top: 8.15),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 61,
                      // width: double.maxFinite,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.VIOLET_ONB,
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 40,
                          // width: double.maxFinite,
                          child: Text('Limited Offer'.tr.capitalize,
                            textAlign: TextAlign.center,
                            style: textStyle.copyWith(fontSize: 32),
                          ),
                        ),
                      ),
                    ),

                    // Счётчик
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Obx(() {
                        String m = (dt.value.inMinutes).toString();
                        String s = (dt.value.inSeconds % 60).toString();
                        if (m.length < 2) {
                          m = '0$m';
                        }
                        if (s.length < 2) {
                          s = '0$s';
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CounterItem(num: m.characters.first),
                            const SizedBox(width: 6),
                            CounterItem(num: m.characters.last),
                            const SizedBox(width: 2),
                            Text(':',
                              style: textStyle.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 2),
                            CounterItem(
                              num: s.characters.first,
                              color: AppColors.VIOLET_ONB,
                            ),
                            const SizedBox(width: 6),
                            CounterItem(
                              num: s.characters.last,
                              color: AppColors.VIOLET_ONB,
                            ),
                          ],
                        );
                      }),
                    ),

                    // Тариф
                    SizedBox(
                          height: 261,
                          width: 320,
                          child: FutureBuilder<AdaptyPaywall>(
                            future: ABTestingService.getTest("paywalls_1"),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                // print(snapshot);
                                return const SizedBox();
                              }

                              // for (var itm in snapshot.data.products) {
                              //   print(itm);
                              // }

                              Adapty.logShowPaywall(paywall: snapshot.data);

                              final product = snapshot.data.products
                                  .firstWhere((e) => e.vendorProductId == 'subscription_yearly');

                              // Тариф
                              return Container(
                                // margin: const EdgeInsets.fromLTRB(33, 0, 33, 0),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15.84,
                                ),
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(19),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // 3 days free
                                    SizedBox(
                                      height: 35,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('3 days'.tr,
                                              style: textStyle.copyWith(
                                                color: Colors.black,
                                                fontSize: 29,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(' ' + 'Free'.tr,
                                              style: textStyle.copyWith(
                                                color: AppColors.VIOLET_ONB,
                                                fontSize: 29,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // After
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 7.2),
                                      height: 24,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text('After'.tr,
                                          style: textStyle.copyWith(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Сумма
                                    SizedBox(
                                      height: 24,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("${(100 * product.price / 12).round() / 100} ${product.currencyCode}",
                                              style: textStyle.copyWith(
                                                color: AppColors.VIOLET_ONB,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(' / ' + 'month'.tr,
                                              style: textStyle.copyWith(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5.35),
                                    // Период
                                    SizedBox(
                                      height: 18,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text("Payment every 12 months".tr,
                                          style: textStyle.copyWith(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 21.37),
                                    // Серый блок
                                    const SafetyShield(),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                    const Expanded(child: SizedBox()),

                    // Нижняя фиксированная часть
                    Column(
                        children: [
                          // Кнопка "Попробуйте 3 дня бесплатно!"
                          FutureBuilder<AdaptyPaywall>(
                            future: ABTestingService.getTest("paywalls_1"),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const SizedBox();
                              }
                              // Находим годовой тариф
                              final product = snapshot.data.products
                                  .firstWhere((e) => e.vendorProductId == 'subscription_yearly');
                              return ActionButton(
                                title: 'Try 3 days for free!'.tr,
                                onTap: () async {
                                  if (await ConnectionRepo.isConnected()) {
                                    try {
                                      DialogComponent().loading();
                                      AppMetrica.reportEvent('paywall_inapp_close');
                                      await billingService.purchase(product);
                                      appAnalitics.logEvent('first_trial');
                                      AnalyticService.analytics.logEcommercePurchase(
                                          value: product.price,
                                          currency: product.currencyCode);
                                      billingService.init();
                                      Get.back();

                                      if (await CustomSharedPreferences()
                                          .isOpenSale() ||
                                          await CustomSharedPreferences()
                                              .isFirstOpen()) {
                                        AppMetrica.reportEvent('subscription_trial');
                                        // Get.to(() => const WelcomePage());
                                        pushNotifications = PushNotifications();
                                        WidgetsBinding.instance.addPostFrameCallback(
                                              (timeStamp) async {
                                            if (GetPlatform.isIOS) {
                                              AppTrackingTransparency
                                                  .requestTrackingAuthorization();
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
                                  }
                                  else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const ConnectionDialog();
                                      },
                                    );
                                  }
                                },
                              );
                            },
                          ),
                          // const Spacer(),
                          const SizedBox(height: 24),
                          const BottomButtons(),
                          // const Spacer(),
                        ],
                      ),

                  ],
                ),
              ),
            ),
          )),
      ),
    );
  }
}
