import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/fitness/domain/entities/exercise/fitness_exercise.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/pages/fitness_success_page.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/customAppBar.dart';
import 'package:morningmagic/widgets/customBottomExerciseNavigation.dart';

class ExercisePage extends StatefulWidget {
  final FitnessExercise exercise;
  final int step;

  const ExercisePage({Key key, @required this.exercise, @required this.step})
      : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  FitnessController _fitnessController = Get.find<FitnessController>();
  final assetsAudioPlayer = AssetsAudioPlayer();
  TimerAppBar timerAppBar;

  @override
  Widget build(BuildContext context) {
    final currentStep = widget.step + 1;
    timerAppBar = TimerAppBar(exerciseName: widget.exercise.name);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: timerAppBar,
        ),
        body: AppGradientContainer(
            child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 270,
              child: LayoutBuilder(
                builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 15, bottom: 30),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    'exercise'.tr(namedArgs: {
                                      'id': currentStep.toString()
                                    }),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: "rex",
                                      color: AppColors.WHITE,
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.exercise.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: "rex",
                                    color: AppColors.WHITE,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                bottom: 30,
                                left: 20,
                                right: 20,
                              ),
                              child: Text(
                                widget.exercise.description,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "JMH",
                                  color: AppColors.VIOLET,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              child: BottomExerciseNavigation(
                soundCallback: _onListenClick,
                nextCallback: _onNextClick,
              ),
            ),
          ],
        )),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    _fitnessController.step = 0;
    _disposeServices();
    return true;
  }

  void _onListenClick() async {
    final _audioRes = widget.exercise.audioRes;
    if (_audioRes != null) {
      final _audioResPath = '$_audioRes'.tr();
      assetsAudioPlayer.open(
        Audio(_audioResPath),
      );
      assetsAudioPlayer.play();
    }
  }

  void _onNextClick() async {
    _disposeServices();

    final _exercise = _fitnessController.currentExercise;
    if (_exercise != null) {
      final _step = _fitnessController.step;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ExercisePage(exercise: _exercise, step: _step),
          ));
      _fitnessController.incrementStep();
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => FitnessSuccessPage()));
    }
  }

  void _disposeServices() {
    timerAppBar.cancelTimer();
    assetsAudioPlayer.stop();
    assetsAudioPlayer.dispose();
  }
}
