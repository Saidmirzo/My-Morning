import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/progress_util.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/widgets/customAppBar.dart';
import 'package:morningmagic/widgets/customBottomExerciseNavigation.dart';

class ExerciseDetails extends StatefulWidget {

  final int stepId;
  final int pageId;
  final bool isCustomProgramm;

  const ExerciseDetails({Key key, 
    @required this.stepId,
    @required this.pageId,
    @required this.isCustomProgramm
  }) : super(key: key);

  @override
  State createState() {
    return ExerciseOneScDetails();
  }
}

class ExerciseOneScDetails extends State<ExerciseDetails> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  TimerAppBar timerAppBar;
  
  @override
  Widget build(BuildContext context) {
    int id = widget.stepId + 1;
    timerAppBar = TimerAppBar(
      'exercise_${id}_title'.tr()
    );
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: timerAppBar,
        ),
        body: Center(
          child: Container(
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
                                      padding: EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        'exercise'.tr(namedArgs: {'id': id.toString()}),
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
                                padding: EdgeInsets.only(bottom: 30),
                                child: Text(
                                  'exercise_${id}_text'.tr(),
                                  textAlign: TextAlign.center,
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
                      assetsAudioPlayer.open(
                        Audio('exercise_${id}_sound'.tr()),
                      );
                      assetsAudioPlayer.play();
                    }, nextCallback: () {
                      timerAppBar.cancelTimer();
                      assetsAudioPlayer.stop();
                      assetsAudioPlayer.dispose();
                      if (widget.isCustomProgramm){
                        ExerciseUtils().goNextRoute(context, widget.pageId);
                      } else if (id<10) Navigator.push( context, MaterialPageRoute(builder: (context) => ExerciseDetails(stepId: id, pageId: widget.pageId, isCustomProgramm: false)) );
                      else {
                        OrderUtil().getRouteById(2).then((value) {
                          Navigator.push( context,
                            MaterialPageRoute(
                              builder: (context) => TimerSuccessScreen(() {
                                Navigator.push(context, value);
                              })
                            )
                          );
                        });
                      }
                    }))
              ],
            )
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    assetsAudioPlayer.stop();
    assetsAudioPlayer.dispose();
    timerAppBar.cancelTimer();
    return true;
  }
}