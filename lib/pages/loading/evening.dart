import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';

import 'components/name.dart';

class EveningPage extends StatefulWidget {
  final Function onDone;

  const EveningPage({Key key, @required this.onDone}) : super(key: key);

  @override
  _EveningPageState createState() => _EveningPageState();
}

class _EveningPageState extends State<EveningPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  RxDouble animValue = .9.obs;

  void initController() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onDone();
      }
    });
    animation = Tween<double>(begin: .9, end: 1.2).animate(controller)
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
    print('Build EveningPage');
    Future.delayed(const Duration(milliseconds: 500), () {
      controller.forward();
    });
    return Container(
      decoration:
          BoxDecoration(gradient: AppColors.gradient_loading_evening_bg),
      child: Stack(
        alignment: Alignment.center,
        children: [
          buildClouds2(),
          buildSun(),
          buildClouds(),
          buildBg(),
          nameWidget('good_evening'),
        ],
      ),
    );
  }

  Widget buildBg() {
    return Positioned(
      child: Container(
        width: Get.width,
        child: Image.asset('assets/images/startscreen/evening/trees.png',
            fit: BoxFit.fitWidth),
      ),
      bottom: 0,
    );
  }

  Positioned buildClouds() {
    return Positioned(
      top: Get.height * 0.2,
      child: Container(
        width: Get.width,
        child: Image.asset(
          'assets/images/startscreen/evening/clouds.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Positioned buildClouds2() {
    return Positioned(
      child: Container(
        width: Get.width,
        child: Image.asset(
          'assets/images/startscreen/evening/clouds2.png',
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
              gradient: AppColors.gradient_evening_sun),
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
