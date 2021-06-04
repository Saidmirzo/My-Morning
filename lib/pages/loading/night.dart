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
    print('Build NightPage');
    Future.delayed(const Duration(milliseconds: 500), () {
      controller.forward();
    });
    return Container(
      decoration: BoxDecoration(gradient: AppColors.gradient_loading_night_bg),
      child: Stack(
        alignment: Alignment.center,
        children: [
          buildClouds(),
          buildSun(),
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

  Widget buildSun() {
    return Positioned(
      top: Get.width * .3,
      left: Get.width * .15,
      child: Container(
        width: Get.width * 0.25,
        height: Get.width * 0.25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(180),
            color: Colors.white.withOpacity(.61)),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
