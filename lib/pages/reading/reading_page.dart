import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/add_time_page/add_time_period.dart';
import 'package:morningmagic/pages/loading/night.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/pages/nigth/nigth.dart';
import 'package:morningmagic/pages/reading/timer/timer_page.dart';
import 'package:morningmagic/resources/styles.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

import '../../resources/colors.dart';
import '../../storage.dart';
import 'components/bg.dart';

class ReadingPage extends StatefulWidget {
  final bool fromHomeMenu;

  ReadingPage({Key key, this.fromHomeMenu = false}) : super(key: key);

  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: menuState == MenuState.MORNING
                ? AppColors.Bg_Gradient_2
                : AppColors.reading_night_mode),
        width: Get.width,
        height: Get.height,
        child: SafeArea(
          bottom: false,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              menuState == MenuState.MORNING ? bg() : bgNight(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: PrimaryCircleButton(
                      icon: Icon(Icons.arrow_back, color: AppColors.primary),
                      onPressed: () {
                        if (widget.fromHomeMenu)
                          return Get.off(
                              menuState == MenuState.NIGT
                                  ? MainMenuNightPage()
                                  : MainMenuPage(),
                              opaque: true);
                        OrderUtil()
                            .getPreviousRouteById(TimerPageId.Reading)
                            .then((value) {
                          Get.off(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: Get.height * 0.15),
                  Text('reading'.tr, style: AppStyles.treaningTitle),
                  SizedBox(height: Get.height * 0.05),
                  Text('reading_title'.tr,
                      style: AppStyles.treaningSubtitle,
                      textAlign: TextAlign.center),
                  SizedBox(height: Get.height * 0.05),
                  PrimaryCircleButton(
                      icon: Icon(Icons.arrow_forward, color: AppColors.primary),
                      onPressed: () => Get.to(ReadingTimerPage(
                            fromHomeMenu: widget.fromHomeMenu,
                          ))),
                  SizedBox(height: Get.height * 0.02),
                  if (menuState == MenuState.NIGT)
                    CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () async {
                        TimerService timerSevice = TimerService();
                        await Get.to(AddTimePeriod(
                          timerService: timerSevice,
                        ));
                        Get.to(ReadingTimerPage(
                          timerService: timerSevice,
                        ));
                      },
                      child: SvgPicture.asset(
                          'assets/images/reading_night/timer_button.svg'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
