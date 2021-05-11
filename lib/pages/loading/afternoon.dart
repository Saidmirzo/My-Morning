import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';

import 'components/name.dart';

class AfternoonPage extends StatefulWidget {
  final Function onDone;

  const AfternoonPage({Key key, @required this.onDone}) : super(key: key);

  @override
  _AfternoonPageState createState() => _AfternoonPageState();
}

class _AfternoonPageState extends State<AfternoonPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  RxDouble animValue = 0.9.obs;
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
    animation = Tween<double>(begin: 0.9, end: 0.6).animate(controller)
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
    print('Build AfternoonPage');
    Future.delayed(const Duration(milliseconds: 500), () {
      controller.forward();
    });
    return Container(
      decoration:
          BoxDecoration(gradient: AppColors.gradient_loading_afternoon_bg),
      child: Stack(
        alignment: Alignment.center,
        children: [
          buildRays(),
          buildSun(),
          buildClouds(),
          buildBg(),
          nameWidget('good_afternoon'),
        ],
      ),
    );
  }

  Widget buildBg() {
    return Positioned(
      child: Container(
        width: Get.width,
        child: Image.asset('assets/images/startscreen/afternoon/houses.png',
            fit: BoxFit.fitWidth),
      ),
      bottom: 0,
    );
  }

  Positioned buildClouds() {
    return Positioned(
      child: Container(
        width: Get.width,
        child: Image.asset(
          'assets/images/startscreen/afternoon/clouds.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildSun() {
    return Obx(() {
      return Align(
        alignment: Alignment(-0.05, animValue.value),
        child: Container(
          width: Get.width * 0.8,
          height: Get.width * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(180),
              gradient: AppColors.gradient_afternoon_sun),
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
