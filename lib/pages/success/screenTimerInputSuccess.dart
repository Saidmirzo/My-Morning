import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
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
  AssetsAudioPlayer assetsAudioPlayer;
  int count;
  DateTime dateTime = DateTime.now();

  String getWeekDay() {
    switch (DateTime.now().weekday) {
      case 1:
        return 'monday';
      case 2:
        return 'tuesday';
      case 3:
        return 'wednesday';
      case 4:
        return 'thursday';
      case 5:
        return 'friday';
      case 6:
        return 'saturday';
      case 7:
        return 'sunday';
    }
  }

  @override
  void initState() {
    super.initState();
    assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(Audio("assets/audios/success.mp3"));
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
    if (assetsAudioPlayer != null) {
      assetsAudioPlayer.stop();
      assetsAudioPlayer.dispose();
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
                              text: 'success'.tr(),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 17,
                                bottom:
                                    MediaQuery.of(context).size.height / 17),
                            child: InputTextColumn(() {
                              if (assetsAudioPlayer != null) {
                                assetsAudioPlayer.stop();
                                assetsAudioPlayer.dispose();
                              }
//                            }, widget.seconds, widget.bookTitle, widget.box),
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
    if (assetsAudioPlayer != null) {
      assetsAudioPlayer.stop();
      assetsAudioPlayer.dispose();
    }
    return true;
  }
}
