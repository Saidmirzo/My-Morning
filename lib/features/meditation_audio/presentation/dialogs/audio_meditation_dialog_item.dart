import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/other.dart';

import '../../../../resources/colors.dart';
import '../../../../widgets/primary_circle_button.dart';

class AudioMeditationDialogItem extends StatefulWidget {
  final int id;
  final MeditationAudio audio;
  final bool isYoga;

  const AudioMeditationDialogItem({
    Key key,
    @required this.id,
    @required this.audio,
    this.isYoga = false,
  });

  @override
  _AudioMeditationDialogItemState createState() =>
      _AudioMeditationDialogItemState();
}

class _AudioMeditationDialogItemState extends State<AudioMeditationDialogItem> {
  MediationAudioController _audioController =
      Get.find<MediationAudioController>();

  bool playCached = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (widget.isYoga)
              _audioController.selectedItemIndex.value = widget.id;
            else
              _audioController.changeItem(widget.id);
            _audioController.bufIdSelected.value = widget.id;
          },
          child: Obx(
            () => Container(
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                  color: _audioController.bufIdSelected.value == widget.id
                      ? AppColors.audiuSelected
                      : Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(17))),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildAudioControlButton(),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        width: Get.width * 0.5,
                        child: StyledText(
                          widget.audio.name ?? '',
                          fontSize: 17,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    if (_audioController.currentPage.value == MenuItems.yoga)
                      Text(printDuration(
                          _audioController.audioSource[widget.id].duration,
                          h: false)),
                    if (_audioController.playingIndex.value == widget.id &&
                        _audioController.isAudioLoading.value)
                      _buildLoadingAudioIndicator(),
                    buildFavoriteButton()
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFavoriteButton() {
    return CupertinoButton(
        child: Obx(() => Icon(
              _audioController.favoriteAudios.value.contains(widget.audio)
                  ? Icons.star_outlined
                  : Icons.star_border,
              color: AppColors.primary,
            )),
        onPressed: () {
          _audioController.setAudioFavorite(widget.audio);
        });
  }

  Widget _buildAudioControlButton() {
    return PrimaryCircleButton(
      onPressed: () => _handlePlayPauseButton(),
      bgColor: AppColors.primary,
      icon: Icon(
        _audioController.playingIndex.value == widget.id
            ? Icons.pause
            : Icons.play_arrow,
        color: AppColors.WHITE,
        size: 30,
      ),
    );
  }

  Container _buildLoadingAudioIndicator() {
    return Container(
      height: 30,
      width: 30,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.VIOLET),
      ),
    );
  }

  void _handlePlayPauseButton() async {
    print('playIndex ${_audioController.playingIndex.value} == ${widget.id}');
    if (_audioController.playingIndex.value == widget.id) {
      await _audioController.bfPlayer.value.pause();
      _audioController.playingIndex.value = -1;
    } else {
      _playNewTrack(widget.audio);
    }
  }

  void _playNewTrack(MeditationAudio track) async {
    _audioController.playingIndex.value = widget.id;
    _audioController.isAudioLoading.value = true;
    final _cachedAudioFile = await getCachedAudioFile(track);
    if (_cachedAudioFile == null) {
      playCached = false;
      await _audioController.bfPlayer.value.setUrl(track.url);
      print('Play from url ${track.url}, isFile cached = $playCached');
    } else {
      playCached = true;
      final _filePath = _cachedAudioFile.path;
      await _audioController.bfPlayer.value.setFilePath(_filePath);
      print('Play from path $_filePath, isFile cached = $playCached');
    }
    _audioController.bfPlayer.value.play();

    _audioController.isAudioLoading.value = false;
  }

  Future<File> getCachedAudioFile(
    MeditationAudio track,
  ) async {
    MeditationAudio audioFile = _audioController.audioSource
        .firstWhere((element) => element == track, orElse: () => null);
    if (audioFile?.filePath != null) {
      return File(audioFile.filePath);
    } else {
      var fl = await _audioController.cacheAudioFile(track);
      return fl != null ? File(fl.filePath) : null;
    }
  }
}
