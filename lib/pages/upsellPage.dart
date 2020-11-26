import 'package:flutter/material.dart';
import 'package:morningmagic/widgets/subscribe_1_month_button.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'package:easy_localization/easy_localization.dart';
import '../resources/colors.dart';
import '../storage.dart';
import '../widgets/animatedButton.dart';
import '../widgets/is_pro_widget.dart';
import 'menuPage.dart';

class UpsellPage extends StatefulWidget {
  UpsellPage({Key key}) : super(key: key);

  @override
  UpsellPageState createState() => UpsellPageState();
}

class UpsellPageState extends State<UpsellPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.TOP_GRADIENT,
            AppColors.MIDDLE_GRADIENT,
            AppColors.BOTTOM_GRADIENT
          ],
        )),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: AnimatedButton(
                  () async {
                    if (billingService.purchaserInfo == null) return Container();
                    if (billingService.isPro()) return IsProWidget();
                    billingService.purchaserInfo = await Purchases.purchasePackage(billingService.getMonthlyTarif());
                  },
                  'rex',
                  'buy_days'.tr(),
                  22,
                  null,
                  null,
                ),
              ),
              Container(
                height: 100,
                child: AnimatedButton(
                  () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StartScreen())),
                  'rex', 'menu'.tr(), 22, null, null
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}