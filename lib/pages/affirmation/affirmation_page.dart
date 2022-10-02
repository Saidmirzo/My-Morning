import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/components/timer_block.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/dialog/back_to_main_menu_dialog.dart';
import 'package:morningmagic/pages/affirmation/timer/timer_page.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/resources/styles.dart';
import 'package:morningmagic/routing/route_values.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/storage.dart';
import '../../resources/colors.dart';
import '../../routing/app_routing.dart';
import 'components/bg.dart';

class AffirmationPage extends StatefulWidget {
  final bool fromHomeMenu;
  const AffirmationPage({Key key, this.fromHomeMenu = false}) : super(key: key);
  @override
  AffirmationPageState createState() => AffirmationPageState();
}

class AffirmationPageState extends State<AffirmationPage> {
  TimerService timerService = TimerService();

  @override
  void initState() {
    if (menuState == MenuState.MORNING) {
      timerService.setTime(
          (myDbBox.get(MyResource.AFFIRMATION_TIME_KEY).time ?? 5) * 60);
    } else {
      timerService.setNightTime(
          (myDbBox.get(MyResource.AFFIRMATION_TIME_KEY).time ?? 5) * 60);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(gradient: AppColors.Bg_Gradient_2),
          width: Get.width,
          height: Get.height,
          child: SafeArea(
            bottom: false,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                bg(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Spacer(
                      flex: 3,
                    ),
                    BackButton(
                      fromHomeMenu: widget.fromHomeMenu,
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    // SizedBox(height: Get.height * 0.15),
                    Text('affirmation'.tr, style: AppStyles.treaningTitle),
                    // SizedBox(height: Get.height * 0.05),
                    const Spacer(
                      flex: 2,
                    ),
                    Text(
                      'affirmation_title'.tr,
                      style: AppStyles.treaningSubtitle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Get.height * 0.05),
                    const Spacer(
                      flex: 3,
                    ),
                    TimerBlock(
                      title: 'How much time are you going to read'.tr,
                      timerService: timerService,
                      fromHomeMenu: widget.fromHomeMenu,
                      isaformation: true,
                    ),
                    const Spacer(
                      flex: 11,
                    ),
                    StartButton(
                      onClick: () {
                        Get.to(() => AffirmationTimerPage(
                            fromHomeMenu: widget.fromHomeMenu,
                            timerService: timerService,
                          ));
                      },
                    ),
                    const Spacer(
                      flex: 4,
                    )
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
      ),
    );
  }

  Future<bool> _onWillPop() async {
    AppRouting.navigateToHomeWithClearHistory();
    return false;
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key key,
    this.fromHomeMenu,
  }) : super(key: key);

  final bool fromHomeMenu;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        child: const Padding(
          padding: EdgeInsets.only(left: 31),
          child: Icon(
            Icons.west,
            color: Colors.white,
            size: 30,
          ),
        ),
        onTap: () {
          if (isComplex) {
            showDialog(
              context: context,
              builder: (context) => const BackToMainMenuDialog(),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainMenuPage()),
            );
          }
        },
      ),
    );
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
            'Start affirmation'.tr,
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
