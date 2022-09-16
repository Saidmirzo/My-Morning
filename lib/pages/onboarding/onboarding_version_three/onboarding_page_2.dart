import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/pages/onboarding/components/continue_button.dart';
import 'package:morningmagic/pages/onboarding/onboarding_version_three/onboarding_page_3.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/utils/navigation_animation.dart';
import 'package:get/get.dart';

class OnboardingVersionThirdPageTwo extends StatefulWidget {
  const OnboardingVersionThirdPageTwo({Key key}) : super(key: key);

  @override
  State<OnboardingVersionThirdPageTwo> createState() =>
      _OnboardingVersionThirdPageTwoState();
}

class _OnboardingVersionThirdPageTwoState
    extends State<OnboardingVersionThirdPageTwo> {
  final FixedExtentScrollController hoursController =
      FixedExtentScrollController(initialItem: 8);

  final FixedExtentScrollController minutesController =
      FixedExtentScrollController(initialItem: 10);
  void initState() {
    super.initState();
    AppMetrica.reportEvent('onbording_2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MyImages.onboardingV3page2_3Bg),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                ),
                text: 'onb_3_2_title_1'.tr,
                children: [
                  TextSpan(
                    text: 'onb_3_2_title_2'.tr,
                    style: const TextStyle(
                      color: Color(0xff6b0495),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  const ClipBack(),
                  ClipContent(
                    hoursController: hoursController,
                    minutesController: minutesController,
                  ),
                ],
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class ClipContent extends StatelessWidget {
  const ClipContent({
    Key key,
    @required this.hoursController,
    @required this.minutesController,
  }) : super(key: key);

  final FixedExtentScrollController hoursController;
  final FixedExtentScrollController minutesController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          SizedBox(
            height: 150,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 35,
                        color: Colors.white.withOpacity(.11),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyPickerWidget(
                      itemsCount: 24,
                      controller: hoursController,
                    ),
                    const SizedBox(
                      width: 45,
                    ),
                    MyPickerWidget(
                      itemsCount: 60,
                      controller: minutesController,
                    ),
                  ],
                )
              ],
            ),
          ),
          const Spacer(),
          ContinueButton(
            callback: () {
              Navigator.of(context).push(
                createRoute(
                  const OnboardingVersionThirdPageThird(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ClipBack extends StatelessWidget {
  const ClipBack({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: RotatedBox(
        quarterTurns: 2,
        child: ClipPath(
          clipper: MyClipper(),
          child: Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: Color(0xffB080D2),
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();
    path.lineTo(0, h);
    path.quadraticBezierTo(w * 0.5, h - 50, w, h);
    path.lineTo(w, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw false;
  }
}

class MyPickerWidget extends StatelessWidget {
  const MyPickerWidget({Key key, this.itemsCount, this.controller})
      : super(key: key);
  final int itemsCount;
  final FixedExtentScrollController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      height: double.maxFinite,
      child: CupertinoPicker(
        selectionOverlay: const SizedBox(),
        onSelectedItemChanged: (int i) {},
        scrollController: controller,
        diameterRatio: 25,
        itemExtent: 40,
        children: List.generate(
          itemsCount,
          (index) => Center(
            child: Text(
              index.toString().padLeft(2, '0'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22.21,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
