import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';
import 'components/name.dart';

class MorningPage extends StatefulWidget {
  final Function onDone;

  const MorningPage({Key key, @required this.onDone}) : super(key: key);

  @override
  _MorningPageState createState() => _MorningPageState();
}

class _MorningPageState extends State<MorningPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  RxDouble animValue = .6.obs;
  RxBool showRays = false.obs;

  void initController() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        showRays.value = true;
        widget.onDone();
      }
    });
    animation = Tween<double>(begin: .6, end: 0.4).animate(controller)
      ..addListener(() {
        animValue.value = animation.value;
      });
  }

  @override
  void initState() {
    initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Build MorningPage');
    Future.delayed(const Duration(milliseconds: 500), () {
      controller.forward();
    });
    return Container(
      decoration:
          const BoxDecoration(gradient: AppColors.gradientLoadingMorningBg),
      child: Stack(
        alignment: Alignment.center,
        children: [
          buildRays(),
          buildSun(),
          buildClouds1(),
          buildClouds2(),
          buildClouds3(),
          buildBg(),
          buildDeer(),
          nameWidget('good_morning'),
        ],
      ),
    );
  }

  Positioned buildDeer() {
    return Positioned(
      child: Image.asset(
        'assets/images/startscreen/morning/deer.png',
        width: Get.width * 0.2,
      ),
      bottom: 20,
    );
  }

  Positioned buildBg() {
    return Positioned(
      child: Image.asset('assets/images/startscreen/morning/bg.png',
          fit: BoxFit.fitWidth),
      bottom: 0,
    );
  }

  Positioned buildClouds3() {
    return Positioned(
      child: Image.asset('assets/images/startscreen/morning/clouds3.png',
          fit: BoxFit.cover, width: Get.width),
    );
  }

  Positioned buildClouds2() {
    return Positioned(
      child: Image.asset(
        'assets/images/startscreen/morning/clouds2.png',
        width: Get.width,
      ),
      top: Get.height * 0.1,
    );
  }

  Positioned buildClouds1() {
    return Positioned(
      child: Image.asset('assets/images/startscreen/morning/clouds1.png',
          width: Get.width * 0.25),
      right: 0,
      top: Get.height * 0.2,
    );
  }

  Widget buildSun() {
    return Obx(() {
      return Align(
        alignment: Alignment(-0.05, animValue.value),
        child: Container(
          width: Get.width * 0.7,
          height: Get.width * 0.7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(180),
              gradient: AppColors.gradientMorningSun),
        ),
      );
    });
  }

  Positioned buildRays() {
    return Positioned(
      child: Obx(
        () => Visibility(
          visible: showRays.value,
          child: Image.asset('assets/images/startscreen/morning/rays.png'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
