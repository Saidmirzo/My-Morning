import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/audio_meditation_dialog_item.dart';

class AudioMeditationFavoriteContainer extends StatefulWidget {
  @override
  _AudioMeditationFavoriteContainerState createState() =>
      _AudioMeditationFavoriteContainerState();
}

class _AudioMeditationFavoriteContainerState
    extends State<AudioMeditationFavoriteContainer>
    with WidgetsBindingObserver {
  MediationAudioController _audioController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: _buildSelectAudioList(),
    );
  }

  Widget _buildSelectAudioList() {
    print(
        '_buildSelectAudioList: ${_audioController.favoriteAudios.value.length}');
    return Obx(() {
      return _audioController.isAudioLoading.value
          ? Center(child: CupertinoActivityIndicator())
          : _audioController.favoriteAudios.value.length == 0
              ? Center(child: Text('empty_favorite_list'.tr))
              : ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  itemCount: _audioController.favoriteAudios.value.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return AudioMeditationDialogItem(
                      id: index,
                      audio: _audioController.favoriteAudios.value[index],
                    );
                  },
                );
    });
  }

  void _stopPlayer() {
    _audioController.bfPlayer.value.stop();
    _audioController.playingIndex.value = -1;
    _audioController.playFromFavorite = true;
  }

  @override
  void initState() {
    super.initState();
    _audioController = Get.find();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _stopPlayer();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
