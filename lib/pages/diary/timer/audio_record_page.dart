import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/model/progress/vocabulary_progress/vocabulary_record_progress.dart';
import 'package:morningmagic/db/progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/progress/progress_page.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:morningmagic/widgets/sound_waves_diagram/my/line_box.dart';
import 'package:morningmagic/widgets/timer_circle_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:random_string/random_string.dart';

class TimerRecordPage extends StatefulWidget {
  final bool fromHomeMenu;

  const TimerRecordPage({Key key, this.fromHomeMenu = false}) : super(key: key);
  @override
  State createState() {
    return _TimerRecordPageState();
  }
}

class _TimerRecordPageState extends State<TimerRecordPage> {
  // Timer
  Timer _timer;
  RxInt _time = 0.obs;
  int _startTime;

  PermissionStatus statusMicrophone;
  PermissionStatus statusStorage;

  FlutterAudioRecorder _recorder;
  Recording _recording;
  RxBool isRecording = false.obs;
  var result;
  // var lineBox = LineBox(lines: 21);

  Future<bool> getPermissions() async {
    statusMicrophone = await Permission.microphone.status;

    if (statusMicrophone.isGranted) {
      return true;
    }

    if (statusMicrophone.isUndetermined || statusMicrophone.isDenied) {
      statusMicrophone = await Permission.microphone.request();
    }

    return statusMicrophone.isGranted;
  }

  Future<String> get _localPath async {
    final directory = Platform.isIOS
        ? await getApplicationDocumentsDirectory()
        : await getTemporaryDirectory();
    return directory.path + "/" + randomAlpha(10);
  }

  bool isStarted = false;

  Future<void> _startRecording() async {
    await _recorder.start();
    Recording current = await _recorder.current();
    _recording = current;
    isRecording.toggle();
  }

  Future<void> _resumeRecording() async {
    await _recorder.resume();
    Recording current = await _recorder.current();
    _recording = current;
    isRecording.toggle();
  }

  Future<void> _stopRecording() async {
    result = await _recorder.stop();
    Recording current = await _recorder.current();
    _recording = current;
    isRecording.toggle();
    print(result);
  }

  int count;

  Future<void> _pauseRecording() async {
    await _recorder.pause();
    Recording current = await _recorder.current();
    _recording = current;
    isRecording.toggle();
  }

  Future<void> playPause() async {
    if (_recording == null) {
//      ToastUtils.createOverlayEntry(context, AppLocalizations.of(context)
//          .translate("add_permission"));
      return;
    }
    switch (_recording.status) {
      case RecordingStatus.Initialized:
        {
          await _startRecording();
          print("START RECORDING !!!!!!!!!!!!!!!!");
          break;
        }

      case RecordingStatus.Recording:
        {
          await _pauseRecording();
          print("PAUSE RECORDING !!!!!!!!!!!!!!!!");
          break;
        }

      case RecordingStatus.Paused:
        {
          await _resumeRecording();
          print("RESUME RECORDING !!!!!!!!!!!!!!!!");
          break;
        }

      case RecordingStatus.Stopped:
        {
          await _prepare();
          await _startRecording();
          print("START RECORDING AFTER STOP !!!!!!!!!!!!!!!!");
          break;
        }

      default:
        break;
    }
  }

  Future<void> stop() async {
    if (_recording == null) {
      return;
    }
    switch (_recording.status) {
      case RecordingStatus.Recording:
        {
          await _stopRecording();
          saveVocabularyRecordProgress(_recording.path);
          print("STOP RECORDING !!!!!!!!!!!!!!!!");
          break;
        }
      case RecordingStatus.Paused:
        {
          await _stopRecording();
          saveVocabularyRecordProgress(_recording.path);
          print("STOP RECORDING !!!!!!!!!!!!!!!!");
          break;
        }
      default:
        break;
    }
  }

  void saveProg(String box, String path) {
    print('savep progress');
    DateTime date = DateTime.now();
    List<dynamic> list = MyDB().getBox().get(box) ?? [];
    setState(() {
      list.add([
        list.isNotEmpty ? (int.parse(list.last[0]) + 1).toString() : '0',
        path,
        '${date.day}.${date.month}.${date.year}',
      ]);
    });
    MyDB().getBox().put(box, list);
  }

  void saveVocabularyRecordProgress(String path) {
    if (path != null) {
      print('saveVocabularyRecordProgress');
      path = path.substring(1);
      VocabularyRecordProgress recordProgress =
          new VocabularyRecordProgress(path);
      saveProg(MyResource.NOTEPADS, path);
      Day day = ProgressUtil()
          .createDay(null, null, null, null, null, recordProgress, null);
      ProgressUtil().updateDayList(day);
      print(recordProgress);
    }
  }

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
    checkPermissions().then((value) {
      print("process complete");
    });
    initTimer();
    super.initState();
  }

  void initTimer() {
    ExerciseTime time = MyDB()
        .getBox()
        .get(MyResource.VOCABULARY_TIME_KEY, defaultValue: ExerciseTime(3));
    _time.value = time.time * 60;
    _startTime = time.time;

    startTimer();
    AnalyticService.screenView('note_voice_page');
  }

  RxBool isActive = false.obs;
  void startTimer() async {
    print('startTimer');
    if (_timer == null || !_timer.isActive) {
      isActive.toggle();
      _timer = Timer.periodic(
          1.seconds,
          (Timer timer) => setState(() async {
                if (_time.value < 1) {
                  final _audioPlayer = AudioPlayer();
                  await _audioPlayer.setAsset("assets/audios/success.mp3");
                  await _audioPlayer.play();
                  _timer.cancel();
                  Future.microtask(() => stop());
                  OrderUtil().getRouteById(3).then((value) {
                    Get.off(value);
                  });
                } else {
                  _time.value--;
                }
              }));
    } else if (_timer != null && _timer.isActive) {
      isActive.toggle();
      _timer.cancel();
    }
  }

  Future<void> checkPermissions() async {
    bool res = await getPermissions();
    if (res) {
      await _prepare();
    }
  }

  Future<void> _prepare() async {
    await _init();
    var result = await _recorder.current();
    _recording = result;
  }

  Future _init() async {
    _recorder = FlutterAudioRecorder(await _localPath,
        audioFormat: AudioFormat.AAC, sampleRate: 22050);
    await _recorder.initialized;
    Recording rec = await _recorder.current();
    print(rec.path);
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width, // match parent(all screen)
          decoration:
              BoxDecoration(gradient: AppColors.Bg_Gradient_Timer_Diary),
          child: Container(
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    child: Image.asset(
                      'assets/images/timer/clouds_timer.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Spacer(),
                    buildTimerProgress(),
                    const SizedBox(height: 20),
                    buildTextProgress(),
                    Spacer(),
                    // Старые кнопки
                    // playPauseMic(),
                    buildMic(),
                    const SizedBox(height: 10),
                    buildTextMic(),
                    // Анимация в новом дизайне не испольузется
                    // buildRecordAnim(),
                    Spacer(),
                    buildMenuButtons(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRecordAnim() {
    return Obx(() => Container(
          width: Get.width / 2.2,
          height: 53,
          child: Visibility(
            child: LineBox(lines: 21),
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: isRecording.value,
          ),
        ));
  }

  // Widget playPauseMic() {
  //   return Container(
  //     padding: EdgeInsets.only(top: Get.height / 17),
  //     child: PlayerColumn(() async {
  //       if (_timer != null && _timer.isActive) {
  //         _timer.cancel();
  //       }
  //       await stop();
  //     }, () async {
  //       await playPause();
  //     }, () async {
  //       await stop();
  //     }),
  //   );
  // }

  Widget buildTextMic() {
    return Obx(() => Text(
        isRecording.isTrue ? 'go_stop_record'.tr : 'go_start_record'.tr,
        style: TextStyle(fontSize: Get.height * 0.015, color: Colors.white)));
  }

  Widget buildTextProgress() {
    return Obx(() => Text(StringUtil.createTimeString(_time.value),
        style: TextStyle(
            fontSize: Get.height * 0.033,
            fontWeight: FontWeight.w600,
            color: Colors.white)));
  }

  Widget buildTimerProgress() {
    return Padding(
      padding: const EdgeInsets.only(top: 54.0, bottom: 16),
      child: Obx(
        () => CircularPercentIndicator(
          radius: Get.height * 0.24,
          lineWidth: 20.0,
          animation: false,
          percent: createValue(),
          center: TimerCircleButton(
            child: Icon(
              isActive.isTrue ? Icons.pause : Icons.play_arrow,
              size: 40,
              color: AppColors.VIOLET,
            ),
            onPressed: startTimer,
          ),
          circularStrokeCap: CircularStrokeCap.round,
          linearGradient: AppColors.Progress_Gradient_Timer_Diary,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget buildMic() {
    return CupertinoButton(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(SvgAssets.microphone),
            ),
            Positioned(
              right: 13,
              child: Container(
                  child: Obx(() => Icon(
                      isRecording.isTrue ? Icons.stop : Icons.play_arrow,
                      color: AppColors.primary,
                      size: 10)),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        onPressed: () async {
          await playPause();
        });
  }

  Widget buildMenuButtons() {
    double btnSize = 30;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          color: Colors.white),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CupertinoButton(
                child: SvgPicture.asset(
                  SvgAssets.home,
                  width: btnSize,
                  height: btnSize,
                ),
                onPressed: () {
                  _timer?.cancel();
                  stop();
                  AppRouting?.navigateToHomeWithClearHistory();
                }),
            CupertinoButton(
                child: SvgPicture.asset(
                  SvgAssets.forward,
                  width: btnSize,
                  height: btnSize,
                ),
                onPressed: () async {
                  _timer?.cancel();
                  await stop();
                  OrderUtil().getRouteById(TimerPageId.Diary).then(
                    (value) {
                      Get.off(TimerSuccessScreen(
                          () => Get.to(
                              widget.fromHomeMenu ? ProgressPage() : value),
                          MyDB()
                              .getBox()
                              .get(MyResource.VOCABULARY_TIME_KEY)
                              .time,
                          false));
                    },
                  );
                  appAnalitics.logEvent('first_dnevnik_next');
                }),
          ],
        ),
      ),
    );
  }

  RxDouble get createValue =>
      _startTime != null ? (1 - _time.value / (_startTime * 60)).obs : 0.obs;

  Future<bool> _onWillPop() async {
    if (_timer != null) {
      _timer.cancel();
    }

    await stop();
    return true;
  }
}
