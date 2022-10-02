// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/features/fitness/domain/entities/exercise/fitness_exercise.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/controller/timer_controller.dart';
import 'package:morningmagic/features/fitness/presentation/pages/fitness_main_page.dart';
import 'package:morningmagic/features/fitness/presentation/pages/fitness_success_page.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/timer.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

class ExercisePage extends StatefulWidget {
  final FitnessExercise exercise;
  final String progName;

  const ExercisePage(this.progName, this.exercise, {Key key}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage>
    with TickerProviderStateMixin {
  GifController _gifController;
  final FitnessController _fitnessController = Get.find();
  AudioPlayer _audioPlayer;

  Rx<FitnessExercise> exercise;
  TimerFitnesController cTimer;

  @override
  void dispose() {
    dispGif();
    cTimer.cancelTimer();
    super.dispose();
  }

  @override
  void initState() {
    exercise = widget.exercise.obs;
    _gifController = GifController(vsync: this, duration: 2.seconds);
    cTimer = Get.put(TimerFitnesController(
      _gifController,
      (_fitnessController?.selectedProgram?.exercises?.length ?? 0),
      DateTime.now().toString(),
      onDone: onDoneTimer,
    ));
    cTimer.progName = widget.progName;
    super.initState();
  }

  void initAudioAndPlay(String url) async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setUrl(url);
  }

  void onDoneTimer() async {
    if (_fitnessController.step !=
        _fitnessController.selectedProgram.exercises.length - 1) {
      Get.to(() => FitnessSuccessPage(
          onNext: () async {
            Get.back();
            _onNext();
          },
        ));
    } else {
      _onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          decoration:
              const BoxDecoration(gradient: AppColors.Bg_Gradient_Timer_Fitnes),
          child: Obx(() {
            print('Rebuild exercise page');
            cTimer.exerciseCount =
                _fitnessController?.selectedProgram?.exercises?.length ?? 0;
            cTimer?.exerciseName = exercise.value.name;
            _audioRes = exercise.value.audioRes;
            if (_audioRes != null) {
              initAudioAndPlay(_audioRes);
            }
            return Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Positioned(bottom: 0, child: bg()),
                if (exercise.value.imageRes != null)
                  Positioned(top: 100, child: img()),
                SizedBox(
                  width: Get.width,
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      children: <Widget>[
                        title(),
                        subtitle(),
                        const Spacer(
                          flex: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21),
                          child: timerWithNavigation(),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 31),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: Colors.white,
                            ),
                            width: double.maxFinite,
                            child: SingleChildScrollView(
                              child: Text(
                                exercise.value.description,
                                style: const TextStyle(
                                  color: Color(0xff592F72),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 31,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget timerWithNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PrimaryCircleButton(
          icon:
              const Icon(Icons.arrow_back, color: AppColors.primary, size: 18),
          onPressed: () async {
            await _onPrev();
          },
        ),
        TimerFitnes(exerciseName: exercise.value.name),
        PrimaryCircleButton(
          icon: const Icon(Icons.arrow_forward,
              color: AppColors.primary, size: 18),
          onPressed: () async {
            await _onNext();
          },
        ),
      ],
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 31, vertical: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              _audioPlayer.stop();
              cTimer.cancelTimer();
              Get.delete<TimerFitnesController>();
              //dispose();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FitnessMainPage()),
              );

              //////////////////////////////////////////////////////////////////////////////
            },
            child: const Icon(
              Icons.west,
              size: 30,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 30,
              child: FittedBox(
                child: Text(
                  exercise.value.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Get.height * 0.03,
                    fontWeight: FontWeight.w600,
                    color: AppColors.WHITE,
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => GestureDetector(
              child: Icon(
                isAudioActive.value ? Icons.volume_off : Icons.volume_up,
                size: 30,
                color: Colors.white,
              ),
              onTap: () {
                playPauseAudio();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget subtitle() {
    return Text(
      (cTimer?.isExDone?.value ?? false) ? 'exercise_complete'.tr : '',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: Get.height * 0.023,
        fontWeight: FontWeight.w500,
        color: AppColors.WHITE,
      ),
    );
  }

  Widget bg() {
    return Image.asset('assets/images/fitnes/ex/clouds.png', width: Get.width);
  }

  Widget img() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/images/fitnes/ex/exp_shape.png',
            height: Get.height / 3.5),
        exercise.value.imageRes.split('.').last.contains('gif')
            ? GifImage(
                controller: _gifController,
                image: AssetImage(exercise.value.imageRes),
                height: Get.height / 4.16,
              )
            : Image.asset(exercise.value.imageRes, height: Get.height / 4.16),
      ],
    );
  }

  Future<bool> _onWillPop() async {
    _fitnessController.step = 0;
    _disposeServices();
    return true;
  }

  String _audioRes;
  RxBool isAudioActive = true.obs;
  Future<void> playPauseAudio() async {
    isAudioActive.toggle();
    if (isAudioActive.isTrue) {
      print('Останавливаем аудио');
      await _audioPlayer.pause();
      // isAudioActive.value = false;
    } else {
      if (_audioRes != null) {
        print('Запускаем аудио');
        if (!_audioPlayer.playing) await _audioPlayer.play();
        // isAudioActive.value = true;
      }
    }
  }

  Future<void> _onNext() async {
    print('_onNext');
    // if (cTimer.isRuning.value) cTimer.startStopTimer();
    cTimer.cancelTimer();
    dispGif();
    _disposeServices();
    _fitnessController.incrementStep();
    final _exercise = _fitnessController.currentExercise;
    print('_onNext 2');
    if (_exercise != null) {
      print('_onNext 3');
      if (cTimer?.isExDone?.value ?? false) cTimer.startStopTimer();
      cTimer?.isExDone?.value = false;
      exercise.value = _exercise;
    } else {
      print('_onNext 4');
      _fitnessController.step = 0;
      AppRouting.replace(FitnessSuccessPage(
          countProgram: _fitnessController.selectedProgram.exercises.length));
      appAnalitics.logEvent('first_fitnes_next');
      Get.delete<TimerFitnesController>();
    }

    print(
        "------------------------------------------------------------ start ${_audioPlayer.audioSource} ------------------------------------------------------");
    try {
      await _audioPlayer.setAsset(exercise.value.audioRes);
    } catch (e) {
      print(e);
    }

    print(
        "------------------------------------------------------------ end ${_audioPlayer.audioSource} ------------------------------------------------------");
    // if (!isAudioActive.value) {
    isAudioActive.value = true;
    print(
        "------------------------------------------------------ ${isAudioActive.value}");
    // }
  }

  Future<void> _onPrev() async {
    print('_onPrev');
    dispGif();
    cTimer?.isExDone?.value = false;
    _disposeServices();
    _fitnessController.dicrementStep();
    final _exercise = _fitnessController.prevExercise;
    if (_exercise != null) {
      exercise.value = _exercise;
    } else {
      _fitnessController.step = 0;
      Get.off(() => const FitnessMainPage(pageId: TimerPageId.Fitness));
    }
    try {
      await _audioPlayer.setAsset(exercise.value.audioRes);
    } catch (e) {
      print(e);
    }
    if (!isAudioActive.value) {
      print(
          "--------------------------------------------------------------------------------------------------------------");
      isAudioActive.value = true;
    }
  }

  void dispGif() {
    _gifController?.stop();
    _gifController?.dispose();
    _gifController = GifController(vsync: this, duration: 2.seconds);
    cTimer?.gifController = _gifController;
  }

  void _disposeServices() async {
    cTimer?.cancelTimer();
    await _audioPlayer?.stop();
    await _audioPlayer?.dispose();
    isAudioActive.value = false;
  }
}
