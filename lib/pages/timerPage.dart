import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/services/analyticService.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/services/notifications.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/widgets/animatedButton.dart';
import 'package:morningmagic/widgets/circular_progress_bar/circular_progress_bar.dart';
import 'package:screen/screen.dart';

import '../features/meditation_audio/data/repositories/audio_repository_impl.dart';
import '../resources/colors.dart';
import '../utils/string_util.dart';
import '../widgets/customText.dart';

class TimerPage extends StatefulWidget {
  final int pageId;

  const TimerPage({Key key, @required this.pageId}) : super(key: key);

  @override
  State createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> with WidgetsBindingObserver {
  MediationAudioController _audioController;
  TimerService timerService = TimerService();
  AudioPlayer _audioPlayer;
  String titleText;
  List<AudioSource> _playList;
  bool isInitialized = false;
  int index = 0;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      timerService.onAppLeft();
    } else if (state == AppLifecycleState.resumed) {
      timerService.onAppResume();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.pageId == 1) {
      _audioController = Get.find();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await timerService.init(widget.pageId, _audioPlayer);
      if (widget.pageId == 5 && timerService.visualizationText != null)
        titleText = timerService.visualizationText;
    });

    // TODO make enum id for page
    if (widget.pageId == 1) {
      // meditation page
      initializeMeditationAudio();
      AnalyticService.screenView('meditation_timer_page');
    } else if (widget.pageId == 2) {
      print('таймер фитнес');
    } else if (widget.pageId == 4) {
      AnalyticService.screenView('reading_timer_page');
    } else if (widget.pageId == 5) {
      print('таймер визуализация');
    }
    try {
      Screen.keepOn(true);
    } catch (e) {
      log('Screen.keepOn : ' + e.toString());
    }
  }

  initializeMeditationAudio() async {
    _playList = _audioController.generateMeditationPlayList();

    await _audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
          children:
              List.generate(_playList.length, (index) => _playList[index])),
      initialIndex: _audioController.selectedItemIndex.value,
      initialPosition: Duration.zero,
    );

    await _audioPlayer.setLoopMode(LoopMode.one);
    _audioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    print('build timer page');
    if (!isInitialized) {
      isInitialized = true;
    }

    return WillPopScope(
      onWillPop: () async {
        if (widget.pageId == 1) {
          _audioPlayer.pause();
          _audioController.isPlaying.value = false;
        }
        return true;
      },
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: AppGradientContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (widget.pageId == 1)
                        Obx(() {
                          if (_audioController.isAudioLoading.value &&
                              !_audioController.isPlaylistAudioCached)
                            return _buildAudioLoading();
                          else
                            return _buildPlayerControls();
                        }),
                      Expanded(
                          child: Center(child: _buildTimerProgress(context))),
                      if (titleText != null) _buildTitleWidget(),
                      _buildMenuButtons(context),
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

  Widget _buildTimerProgress(BuildContext context) {
    double _timerSize, _textSize;
    _timerSize = MediaQuery.of(context).size.width * 0.7;
    _textSize = 55;

    return Padding(
      padding: const EdgeInsets.only(top: 54.0, bottom: 16),
      child: Container(
        width: _timerSize,
        child: CircularProgressBar(
          text: StringUtil.createTimeString(timerService.time),
          foregroundColor: Colors.white.withOpacity(0.8),
          backgroundColor: Colors.white.withOpacity(0.4),
          value: timerService.createValue,
          fontSize: _textSize,
        ),
      ),
    );
  }

  Widget _buildAudioLoading() {
    return Container(
        height: 92,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyledText(
              'audio_loading'.tr,
              fontSize: 16,
            ),
            SizedBox(
              width: 16,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.VIOLET),
            ),
          ],
        ));
  }

  Container _buildPlayerControls() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 48.0, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              color: Colors.transparent,
              elevation: 0,
              autofocus: false,
              hoverColor: AppColors.TRANSPARENT,
              highlightElevation: 0,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              onPressed: _prev,
              child: Icon(
                Icons.fast_rewind,
                size: 60,
                color: AppColors.VIOLET,
              ),
            ),
            RaisedButton(
              color: Colors.transparent,
              elevation: 0,
              autofocus: false,
              hoverColor: AppColors.TRANSPARENT,
              highlightElevation: 0,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              onPressed: _playOrPause,
              child: Icon(
                _audioPlayer.playing ? Icons.pause : Icons.play_arrow,
                size: 60,
                color: AppColors.VIOLET,
              ),
            ),
            RaisedButton(
              color: Colors.transparent,
              elevation: 0,
              autofocus: false,
              hoverColor: AppColors.TRANSPARENT,
              highlightElevation: 0,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              onPressed: _next,
              child: Icon(
                Icons.fast_forward,
                size: 60,
                color: AppColors.VIOLET,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Obx(() => AnimatedButton(() => timerService.startTimer(),
            timerService.buttonText.value.toString(), 15, null, null)),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: AnimatedButton(() {
            if (widget.pageId == 1) _audioPlayer.pause();
            timerService.skipTask();
          }, 'skip'.tr, 15, null, null),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: AnimatedButton(() {
            if (widget.pageId == 1) _audioPlayer.pause();
            timerService.goToHome();
          }, 'menu'.tr, 15, null, null),
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget _buildTitleWidget() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          width: MediaQuery.of(context).size.width * 3 / 4,
          child: CustomText(
            text: titleText,
            size: 22,
          ),
        ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }

  void _next() {
    final _playListLength = _playList.length;
    if (_playListLength == 0) return;
    int _nextIndex = 0;
    if (_audioPlayer.currentIndex + 1 >= _playListLength)
      _nextIndex = 0;
    else
      _nextIndex = _audioPlayer.currentIndex + 1;
    _audioPlayer.seek(Duration(seconds: 0), index: _nextIndex);
  }

  void _prev() {
    final _playListLength = _playList.length;
    if (_playListLength == 0) return;
    int _nextIndex = 0;
    if (_audioPlayer.currentIndex == 0)
      _nextIndex = _playListLength - 1;
    else
      _nextIndex = _audioPlayer.currentIndex - 1;
    _audioPlayer.seek(Duration(seconds: 0), index: _nextIndex);
  }

  void _playOrPause() {
    _audioPlayer.playing ? _audioPlayer.pause() : _audioPlayer.play();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    print('timerPage dispose');
    timerService.dispose();
  }

  @override
  void deactivate() {
    print('timerPage deactivate');
    super.deactivate();
  }
}
