import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/progress_util.dart';
import 'package:morningmagic/widgets/animatedButton.dart';
import 'package:morningmagic/widgets/customAppBar.dart';

class ExerciseCustomDetails extends StatefulWidget {
  final String title;
  final int pageId;

  const ExerciseCustomDetails(
      {Key key, @required this.title, @required this.pageId})
      : super(key: key);

  @override
  ExerciseCustomDetailsState createState() {
    return ExerciseCustomDetailsState();
  }
}

class ExerciseCustomDetailsState extends State<ExerciseCustomDetails> {
  TimerAppBar timerAppBar;

  @override
  Widget build(BuildContext context) {
    timerAppBar = TimerAppBar(exerciseName: widget.title);
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: timerAppBar,
        ),
        body: Center(
          child: Container(
              width:
                  MediaQuery.of(context).size.width, // match parent(all screen)
              height: MediaQuery.of(context)
                  .size
                  .height, // match parent(all screen)
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.TOP_GRADIENT,
                  AppColors.MIDDLE_GRADIENT,
                  AppColors.BOTTOM_GRADIENT
                ],
              )),
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
                            child: Center(
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontStyle: FontStyle.normal,
                                  color: AppColors.VIOLET,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: AnimatedButton(() {
                          if (timerAppBar != null) {
                            timerAppBar.cancelTimer();
                          }
                          ExerciseUtils().goNextRoute(context, widget.pageId);
                        }, 'next_exercise'.tr, 20, null, null),
                      ))
                ],
              )),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    ExerciseUtils().goPreviousRoute();
    if (timerAppBar != null) {
      timerAppBar.cancelTimer();
    }
    return true;
  }
}
