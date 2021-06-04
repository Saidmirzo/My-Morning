import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/resources/colors.dart';

import '../../../../resources/colors.dart';
import '../../../../widgets/primary_circle_button.dart';

class AudioMeditationDialogItem extends StatefulWidget {
  final int id;
  final MeditationAudio audio;

  const AudioMeditationDialogItem({
    Key key,
    @required this.id,
    @required this.audio,
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
          onTap: () => _audioController.selectedItemIndex.value = widget.id,
          child: Obx(
            () => Container(
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                  color: _audioController.selectedItemIndex.value == widget.id
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
                          widget.audio.id,
                          fontSize: 17,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    if (_audioController.playingIndex.value == widget.id &&
                        !playCached &&
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
        (_audioController.playingIndex.value == widget.id &&
                _audioController.isPlaying.value)
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
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.WHITE),
      ),
    );
  }

  void _handlePlayPauseButton() async {
    if (!_audioController.isPlaying.value) {
      final _oldPlayingIndex = _audioController.playingIndex.value;
      _audioController.playingIndex.value = widget.id;

      if (_audioController.playingIndex.value == -1 ||
          _oldPlayingIndex != widget.id) {
        _playNewTrack(widget.audio);
      } else
        await _audioController.player.play();
      _setIsPlayingState(!_audioController.isPlaying.value);
    } else {
      if (_audioController.playingIndex.value == widget.id) {
        await _audioController.player.pause();
        _setIsPlayingState(!_audioController.isPlaying.value);
      } else {
        _playNewTrack(widget.audio);
        _audioController.playingIndex.value = widget.id;
        _setIsPlayingState(true);
      }
    }
  }

  void _setIsPlayingState(bool newIsPlaying) {
    setState(() {
      _audioController.isPlaying.value = newIsPlaying;
    });
  }

  void _playNewTrack(MeditationAudio track) async {
    final _cachedAudioFile = await _audioController.getCachedAudioFile(track);
    if (_cachedAudioFile == null) {
      playCached = false;
      await _audioController.player.setUrl(track.url);
      print('Play from url ${track.url}, isFile cached = $playCached');
    } else {
      playCached = true;
      final _filePath = _cachedAudioFile.path;
      await _audioController.player.setFilePath(_filePath);
      print('Play from path $_filePath, isFile cached = $playCached');
    }
    _audioController.player.play();
  }
}
