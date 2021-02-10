import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/resources/colors.dart';

class AudioMeditationDialogItem extends StatefulWidget {
  final int id;
  final String trackId;

  const AudioMeditationDialogItem({
    Key key,
    @required this.id,
    @required this.trackId,
  });

  @override
  _AudioMeditationDialogItemState createState() =>
      _AudioMeditationDialogItemState();
}

class _AudioMeditationDialogItemState extends State<AudioMeditationDialogItem> {
  MediationAudioController _audioController =
      Get.find<MediationAudioController>();

  AudioPlayer _audioPlayer;
  bool playCached = false;

  @override
  Widget build(BuildContext context) {
    _audioPlayer = _audioController.audioPlayer.value;

    return Column(
      children: [
        InkWell(
          onTap: () => _audioController.selectedItemIndex.value = widget.id,
          child: Obx(
            () => Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: _audioController.selectedItemIndex.value == widget.id
                      ? AppColors.PINK
                      : AppColors.LIGHT_VIOLET,
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildAudioControlButton(),
                    SizedBox(width: 10),
                    StyledText(
                      widget.trackId,
                      fontSize: 17,
                      color: AppColors.WHITE,
                    ),
                    Spacer(),
                    if (_audioController.playingIndex.value == widget.id &&
                        !playCached &&
                        _audioController.isAudioLoading.value)
                      _buildLoadingAudioIndicator()
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container _buildAudioControlButton() {
    return Container(
      child: IconButton(
        onPressed: () => _handlePlayPauseButton(),
        icon: Icon(
          (_audioController.playingIndex.value == widget.id &&
                  _audioController.isPlaying)
              ? Icons.pause
              : Icons.play_arrow,
          color: Colors.white,
          size: 30,
        ),
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

  void _handlePlayPauseButton() {
    if (!_audioController.isPlaying) {
      final _oldPlayingIndex = _audioController.playingIndex.value;
      _audioController.playingIndex.value = widget.id;

      if (_audioController.playingIndex.value == -1 ||
          _oldPlayingIndex != widget.id) {
        _playNewTrack(widget.trackId);
      } else
        _audioPlayer.play();
      _setIsPlayingState(!_audioController.isPlaying);
    } else {
      if (_audioController.playingIndex.value == widget.id) {
        _audioPlayer.pause();
        _setIsPlayingState(!_audioController.isPlaying);
      } else {
        _playNewTrack(widget.trackId);
        _audioController.playingIndex.value = widget.id;
        _setIsPlayingState(true);
      }
    }
  }

  void _setIsPlayingState(bool newIsPlaying) {
    setState(() {
      _audioController.isPlaying = newIsPlaying;
    });
  }

  void _playNewTrack(String trackId) async {
    String _trackUrl = _audioController.getAudioUrl(trackId);
    final _cachedAudioFile = await _audioController.getCachedAudioFile(trackId);
    if (_cachedAudioFile == null) {
      playCached = false;
      await _audioPlayer.setUrl(_trackUrl);
      print('Play from url $_trackUrl, isFile cached = $playCached');
    } else {
      playCached = true;
      final _filePath = _cachedAudioFile.path;
      await _audioPlayer.setFilePath(_filePath);
      print('Play from path $_filePath, isFile cached = $playCached');
    }

    _audioPlayer.play();
  }
}
