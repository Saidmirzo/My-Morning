import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/widgets/animatedButton.dart';
import 'package:morningmagic/widgets/custom_progress_bar/arcProgressBar.dart';
import 'package:vibration/vibration.dart';

class FitnessSuccessPage extends StatefulWidget {
  @override
  State createState() {
    return FitnessSuccessPageState();
  }
}

class FitnessSuccessPageState extends State<FitnessSuccessPage> {
  AssetsAudioPlayer assetsAudioPlayer;
  DateTime dateTime = DateTime.now();
  int count;

  @override
  void initState() {
    super.initState();
    _initializeAudioPlayer();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _vibrate();
      int _minutes =
          await MyDB().getBox().get(MyResource.FITNESS_TIME_KEY).time;
      _updateLocalData(_minutes);
    });
  }

  @override
  void dispose() {
    if (assetsAudioPlayer != null) {
      assetsAudioPlayer.stop();
      assetsAudioPlayer.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final _fitnessController = Get.find<FitnessController>();
        _fitnessController.step = 0;
        return true;
      },
      child: Scaffold(
        body: AppGradientContainer(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ArcProgressBar(
                  text: 'success'.tr(),
                ),
              ),
              SizedBox(
                height: 36,
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height / 5.5,
                child: AnimatedButton(
                    _continueClicked, 'rex', 'continue'.tr(), 21, null, null),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _continueClicked() async {
    Get.delete<FitnessController>();
    final _routeValue = await OrderUtil().getRouteById(2);

    Navigator.push(context, _routeValue);
  }

  void _updateLocalData(int minutes) {
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
        MyResource.YEAR_COUNT_OF_SESSIONS,
        MyDB().getBox().get(MyResource.YEAR_COUNT_OF_SESSIONS) != null
            ? MyDB().getBox().get(MyResource.YEAR_COUNT_OF_SESSIONS) + 1
            : 1);

    MyDB().getBox().put(
        MyResource.TOTAL_MINUTES_OF_AWARENESS,
        MyDB().getBox().get(MyResource.TOTAL_MINUTES_OF_AWARENESS) != null
            ? MyDB().getBox().get(MyResource.TOTAL_MINUTES_OF_AWARENESS) +
                minutes
            : minutes);
    MyDB().getBox().put(
        '${MyResource.MONTH_MINUTES_OF_AWARENESS}_${dateTime.month}',
        MyDB().getBox().get(MyResource.MONTH_MINUTES_OF_AWARENESS) != null
            ? MyDB().getBox().get(MyResource.MONTH_MINUTES_OF_AWARENESS) +
                minutes
            : minutes);
    MyDB().getBox().put(
        MyResource.YEAR_MINUTES_OF_AWARENESS,
        MyDB().getBox().get(MyResource.YEAR_MINUTES_OF_AWARENESS) != null
            ? MyDB().getBox().get(MyResource.YEAR_MINUTES_OF_AWARENESS) +
                minutes
            : minutes);

    MyDB().getBox().put(
        MyResource.PERCENT_OF_AWARENESS,
        MyDB().getBox().get(MyResource.PERCENT_OF_AWARENESS) != null
            ? MyDB().getBox().get(MyResource.PERCENT_OF_AWARENESS) + 0.5
            : 0.5);

    MyDB().getBox().put(
        _getWeekDay(),
        MyDB().getBox().get(_getWeekDay()) != null
            ? (MyDB().getBox().get(_getWeekDay()) + minutes)
            : minutes);
  }

  void _initializeAudioPlayer() {
    assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(Audio("assets/audios/success.mp3"));
  }

  Future<void> _vibrate() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
  }

  String _getWeekDay() {
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
      default:
        return 'unknown day';
    }
  }
}
