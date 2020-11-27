import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/services/timer_service.dart';

import '../resources/colors.dart';
import '../utils/string_util.dart';
import '../widgets/customStartSkipColumn.dart';
import '../widgets/customText.dart';
import '../widgets/custom_progress_bar/circleProgressBar.dart';

class TimerPage extends StatefulWidget {
  final int pageId;

  const TimerPage({Key key, @required this.pageId}) : super(key: key);

  @override
  State createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  bool isInitialized = false;
  TimerService timerService = TimerService();

  @override
  void initState() {
    super.initState();
    timerService.init(this, context, widget.pageId);
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      isInitialized = true;
      timerService.buttonText = 'start'.tr();
    }
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Container(
                  width: MediaQuery.of(context)
                      .size
                      .width, // match parent(all screen)
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 16,
                      ),
                      getAffirmationWidget(),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: CircleProgressBar(
                          text:
                              StringUtil().createTimeString(timerService.time),
                          foregroundColor: AppColors.WHITE,
                          value: timerService.createValue(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 40),
                        child: StartSkipColumn(
                            () => timerService.startTimer(),
                            () => timerService.skipTask(),
                            () => timerService.goToHome(),
                            timerService.buttonText),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 10),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getAffirmationWidget() {
    if (widget.pageId == 0 && timerService.affirmationText != null) {
      return Container(
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 30),
        child: AffirmationText(
          text: timerService.affirmationText,
          size: 22,
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    super.dispose();
    timerService.dispose();
  }
}
