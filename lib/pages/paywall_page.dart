import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/services/analitics/all.dart';
import '../resources/colors.dart';
import '../services/ab_testing_service.dart';
import 'progress/progress_page.dart';

class PaywallPage extends StatefulWidget {

  const PaywallPage({Key key}) : super(key: key);

  @override
  _PaywallPageState createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/background_paywall.png'))),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 35,
                    ),
                    onTap: () {
                      return AppRouting.navigateToHomeWithClearHistory();
                    },
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      'well_done'.tr,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'well_done_desc'.tr,
                      style: const TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Image(image: AssetImage('assets/images/paywollnew.png')),
              const SizedBox(height: 36),

              _buildPaywallButton(
                  widget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Try PREMIUM'.tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '3 days free'.tr,
                        style: const TextStyle(
                            color: Color(0xffEBA2C8),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  actionCallback: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ABTestingService.getPaywall()));
                    // appAnalitics.logEvent('first_polnyi_complex');
                  },
                  bgColor: AppColors.VIOLET,
                  color: Colors.white),
              const SizedBox(height: 15),
              // Text(
              //   'days_free'.trParams({
              //     'days': (MyDB().getBox().get(MyResource.IS_DONE_INTERVIEW,
              //                 defaultValue: false)
              //             ? 14
              //             : 3)
              //         .toString()
              //   }),
              //   style: const TextStyle(color: AppColors.VIOLET),
              // ),
              const SizedBox(height: 15),
              _buildPaywallButton(
                widget: Text(
                  'my_progress'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColors.VIOLET,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                actionCallback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProgressPage()));
                  appAnalitics.logEvent('first_reklama');
                  // admobService.showInterstitial();
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaywallButton({
    @required Widget widget,
    @required VoidCallback actionCallback,
    Color bgColor = Colors.white,
    Color color = AppColors.VIOLET,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 3 / 4,
      child: TextButton(
        onPressed: actionCallback,
        style: TextButton.styleFrom(
          primary: AppColors.PINK,
          backgroundColor: bgColor,
          // onSurface: Colors.red,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(27))),
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: widget,
        // child: Text(
        //   title,
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //       color: color, fontSize: 14, fontWeight: FontWeight.bold),
        // ),
      ),
    );
  }
}
