import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/storage.dart';
import '../resources/colors.dart';

class PaymentDialog extends Dialog {
  const PaymentDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInterviewed = MyDB().getBox().get(MyResource.IS_DONE_INTERVIEW, defaultValue: false);
    var tryalDays = isInterviewed ? 14 : 7;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 18),
              child: Center(
                child: Text(
                  'appreciate'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: AppColors.violet),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Center(
                    child: Text(
                      'price'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: AppColors.violet,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "10\$",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: AppColors.pink, decoration: TextDecoration.lineThrough),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: const Text(
                          "1\$",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: AppColors.violet),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildBuyButton(
                    title: 'buy_month'.tr,
                    onTap: () {
                      _startPaymentSubscription(context);
                      appAnalitics.logEvent('first_popap_pay');
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildBuyButton(
                    title: 'buy_days'.trParams({'days': '$tryalDays'}),
                    onTap: () {
                      _startPaymentTrial(context);
                      appAnalitics.logEvent('first_popap_trial');
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildBuyButton({@required title, @required VoidCallback onTap}) {
    return Container(
        decoration: const BoxDecoration(color: AppColors.pink, borderRadius: BorderRadius.all(Radius.circular(30))),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StyledText(
              title,
              fontSize: 18,
              color: AppColors.white,
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }

  _startPaymentSubscription(BuildContext context) {
    Get.back();
    billingService.startPaymentPage();
  }

  _startPaymentTrial(BuildContext context) {
    Get.back();
    billingService.startPaymentPage();
  }
}

// class UpsellScreen extends StatelessWidget {
//   final Offerings offerings;

//   UpsellScreen({Key key, @required this.offerings}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (offerings != null) {
//       final offering = offerings.current;
//       if (offering != null) {
//         final monthly = offering.monthly;
//         if (monthly != null) {
//           return Container(
//             child: Center(
//               child: Subscribe1MonthButton(),
//             ),
//           );
//         }
//       }
//     }
//     return Container(width: 0, height: 0);
//   }
// }
