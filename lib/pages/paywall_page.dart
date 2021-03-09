import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/pages/askedQuestionsScreen.dart';
import 'package:morningmagic/pages/payment.dart';
import 'package:morningmagic/services/admob.dart';

import '../resources/colors.dart';

class PaywallPage extends StatefulWidget {
  @override
  _PaywallPageState createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/background_paywall.png'))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/paywall_logo.png')),
            SizedBox(height: 36),
            _buildPaywallButton(
                title: 'buy_free'.tr,
                actionCallback: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PaymentPage()));
                }),
            SizedBox(
              height: 4,
            ),
            Text(
              'three_days'.tr,
              style: TextStyle(color: const Color(0x594A1D72)),
            ),
            SizedBox(height: 16),
            _buildPaywallButton(
                title: 'my_progress'.tr,
                actionCallback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AskedQuestionsScreen()));
                  admobService.showInterstitial();
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildPaywallButton(
      {@required String title, @required VoidCallback actionCallback}) {
    return Container(
      width: MediaQuery.of(context).size.width * 3 / 4,
      child: TextButton(
        onPressed: actionCallback,
        style: TextButton.styleFrom(
          primary: AppColors.PINK,
          backgroundColor: Colors.white,
          // onSurface: Colors.red,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(27))),
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.VIOLET,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
