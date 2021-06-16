//TODO: Нужно удалить после настройки страницы WelcomePage

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/widgets/tutorial_waves/im_animations.dart';

import '../routing/app_routing.dart';
import 'settings/settingsPage.dart';

class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  AudioPlayer player = AudioPlayer();
  bool isCloseTutorial = false;
  bool value1 = false;
  bool animateAlign1 = false;

  bool value2 = false;
  bool text1 = false;

  bool value3 = false;
  bool text2 = false;

  bool value4 = false;
  bool text3 = false;

  bool value5 = false;
  bool text4 = false;

  bool value6 = false;
  bool text5 = false;

  bool value7 = false;
  bool text6 = false;

  bool isClose = false;

  closeTutorial() {
    if (isCloseTutorial) {}
  }

  @override
  void initState() {
    playTutorial();
    super.initState();
    viewIcon1();
  }

  void playTutorial() {
    Future.delayed(Duration(milliseconds: 200), () async {
      await player.setAsset('tutorial_asset'.tr);
      await player.play();
    });

    player.playerStateStream.listen((state) {
      print("${state.processingState.index}, playing = ${state.playing}");
      if (state.playing &&
          state.processingState.index == ProcessingState.completed.index) {
        AppRouting.replace(SettingsPage());
        // Navigator.pushNamedAndRemoveUntil(
        //     context, homePageRoute, (route) => false);
      }
    });
  }

  viewIcon1() async {
    setState(() {
      value1 = true;
    });
    await Future.delayed(Duration(seconds: 5), () {
      viewIcon2();
    });
  }

  viewIcon2() async {
    setState(() {
      value1 = false;
    });
    await Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        value2 = true;
        text1 = true;
      });

      viewIcon3();
    });
  }

  viewIcon3() async {
    await Future.delayed(Duration(milliseconds: 4400), () {
      setState(() {
        value3 = true;
        text2 = true;
      });

      viewIcon4();
    });
  }

  viewIcon4() async {
    await Future.delayed(Duration(milliseconds: 4400), () {
      setState(() {
        value4 = true;
        text3 = true;
      });

      viewIcon5();
    });
  }

  viewIcon5() async {
    await Future.delayed(Duration(milliseconds: 4400), () {
      setState(() {
        value5 = true;
        text4 = true;
        isClose = true;
      });

      viewIcon6();
    });
  }

  viewIcon6() async {
    await Future.delayed(Duration(milliseconds: 4400), () {
      setState(() {
        value6 = true;
        text5 = true;
      });

      viewIcon7();
    });
  }

  viewIcon7() async {
    await Future.delayed(Duration(milliseconds: 4400), () {
      setState(() {
        value7 = true;
        text6 = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 30),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/background_tutorial.jpg'),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment:
                  Alignment.lerp(Alignment.topCenter, Alignment.center, 0.1),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: ColorSonar(
                  contentAreaRadius: 60,
                  waveFall: 20,
                  innerWaveColor: AppColors.LIGHT_VIOLET.withOpacity(0.4),
                  middleWaveColor: AppColors.LIGHT_VIOLET.withOpacity(0.3),
                  outerWaveColor: AppColors.LIGHT_VIOLET.withOpacity(0.1),
                  duration: Duration(seconds: 2),
                  contentAreaColor: Colors.transparent,
                  waveMotionEffect: Curves.fastOutSlowIn,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.lerp(
                  Alignment.center, Alignment.bottomCenter, 0.25),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: value1 ? 0 : 1000),
                opacity: value1 ? 1 : 0,
                onEnd: () {
                  print('end');
                  setState(() {
                    value1 = false;
                  });
                },
                child: Text(
                  'tutorial_text'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.lerp(
                  Alignment.center, Alignment.bottomCenter, 0.25),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 2000),
                opacity: text1 ? 1 : 0,
                onEnd: () {
                  print('end');
                  setState(() {
                    text1 = false;
                  });
                },
                child: Text(
                  'meditation_small'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.lerp(
                  Alignment.bottomLeft, Alignment.bottomRight, 0),
              child: Container(
                height: 50,
                width: 50,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 2000),
                  opacity: value2 ? 1 : 0,
                  onEnd: () {
                    print('end');
                  },
                  child: SvgPicture.asset('assets/images/meditation.svg',
                      color: Colors.grey[600]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.lerp(
                  Alignment.center, Alignment.bottomCenter, 0.25),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 2000),
                opacity: text2 ? 1 : 0,
                onEnd: () {
                  print('end');
                  setState(() {
                    text2 = false;
                  });
                },
                child: Text(
                  'affirmation_small'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.lerp(
                  Alignment.bottomLeft, Alignment.bottomRight, 0.2),
              child: Container(
                height: 50,
                width: 50,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 2000),
                  opacity: value3 ? 1 : 0,
                  onEnd: () {
                    print('end');
                    setState(() {});
                  },
                  child: SvgPicture.asset('assets/images/affirmation.svg',
                      color: Colors.grey[600]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.lerp(
                  Alignment.center, Alignment.bottomCenter, 0.25),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 2000),
                opacity: text3 ? 1 : 0,
                onEnd: () {
                  print('end');
                  setState(() {
                    text3 = false;
                  });
                },
                child: Text(
                  'visualization_small'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.lerp(
                  Alignment.bottomLeft, Alignment.bottomRight, 0.4),
              child: Container(
                height: 50,
                width: 50,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 2000),
                  opacity: value4 ? 1 : 0,
                  onEnd: () {
                    print('end');
                    setState(() {});
                  },
                  child: SvgPicture.asset('assets/images/visualization.svg',
                      color: Colors.grey[600]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.lerp(
                  Alignment.center, Alignment.bottomCenter, 0.25),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 2000),
                opacity: text4 ? 1 : 0,
                onEnd: () {
                  print('end');
                  setState(() {
                    text4 = false;
                  });
                },
                child: Text(
                  'fitness_small'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.lerp(
                  Alignment.bottomLeft, Alignment.bottomRight, 0.6),
              child: Container(
                height: 50,
                width: 50,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 2000),
                  opacity: value5 ? 1 : 0,
                  onEnd: () {
                    print('end');
                    setState(() {});
                  },
                  child: SvgPicture.asset('assets/images/sport.svg',
                      color: Colors.grey[600]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.lerp(
                  Alignment.center, Alignment.bottomCenter, 0.25),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 2000),
                opacity: text5 ? 1 : 0,
                onEnd: () {
                  print('end');
                  setState(() {
                    text5 = false;
                  });
                },
                child: Text(
                  'reading_small'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.lerp(
                  Alignment.bottomLeft, Alignment.bottomRight, 0.8),
              child: Container(
                height: 50,
                width: 50,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 2000),
                  opacity: value6 ? 1 : 0,
                  onEnd: () {
                    print('end');
                    setState(() {});
                  },
                  child: SvgPicture.asset('assets/images/books.svg',
                      color: Colors.grey[600]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.lerp(
                  Alignment.center, Alignment.bottomCenter, 0.25),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 2000),
                opacity: text6 ? 1 : 0,
                onEnd: () {
                  print('end');
                  setState(() {
                    text6 = false;
                  });
                },
                child: Text(
                  'diary_small'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.lerp(
                  Alignment.bottomLeft, Alignment.bottomRight, 1),
              child: Container(
                height: 50,
                width: 50,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 2000),
                  opacity: value7 ? 1 : 0,
                  onEnd: () {
                    print('end');
                    setState(() {});
                  },
                  child: SvgPicture.asset(
                    'assets/images/diary.svg',
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            isClose
                ? InkWell(
                    onTap: () async {
                      await player.stop();
                      AppRouting.replace(SettingsPage());
                      appAnalitics.logEvent('first_skip_tutorial');
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      child: Icon(
                        Icons.close,
                        size: 50,
                        color: AppColors.GRAY,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
