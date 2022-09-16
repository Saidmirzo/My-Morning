import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/audio_meditation_dialog_item.dart';
import '../../../../services/timer_service.dart';

class MusicMeditationContainer extends StatefulWidget {
  final bool withBgSound;
  final TimerService timerService;
  const MusicMeditationContainer(
      {Key key, this.timerService, this.withBgSound = false})
      : super(key: key);

  @override
  _MusicMeditationContainerState createState() =>
      _MusicMeditationContainerState();
}

class _MusicMeditationContainerState extends State<MusicMeditationContainer>
    with WidgetsBindingObserver {
  MediationAudioController _audioController;
  final List<MeditationAudio> _source = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: _buildSelectAudioList(),
    );
  }

  Widget _buildSelectAudioList() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: _source.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return AudioMeditationDialogItem(
          isMeditation: false,
          timerService: widget.timerService,
          id: index,
          audio: _source[index],
        );
      },
    );
  }

  void _stopPlayer() {
    _audioController.bfPlayer.value.stop();
    _audioController.playingIndex.value = -1;
    if (!widget.withBgSound) _audioController.changeItem(0);
    _audioController.bufIdSelected(0);
  }

  @override
  void initState() {
    _source.addAll(meditationAudioData.musicSource);
    _audioController = Get.find();
    print('Init music container');
    _audioController.changeAudioSource(_source, isBgSource: widget.withBgSound);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _stopPlayer();
      _audioController.playFromFavorite = false;
    });
  }
}
