import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_visualizers/Visualizers/CircularBarVisualizer.dart';
import 'package:flutter_visualizers/Visualizers/CircularLineVisualizer.dart';
import 'package:flutter_visualizers/visualizer.dart';
import 'package:get/route_manager.dart';
import 'package:morningmagic/pages/settingsPage.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/tutorial_waves/im_animations.dart';
import 'package:easy_localization/easy_localization.dart';

class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  AssetsAudioPlayer player = AssetsAudioPlayer();
  bool value1 = false;
  bool animateAlign1 = false;

  bool value2 = false;
  bool animateAlign2 = false;

  bool value3 = false;
  bool animateAlign3 = false;

  bool value4 = false;
  bool animateAlign4 = false;

  bool value5 = false;
  bool animateAlign5 = false;

  bool value6 = false;
  bool animateAlign6 = false;
  @override
  void initState() {
    playTutorial();
    super.initState();
    viewIcon1();
  }

  void playTutorial() {
    Future.delayed(Duration(milliseconds: 200), () {
      player.open(Audio('tutorial_asset'.tr()));
      player.play();
    });
    player.playlistFinished.forEach((element) {
      if (element) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
            (route) => false);
      }
    });
  }

  Future<void> viewIcon1() async {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        value1 = true;
      });
      viewIcon2();
    });
  }

  Future<void> viewIcon2() async {
    Future.delayed(Duration(seconds: 6), () {
      setState(() {
        value2 = true;
      });
      viewIcon3();
    });
  }

  Future<void> viewIcon3() async {
    Future.delayed(Duration(seconds: 6), () {
      setState(() {
        value3 = true;
      });
      viewIcon4();
    });
  }

  Future<void> viewIcon4() async {
    Future.delayed(Duration(seconds: 6), () {
      setState(() {
        value4 = true;
      });
      viewIcon5();
    });
  }

  Future<void> viewIcon5() async {
    Future.delayed(Duration(seconds: 6), () {
      setState(() {
        value5 = true;
      });
      viewIcon6();
    });
  }

  Future<void> viewIcon6() async {
    Future.delayed(Duration(seconds: 6), () {
      setState(() {
        value6 = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 30),
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
              alignment: Alignment.topCenter,
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
            AnimatedAlign(
              alignment: animateAlign1
                  ? Alignment.lerp(
                      Alignment.bottomLeft, Alignment.bottomRight, 0)
                  : Alignment.lerp(
                      Alignment.center, Alignment.bottomCenter, 0.2),
              duration: Duration(seconds: 1),
              child: AnimatedContainer(
                height: animateAlign1 ? 50 : 150,
                width: animateAlign1 ? 50 : 150,
                duration: Duration(seconds: 1),
                child: AnimatedOpacity(
                  duration: Duration(seconds: 3),
                  opacity: value1 ? 1 : 0,
                  onEnd: () {
                    print('end');
                    setState(() {
                      animateAlign1 = true;
                    });
                  },
                  child: SvgPicture.asset('assets/images/meditation.svg',
                      color: Colors.grey[600]),
                ),
              ),
            ),
            AnimatedAlign(
              alignment: animateAlign2
                  ? Alignment.lerp(
                      Alignment.bottomLeft, Alignment.bottomRight, 0.2)
                  : Alignment.lerp(
                      Alignment.center, Alignment.bottomCenter, 0.2),
              duration: Duration(seconds: 1),
              child: AnimatedContainer(
                height: animateAlign2 ? 50 : 150,
                width: animateAlign2 ? 50 : 150,
                duration: Duration(seconds: 1),
                child: AnimatedOpacity(
                  duration: Duration(seconds: 3),
                  opacity: value2 ? 1 : 0,
                  onEnd: () {
                    print('end');
                    setState(() {
                      animateAlign2 = true;
                    });
                  },
                  child: SvgPicture.asset('assets/images/affirmation.svg',
                      color: Colors.grey[600]),
                ),
              ),
            ),
            AnimatedAlign(
              alignment: animateAlign3
                  ? Alignment.lerp(
                      Alignment.bottomLeft, Alignment.bottomRight, 0.4)
                  : Alignment.lerp(
                      Alignment.center, Alignment.bottomCenter, 0.2),
              duration: Duration(seconds: 1),
              child: AnimatedContainer(
                height: animateAlign3 ? 50 : 150,
                width: animateAlign3 ? 50 : 150,
                duration: Duration(seconds: 1),
                child: AnimatedOpacity(
                  duration: Duration(seconds: 3),
                  opacity: value3 ? 1 : 0,
                  onEnd: () {
                    print('end');
                    setState(() {
                      animateAlign3 = true;
                    });
                  },
                  child: SvgPicture.asset('assets/images/books.svg',
                      color: Colors.grey[600]),
                ),
              ),
            ),
            AnimatedAlign(
              alignment: animateAlign4
                  ? Alignment.lerp(
                      Alignment.bottomLeft, Alignment.bottomRight, 0.6)
                  : Alignment.lerp(
                      Alignment.center, Alignment.bottomCenter, 0.2),
              duration: Duration(seconds: 1),
              child: AnimatedContainer(
                height: animateAlign4 ? 50 : 150,
                width: animateAlign4 ? 50 : 150,
                duration: Duration(seconds: 1),
                child: AnimatedOpacity(
                  duration: Duration(seconds: 3),
                  opacity: value4 ? 1 : 0,
                  onEnd: () {
                    print('end');
                    setState(() {
                      animateAlign4 = true;
                    });
                  },
                  child: SvgPicture.asset('assets/images/sport.svg',
                      color: Colors.grey[600]),
                ),
              ),
            ),
            AnimatedAlign(
              alignment: animateAlign5
                  ? Alignment.lerp(
                      Alignment.bottomLeft, Alignment.bottomRight, 0.8)
                  : Alignment.lerp(
                      Alignment.center, Alignment.bottomCenter, 0.2),
              duration: Duration(seconds: 1),
              child: AnimatedContainer(
                height: animateAlign5 ? 50 : 150,
                width: animateAlign5 ? 50 : 150,
                duration: Duration(seconds: 1),
                child: AnimatedOpacity(
                  duration: Duration(seconds: 3),
                  opacity: value5 ? 1 : 0,
                  onEnd: () {
                    print('end');
                    setState(() {
                      animateAlign5 = true;
                    });
                  },
                  child: SvgPicture.asset('assets/images/diary.svg',
                      color: Colors.grey[600]),
                ),
              ),
            ),
            AnimatedAlign(
              alignment: animateAlign6
                  ? Alignment.lerp(
                      Alignment.bottomLeft, Alignment.bottomRight, 1)
                  : Alignment.lerp(
                      Alignment.center, Alignment.bottomCenter, 0.2),
              duration: Duration(seconds: 1),
              child: AnimatedContainer(
                height: animateAlign6 ? 50 : 150,
                width: animateAlign6 ? 50 : 150,
                duration: Duration(seconds: 1),
                child: AnimatedOpacity(
                  duration: Duration(seconds: 3),
                  opacity: value6 ? 1 : 0,
                  onEnd: () {
                    print('end');
                    setState(() {
                      animateAlign6 = true;
                    });
                  },
                  child: SvgPicture.asset(
                    'assets/images/visualization.svg',
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            // AnimatedOpacity(
            //   duration: Duration(seconds: 1),
            //   opacity: 1,
            //   child: AnimatedAlign(
            //       alignment: Alignment.center,
            //       duration: Duration(seconds: 1),
            //       child: SvgPicture.asset('assets/images/visualization.svg')),
            // ),
          ],
        ),
      ),
    );
  }
}
