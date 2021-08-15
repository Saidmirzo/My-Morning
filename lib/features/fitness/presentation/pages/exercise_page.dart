import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
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
import 'package:sliding_sheet/sliding_sheet.dart';

class ExercisePage extends StatefulWidget {
  final FitnessExercise exercise;
  final String progName;

  const ExercisePage(this.progName, this.exercise);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage>
    with TickerProviderStateMixin {
  GifController _gifController;
  FitnessController _fitnessController = Get.find<FitnessController>();
  AudioPlayer _audioPlayer;
  Rx<FitnessExercise> exercise;
  TimerFitnesController cTimer;

  @override
  void initState() {
    exercise = widget.exercise.obs;
    _gifController = GifController(vsync: this, duration: 2.seconds);
    cTimer = Get.put(TimerFitnesController(_gifController));
    cTimer.progName = widget.progName;
    super.initState();
  }

  void initAudioAndPlay(String url) async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setUrl(url);
    // if (isAudioActive.isTrue) _audioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          decoration:
              BoxDecoration(gradient: AppColors.Bg_Gradient_Timer_Fitnes),
          child: Obx(() {
            print('Rebuild exercise page');
            cTimer?.exerciseName = exercise.value.name;
            _audioRes = exercise.value.audioRes;
            if (_audioRes != null) {
              initAudioAndPlay(_audioRes);
            }
            return SlidingSheet(
              elevation: 5,
              cornerRadius: 16,
              snapSpec: SnapSpec(
                // Enable snapping. This is true by default.
                snap: true,
                // Set custom snapping points.
                snappings: [0.15, 0.5],
                // Define to what the snappings relate to. In this case,
                // the total available space that the sheet can expand to.
                positioning: SnapPositioning.relativeToAvailableSpace,
              ),
              body: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Positioned(bottom: 0, child: bg()),
                  if (exercise.value.imageRes != null)
                    Positioned(top: Get.height * 0.1, child: img()),
                  Container(
                    width: Get.width,
                    child: SafeArea(
                        bottom: false,
                        child: Column(
                          children: <Widget>[
                            title(),
                            subtitle(),
                            Spacer(),
                            timerWithNavigation(),
                            SizedBox(height: Get.height * 0.15)
                          ],
                        )),
                  ),
                ],
              ),
              builder: (context, state) {
                return ConstrainedBox(
                  constraints: new BoxConstraints(
                    minHeight: Get.height,
                  ),
                  child: Container(
                    // height: Get.height,
                    padding: const EdgeInsetsDirectional.only(bottom: 50),
                    child: exDesc(),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }

  Widget timerWithNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PrimaryCircleButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 18),
          onPressed: _onPrev,
        ),
        TimerFitnes(exerciseName: exercise.value.name),
        PrimaryCircleButton(
          icon: Icon(Icons.arrow_forward, color: AppColors.primary, size: 18),
          onPressed: _onNext,
        ),
      ],
    );
  }

  Widget exDesc() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(50)),
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (exercise.value.audioRes != null)
                Obx(() => CupertinoButton(
                    child: Icon(
                        isAudioActive.isTrue
                            ? Icons.volume_up
                            : Icons.volume_off,
                        size: 30,
                        color: AppColors.primary),
                    onPressed: () {
                      playPauseAudio();
                    })),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  exercise.value.description,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.VIOLET,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container title() {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 20),
      child: Text(
        exercise.value.name,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Get.height * 0.03,
          fontWeight: FontWeight.w600,
          color: AppColors.WHITE,
        ),
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
        Image.asset('assets/images/fitnes/ex/exp_shape.png', width: Get.width),
        exercise.value.imageRes.split('.').last.contains('gif')
            ? GifImage(
                controller: _gifController,
                image: AssetImage(exercise.value.imageRes),
              )
            : Image.asset(exercise.value.imageRes, height: Get.width / 1.7),
      ],
    );
  }

  Future<bool> _onWillPop() async {
    _fitnessController.step = 0;
    _disposeServices();
    return true;
  }

  String _audioRes;
  RxBool isAudioActive = false.obs;
  void playPauseAudio() async {
    if (isAudioActive.isTrue) {
      print('Останавливаем аудио');
      await _audioPlayer.pause();
      isAudioActive.value = false;
    } else {
      if (_audioRes != null) {
        print('Запускаем аудио');
        if (!_audioPlayer.playing) await _audioPlayer.play();
        isAudioActive.value = true;
      }
    }
  }

  void _onNext() async {
    print('_onNext');
    dispGif();
    _disposeServices();
    _fitnessController.incrementStep();
    final _exercise = _fitnessController.currentExercise;
    if (_exercise != null) {
      cTimer?.isExDone?.value = false;
      exercise.value = _exercise;
    } else {
      _fitnessController.step = 0;
      AppRouting.replace(FitnessSuccessPage(
          countProgram: _fitnessController.selectedProgram.exercises.length));
      appAnalitics.logEvent('first_fitnes_next');
    }
  }

  void _onPrev() async {
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
      Get.off(FitnessMainPage(pageId: TimerPageId.Fitness));
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
