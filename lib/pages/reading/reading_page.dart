import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/components/timer_block.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/dialog/back_to_main_menu_dialog.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/pages/nigth/nigth.dart';
import 'package:morningmagic/pages/reading/timer/timer_page.dart';
import 'package:morningmagic/resources/styles.dart';
import 'package:morningmagic/routing/route_values.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/timer_service.dart';

import '../../resources/colors.dart';
import '../../storage.dart';
import 'components/bg.dart';

class ReadingPage extends StatefulWidget {
  final bool fromHomeMenu;

  const ReadingPage({Key key, this.fromHomeMenu = false}) : super(key: key);

  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  TimerService timerService = TimerService();

  @override
  void initState() {
    if (menuState == MenuState.MORNING) {
      timerService
          .setTime((myDbBox.get(MyResource.READING_TIME_KEY).time ?? 5) * 60);
    } else {
      timerService
          .setNightTime(myDbBox.get(MyResource.READING_TIME_KEY).time ?? 5);
    }
    Future.delayed(Duration.zero, () => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: menuState == MenuState.MORNING
                ? AppColors.bgGradient2
                : AppColors.readingNightMode),
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
                  const Spacer(
                    flex: 3,
                  ),
                  BackButton(widget: widget),
                  const Spacer(
                    flex: 2,
                  ),
                  Text('reading'.tr, style: AppStyles.trainingTitle),
                  const Spacer(
                    flex: 2,
                  ),
                  Text(
                    'reading_title'.tr,
                    style: AppStyles.trainingSubtitle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Get.height * 0.05),
                  const Spacer(
                    flex: 3,
                  ),
                  TimerBlock(
                    mycolorbool: menuState == MenuState.MORNING ? true : false,
                    title: 'How much time are you going to read?'.tr,
                    isaformation: false,
                    timerService: timerService,
                    fromHomeMenu: widget.fromHomeMenu,
                  ),
                  const Spacer(
                    flex: 10,
                  ),
                  StartButton(
                    onClick: () {
                      if (timerService.startTime < 60) {
                        timerService.setTime(
                            (myDbBox.get(MyResource.READING_TIME_KEY).time ??
                                    5) *
                                60);
                      }
                      Get.to(() => ReadingTimerPage(
                          fromHomeMenu: widget.fromHomeMenu,
                          timerService: timerService,
                        ));
                    },
                  ),
                  const Spacer(
                    flex: 4,
                  )
                  // PrimaryCircleButton(
                  //     icon: const Icon(Icons.arrow_forward, color: AppColors.primary),
                  //     onPressed: () => Get.to(ReadingTimerPage(
                  //           fromHomeMenu: widget.fromHomeMenu,
                  //         ))),
                  // SizedBox(height: Get.height * 0.02),
                  // if (menuState == MenuState.NIGT)
                  //   CupertinoButton(
                  //     padding: const EdgeInsets.all(0),
                  //     onPressed: () async {
                  //       TimerService timerSevice = TimerService();
                  //       await Get.to(AddTimePeriod(
                  //         timerService: timerSevice,
                  //       ));
                  //       Get.to(ReadingTimerPage(
                  //           timerService: timerSevice,
                  //           fromHomeMenu: widget.fromHomeMenu));
                  //     },
                  //     child: SvgPicture.asset(
                  //         'assets/images/reading_night/timer_button.svg'),
                  //   ),
                ],
              ),
              if (isComplex)
                Positioned(
                  top: 40,
                  right: 30,
                  child: GestureDetector(
                    onTap: () {
                      appAnalitics.logEvent('first_menu_setings');
                      Navigator.pushNamed(context, settingsPageRoute);
                    },
                    child: Container(
                      width: 47.05,
                      height: 47.05,
                      padding: const EdgeInsets.all(12.76),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        'assets/images/home_menu/settings_icon_2.png',
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final ReadingPage widget;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 31),
          child: GestureDetector(
            onTap: () {
              if (isComplex) {
                showDialog(
                  context: context,
                  builder: (context) => const BackToMainMenuDialog(),
                );
              } else {
                // if (widget.fromHomeMenu) {
                // Get.off(
                //     menuState == MenuState.NIGT
                //         ? MainMenuNightPage()
                //         : const MainMenuPage(),
                //     opaque: true);
                menuState == MenuState.NIGT
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainMenuNightPage()),
                      )
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainMenuPage()),
                      );

                // }
                // OrderUtil()
                //     .getPreviousRouteById(TimerPageId.Reading)
                //     .then((value) {
                //   Get.off(value);
                // });
              }
            },
            child: const Icon(
              Icons.west,
              size: 30,
              color: Colors.white,
            ),
          ),
        ));
  }
}

class StartButton extends StatelessWidget {
  const StartButton({Key key, this.onClick}) : super(key: key);
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(horizontal: 31),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: menuState == MenuState.MORNING
                ? const Color(0xff592F72)
                : Colors.white,
            borderRadius: BorderRadius.circular(19),
          ),
          child: Text(
            'Start reading'.tr,
            style: TextStyle(
              color: menuState == MenuState.MORNING
                  ? Colors.white
                  : const Color(0xff592F72),
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
