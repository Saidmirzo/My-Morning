import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../resources/colors.dart';
import '../storage.dart';
import '../widgets/animatedButton.dart';
import '../widgets/is_pro_widget.dart';

class UpsellPage extends StatefulWidget {
  UpsellPage({Key key}) : super(key: key);

  @override
  UpsellPageState createState() => UpsellPageState();
}

class UpsellPageState extends State<UpsellPage> {
  @override
  Widget build(BuildContext context) {
    var isInterviewed =
        MyDB().getBox().get(MyResource.IS_DONE_INTERVIEW, defaultValue: false);
    var tryalDays = isInterviewed ? 14 : 3;
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
                    if (billingService.purchaserInfo == null)
                      return Container();
                    if (billingService.isPro()) return IsProWidget();
                    billingService.purchaserInfo =
                        await Purchases.purchasePackage(
                            billingService.getMonthlyTarif());
                  },
                  'buy_days'.trParams({'days': '$tryalDays'}),
                  22,
                  null,
                  null,
                ),
              ),
              Container(
                height: 100,
                child: AnimatedButton(
                    () => AppRouting.navigateToHomeWithClearHistory(),
                    'menu'.tr,
                    22,
                    null,
                    null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
