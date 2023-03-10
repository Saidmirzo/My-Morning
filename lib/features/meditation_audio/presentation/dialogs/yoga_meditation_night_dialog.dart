import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/audio_meditation_dialog_item.dart';

class YogaMeditationNightContainer extends StatefulWidget {
  const YogaMeditationNightContainer({Key key}) : super(key: key);

  @override
  _YogaMeditationNightContainerState createState() =>
      _YogaMeditationNightContainerState();
}

class _YogaMeditationNightContainerState
    extends State<YogaMeditationNightContainer> with WidgetsBindingObserver {
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
          id: index,
          audio: _source[index],
          isYoga: true,
        );
      },
    );
  }

  void _stopPlayer() {
    _audioController.bfPlayer.value.stop();
    _audioController.playingIndex.value = -1;
  }

  @override
  void initState() {
    _audioController = Get.find();
    _source.addAll(Get.locale.languageCode == 'ru'
        ? meditationAudioData.meditationNightRuSource
        : meditationAudioData.meditationNightEnSource);
    _audioController.changeAudioSource(_source);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _stopPlayer();
      _audioController.playFromFavorite = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
