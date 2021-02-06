import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/analyticService.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/progress_util.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/widgets/customAppBar.dart';
import 'package:morningmagic/widgets/customBottomExerciseNavigation.dart';

class ExerciseDetails extends StatefulWidget {
  final int stepId;
  final int pageId;
  final bool isCustomProgram;

  const ExerciseDetails(
      {Key key,
      @required this.stepId,
      @required this.pageId,
      @required this.isCustomProgram})
      : super(key: key);

  @override
  State createState() {
    return ExerciseOneScDetails();
  }
}

class ExerciseOneScDetails extends State<ExerciseDetails> {
  final _audioPlayer = AudioPlayer();
  TimerAppBar timerAppBar;

  @override
  void initState() {
    if (widget.stepId == 9) {
      AnalyticService.screenView('fitness_timer_page');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int id = widget.stepId + 1;
    timerAppBar = TimerAppBar(exerciseName: 'exercise_${id}_title'.tr());
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: timerAppBar,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.TOP_GRADIENT,
                  AppColors.MIDDLE_GRADIENT,
                  AppColors.BOTTOM_GRADIENT
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 270,
                  child: LayoutBuilder(
                    builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
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
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      padding: EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        'exercise'.tr(
                                            namedArgs: {'id': id.toString()}),
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
                                      'exercise_${id}_title'.tr(),
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
                              Container(
                                padding: EdgeInsets.only(
                                  bottom: 30,
                                  left: 20,
                                  right: 20,
                                ),
                                child: Text(
                                  'exercise_${id}_text'.tr(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "JMH",
                                    color: AppColors.VIOLET,
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
                    child: BottomExerciseNavigation(soundCallback: () async {
                      // man voice
                      // assetsAudioPlayer.open(
                      //   Audio('exercise_${id}_sound'.tr()),
                      // );
                      // assetsAudioPlayer.play();
                    }, nextCallback: () {
                      timerAppBar.cancelTimer();
                      _audioPlayer.stop();
                      _audioPlayer.dispose();
                      if (widget.isCustomProgram) {
                        ExerciseUtils().goNextRoute(context, widget.pageId);
                      } else if (id < 10)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExerciseDetails(
                                    stepId: id,
                                    pageId: widget.pageId,
                                    isCustomProgram: false)));
                      else {
                        OrderUtil().getRouteById(2).then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TimerSuccessScreen(() {
                                        Navigator.push(context, value);
                                      },
                                          MyDB()
                                              .getBox()
                                              .get(MyResource.FITNESS_TIME_KEY)
                                              .time,
                                          false)));
                        });
                      }
                    }))
              ],
            )),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    timerAppBar.cancelTimer();
    return true;
  }
}
