import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/storage.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../resources/colors.dart';
import '../widgets/subscribe_1_month_button.dart';

class PaymentDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 18),
                child: Center(
                  child: Text(
                    'appreciate'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'rex',
                        fontWeight: FontWeight.normal,
                        color: AppColors.VIOLET),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Center(
                        child: Text(
                          'price'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'rex',
                            fontWeight: FontWeight.normal,
                            color: AppColors.VIOLET,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "10\$",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 21,
                                  fontFamily: 'rex',
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.PINK,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "1\$",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 21,
                                  fontFamily: 'rex',
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.VIOLET),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildBuyButton(
                      title: 'buy_month'.tr(),
                      onTap: () => _startPaymentSubscription(context),
                    ),
                    SizedBox(height: 8),
                    _buildBuyButton(
                      title: 'buy_days'.tr(),
                      onTap: () => _startPaymentTrial(context),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildBuyButton({@required title, @required VoidCallback onTap}) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.PINK,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StyledText(
              title,
              fontSize: 18,
              color: AppColors.WHITE,
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }

  _startPaymentSubscription(BuildContext context) {
    Navigator.pop(context);
    billingService.startPaymentPage(context);
  }

  _startPaymentTrial(BuildContext context) {
    Navigator.pop(context);
    billingService.startPaymentPageTrial(context);
  }
}

class UpsellScreen extends StatelessWidget {
  final Offerings offerings;

  UpsellScreen({Key key, @required this.offerings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (offerings != null) {
      final offering = offerings.current;
      if (offering != null) {
        final monthly = offering.monthly;
        if (monthly != null) {
          return Container(
            child: Center(
              child: Subscribe1MonthButton(),
            ),
          );
        }
      }
    }
    return Container(width: 0, height: 0);
  }
}
