import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/customInputNextColumn.dart';
import 'package:morningmagic/widgets/custom_progress_bar/arcProgressBar.dart';
import 'package:vibration/vibration.dart';

class TimerInputSuccessScreen extends StatefulWidget {
  final int minutes;

  TimerInputSuccessScreen({this.minutes});

  @override
  State createState() {
    return TimerInputSuccessScreenState();
  }
}

class TimerInputSuccessScreenState extends State<TimerInputSuccessScreen> {
  AudioPlayer _audioPlayer;
  int count;
  DateTime dateTime = DateTime.now();

  String getWeekDay() {
    switch (DateTime.now().weekday) {
      case 1:
        return MyResource.MONDAY;
      case 2:
        return MyResource.TUESDAY;
      case 3:
        return MyResource.WEDNESDAY;
      case 4:
        return MyResource.THUSDAY;
      case 5:
        return MyResource.FRIDAY;
      case 6:
        return MyResource.SATURDAY;
      case 7:
        return MyResource.SUNDAY;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
    MyDB().getBox().put(
        MyResource.TOTAL_COUNT_OF_SESSIONS,
        MyDB().getBox().get(MyResource.TOTAL_COUNT_OF_SESSIONS) != null
            ? MyDB().getBox().get(MyResource.TOTAL_COUNT_OF_SESSIONS) + 1
            : 1);
    MyDB().getBox().put(
        '${MyResource.MONTH_COUNT_OF_SESSIONS}_${dateTime.month}',
        MyDB().getBox().get(MyResource.MONTH_COUNT_OF_SESSIONS) != null
            ? MyDB().getBox().get(MyResource.MONTH_COUNT_OF_SESSIONS) + 1
            : 1);
    MyDB().getBox().put(
        '${MyResource.YEAR_COUNT_OF_SESSIONS}_${dateTime.year}',
        MyDB().getBox().get(MyResource.YEAR_COUNT_OF_SESSIONS) != null
            ? MyDB().getBox().get(MyResource.YEAR_COUNT_OF_SESSIONS) + 1
            : 1);

    MyDB().getBox().put(
        MyResource.TOTAL_MINUTES_OF_AWARENESS,
        MyDB().getBox().get(MyResource.TOTAL_MINUTES_OF_AWARENESS) != null
            ? MyDB().getBox().get(MyResource.TOTAL_MINUTES_OF_AWARENESS) +
                widget.minutes
            : widget.minutes);
    MyDB().getBox().put(
        '${MyResource.MONTH_MINUTES_OF_AWARENESS}_${dateTime.month}',
        MyDB().getBox().get(MyResource.MONTH_MINUTES_OF_AWARENESS) != null
            ? MyDB().getBox().get(MyResource.MONTH_MINUTES_OF_AWARENESS) +
                widget.minutes
            : widget.minutes);
    MyDB().getBox().put(
        '${MyResource.YEAR_MINUTES_OF_AWARENESS}_${dateTime.year}',
        MyDB().getBox().get(MyResource.YEAR_MINUTES_OF_AWARENESS) != null
            ? MyDB().getBox().get(MyResource.YEAR_MINUTES_OF_AWARENESS) +
                widget.minutes
            : widget.minutes);
    MyDB().getBox().put(
        MyResource.PERCENT_OF_AWARENESS,
        MyDB().getBox().get(MyResource.PERCENT_OF_AWARENESS) != null
            ? MyDB().getBox().get(MyResource.PERCENT_OF_AWARENESS) + 0.5
            : 0.5);

    MyDB().getBox().put(
        getWeekDay(),
        MyDB().getBox().get(getWeekDay()) != null
            ? (MyDB().getBox().get(getWeekDay()) + widget.minutes)
            : widget.minutes);
  }

  Future<void> _asyncMethod() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_audioPlayer != null) {
      _audioPlayer.stop();
      _audioPlayer.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: Container(
            width:
                MediaQuery.of(context).size.width, // match parent(all screen)
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
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight),
                    child: Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.7,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: ArcProgressBar(
                              text: 'success'.tr,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 17,
                                bottom:
                                    MediaQuery.of(context).size.height / 17),
                            child: InputTextColumn(() {
                              if (_audioPlayer != null) {
                                _audioPlayer.stop();
                                _audioPlayer.dispose();
                              }
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_audioPlayer != null) {
      _audioPlayer.stop();
      _audioPlayer.dispose();
    }
    return true;
  }
}
