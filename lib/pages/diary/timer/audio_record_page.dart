// ignore_for_file: avoid_print

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
import 'package:morningmagic/db/model/progress/diary_progress/diary_record_progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/progress/progress_page.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/services/progress.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:morningmagic/widgets/sound_waves_diagram/my/line_box.dart';
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
  final RxInt _time = 0.obs;
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

    print('statusMicrophone: $statusMicrophone');

    if (statusMicrophone.isPermanentlyDenied || statusMicrophone.isDenied) {
      print('request microphone permission');
      statusMicrophone = await Permission.microphone.request();
      print('statusMicrophone: $statusMicrophone');
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
    print('_startRecording    current : ${current.duration}');
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
    bool permission = await getPermissions();
    if (!permission) return;
    if (_recording == null) {
      await _prepare();
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
    await startTimer();
  }

  Future<void> stop() async {
    if (_recording == null) {
      return;
    }
    switch (_recording.status) {
      case RecordingStatus.Recording:
        {
          await _stopRecording();
          saveDiaryRecordProgress(_recording.path, true);
          print("STOP RECORDING !!!!!!!!!!!!!!!!");
          break;
        }
      case RecordingStatus.Paused:
        {
          await _stopRecording();
          saveDiaryRecordProgress(_recording.path, true);
          print("STOP RECORDING !!!!!!!!!!!!!!!!");
          break;
        }
      default:
        break;
    }
  }

  int passedSec = 0;
  void saveDiaryRecordProgress(String path, bool isSkip) {
    if (path != null) {
      print('saveDiaryRecordProgress');
      path = path.substring(1);
      var model = DiaryRecordProgress(path, passedSec, isSkip);
      ProgressController pg = Get.find();
      pg.saveDiaryJournal(model);
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
    passedSec = 0;
    // checkPermissions().then((value) {
    //   print("process complete");
    // });
    // // initTimer();
    // if (!isRecording.value) {
    //   _startRecording();
    // }
    ExerciseTime time = MyDB()
        .getBox()
        .get(MyResource.DIARY_TIME_KEY, defaultValue: ExerciseTime(3));
    _startTime = time.time;
    _time.value = time.time * 60;
    super.initState();
  }

  void initTimer() {
    ExerciseTime time = MyDB()
        .getBox()
        .get(MyResource.DIARY_TIME_KEY, defaultValue: ExerciseTime(3));
    _time.value = 0;
    _startTime = 0;
    _time.value = time.time * 60;
    _startTime = time.time;

    startTimer();
    AnalyticService.screenView('note_voice_page');
  }

  RxBool isActive = false.obs;
  Future<void> startTimer() async {
    print('startTimer');
    if (_timer == null || !_timer.isActive) {
      isActive.toggle();
      _timer = Timer.periodic(
          1.seconds,
          (Timer timer) => setState(() {
                if (_time.value < 1) {
                  final _audioPlayer = AudioPlayer();
                  _audioPlayer.setAsset("assets/audios/success.mp3");
                  _audioPlayer.play();
                  _timer.cancel();
                  Future.microtask(() => stop());
                  OrderUtil().getRouteById(3).then((value) {
                    Get.off(() => value);
                  });
                } else {
                  _time.value--;
                  passedSec++;
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
      // await _prepare();
      // await _startRecording();
      // await startTimer();
    } else {
      // await getPermissions();
      print('permissions not allowed');
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

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width, // match parent(all screen)
          decoration:
              const BoxDecoration(gradient: AppColors.Bg_Gradient_Timer_Diary),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: SizedBox(
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
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (() => Navigator.pop(context)),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 37),
                            child: Icon(
                              Icons.west,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 37),
                          child: GestureDetector(
                            onTap: (() {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TimerRecordPage()),
                              );
                            }),
                            child: Image.asset(
                              'assets/images/replay.png',
                              width: 16.3,
                              height: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 54.0, bottom: 16),
                    child: Obx(
                      () => CircularPercentIndicator(
                        radius: Get.height * 0.24,
                        lineWidth: 20.0,
                        animation: false,
                        percent: createValue(),
                        center: isLoading == true
                            ? CupertinoButton(
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                          SvgAssets.microphone),
                                    ),
                                    Positioned(
                                      right: 13,
                                      child: Container(
                                          child: Obx(() => Icon(
                                              isRecording.isTrue
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              color: AppColors.primary,
                                              size: 10)),
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.white,
                                          )),
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  await playPause();
                                })
                            : buildLoading(),

                        // TimerCircleButton(
                        //   child: Icon(
                        //     isActive.isTrue ? Icons.pause : Icons.play_arrow,
                        //     size: 40,
                        //     color: AppColors.VIOLET,
                        //   ),
                        //   onPressed: startTimer,
                        // ),
                        circularStrokeCap: CircularStrokeCap.round,
                        linearGradient: AppColors.Progress_Gradient_Timer_Diary,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildTextProgress(),
                  const Spacer(),
                  // Старые кнопки
                  // playPauseMic(),
                  //buildMic(),
                  const SizedBox(height: 10),
                  buildTextMic(),
                  // Анимация в новом дизайне не испольузется
                  // buildRecordAnim(),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      _timer?.cancel();
                      await stop();
                      OrderUtil().getRouteById(TimerPageId.Diary).then(
                        (value) {
                          Get.off(() => TimerSuccessScreen(
                              () => Get.to(() => widget.fromHomeMenu
                                  ? const ProgressPage()
                                  : value),
                              MyDB()
                                  .getBox()
                                  .get(MyResource.DIARY_TIME_KEY)
                                  .time,
                              false,
                              1));
                        },
                      );
                      appAnalitics.logEvent('first_dnevnik_next');
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 33),
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            color: const Color(0xff592F72),
                          ),
                          child: Center(
                            child: Text(
                              'Save note'.tr,
                              style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  )
                  // buildMenuButtons(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoading() => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 2),
        child: SizedBox(
            height: 94,
            child: Center(
                child: SizedBox(
              width: 36,
              height: 36,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.VIOLET),
              ),
            ))),
      );

  Widget buildRecordAnim() {
    return Obx(() => SizedBox(
          width: Get.width / 2.2,
          height: 53,
          child: Visibility(
            child: const LineBox(lines: 21),
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
        isRecording.isTrue ? 'Recording in progress'.tr : 'Recording paused'.tr,
        style: TextStyle(fontSize: Get.height * 0.015, color: Colors.white)));
  }

  Widget buildTextProgress() {
    return Obx(() => Text(StringUtil.createTimeString(_time.value),
        style: TextStyle(
            fontSize: Get.height * 0.033,
            fontWeight: FontWeight.w600,
            color: Colors.white)));
  }

  Widget buildMenuButtons() {
    double btnSize = 30;
    return Container(
      decoration: const BoxDecoration(
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
                      Get.off(() => TimerSuccessScreen(
                          () => Get.to(() => widget.fromHomeMenu
                              ? const ProgressPage()
                              : value),
                          MyDB().getBox().get(MyResource.DIARY_TIME_KEY).time,
                          false,
                          1));
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
      _startTime != null ? (1 - _time.value / (_startTime * 60)).obs : 0.0.obs;

  Future<bool> _onWillPop() async {
    if (_timer != null) {
      _timer.cancel();
    }

    await stop();
    return true;
  }
}
