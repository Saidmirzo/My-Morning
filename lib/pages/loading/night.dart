import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';

import 'components/name.dart';

class NightPage extends StatefulWidget {
  final Function onDone;

  const NightPage({Key key, @required this.onDone}) : super(key: key);

  @override
  _NightPageState createState() => _NightPageState();
}

class _NightPageState extends State<NightPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  RxDouble animX = (-1.5).obs;
  RxDouble animY = (-.3).obs;

  void initController() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onDone();
      }
    });
    animation = Tween<double>(begin: -.3, end: -.7).animate(controller)
      ..addListener(() {
        animY.value = animation.value;
        animX.value -= animation.value * .02;
      });
  }

  @override
  void initState() {
    initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Build NightPage');
    Future.delayed(const Duration(milliseconds: 500), () {
      controller.forward();
    });
    return Container(
      decoration: BoxDecoration(gradient: AppColors.gradient_loading_night_bg),
      child: Stack(
        alignment: Alignment.center,
        children: [
          buildMoon(),
          buildClouds(),
          nameWidget('good_night', top: Get.height * .4),
        ],
      ),
    );
  }

  Positioned buildClouds() {
    return Positioned(
      bottom: 0,
      child: Container(
        width: Get.width,
        child: Image.asset(
          'assets/images/startscreen/night/clouds.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildMoon() {
    return Obx(
      () => Align(
        alignment: Alignment(animX.value, animY.value),
        child: Container(
          width: Get.width * 0.25,
          height: Get.width * 0.25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(180),
              color: Colors.white.withOpacity(.61)),
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
