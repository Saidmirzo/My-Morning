import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/pages/meditation/timer/meditation_timer_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/storage.dart';
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
  _AudioMeditationDialogItemState createState() => _AudioMeditationDialogItemState();
}

class _AudioMeditationDialogItemState extends State<AudioMeditationDialogItem> {
  MediationAudioController _audioController = Get.find<MediationAudioController>();

  bool lock;
  bool playCached = false;

  @override
  void initState() {
    if (billingService.isPro())
      lock = false;
    else
      lock = widget.id <= 1 ? false : true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            selIndexNightYoga = widget.id;
            if (widget.isYoga)
              _audioController.selectedItemIndex.value = lock ? 0 : widget.id;
            else
              _audioController.changeItem(widget.id);
            _audioController.bufIdSelected.value = widget.id;

            Get.to(MeditationTimerPage(fromAudio: true, fromHomeMenu: true));
          },
          child: Obx(
            () => Container(
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: _audioController.bufIdSelected.value == widget.id
                    ? menuState == MenuState.MORNING
                        ? AppColors.audiuSelected
                        : Color(0xFF11123F)
                    : Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(17),
                ),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    menuState == MenuState.MORNING ? _buildAudioControlButton(lock) : _buildAudioControlNightButton(lock),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        width: Get.width * 0.5,
                        child: StyledText(
                          widget.audio.name ?? '',
                          fontSize: 17,
                          color: menuState == MenuState.MORNING ? AppColors.primary : Color(0xFFBEBFE7),
                        ),
                      ),
                    ),
                    if (_audioController.currentPage.value == MenuItems.yoga || _audioController.currentPage.value == MenuItems.meditationNight)
                      Text(
                        printDuration(_audioController.audioSource[widget.id].duration, h: false),
                        style: TextStyle(color: menuState == MenuState.MORNING ? AppColors.primary : Color(0xFFBEBFE7)),
                      ),
                    if (_audioController.playingIndex.value == widget.id && _audioController.isAudioLoading.value) _buildLoadingAudioIndicator(),
                    // menuState == MenuState.MORNING ? buildFavoriteButton() : buildFavoriteButtonNight(lock)
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
        child: Obx(() => Icon(_audioController.favoriteAudios.value.contains(widget.audio) ? Icons.star_outlined : Icons.star_border, color: AppColors.primary)),
        onPressed: () {
          _audioController.setAudioFavorite(widget.audio);
        });
  }

  Widget buildFavoriteButtonNight(bool lock) {
    return CupertinoButton(
        child: Obx(() => Icon(
              _audioController.favoriteAudios.value.contains(widget.audio)
                  ? lock
                      ? Icons.lock
                      : Icons.star_outlined
                  : lock
                      ? Icons.lock
                      : Icons.star_border,
              color: AppColors.purchaseDesc,
            )),
        onPressed: lock
            ? null
            : () {
                _audioController.setAudioNightFavorite(widget.audio);
              });
  }

  Widget _buildAudioControlButton(bool lock) {
    return PrimaryCircleButton(
      onPressed: lock == false ? () => _handlePlayPauseButton() : null,
      bgColor: AppColors.primary,
      icon: Icon(
        _audioController.playingIndex.value == widget.id ? Icons.pause : Icons.play_arrow,
        color: AppColors.WHITE,
        size: 30,
      ),
    );
  }

  Widget _buildAudioControlNightButton(bool lock) {
    return PrimaryCircleButton(
      onPressed: lock == false ? () => _handlePlayPauseButton() : null,
      bgColor: AppColors.purchaseDesc,
      icon: Icon(
        _audioController.playingIndex.value == widget.id ? Icons.pause : Icons.play_arrow,
        color: Color(0xFF040826),
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
    MeditationAudio audioFile = _audioController.audioSource.firstWhere((element) => element == track, orElse: () => null);
    if (audioFile?.filePath != null) {
      return File(audioFile.filePath);
    } else {
      var fl = await _audioController.cacheAudioFile(track);
      return fl != null ? File(fl.filePath) : null;
    }
  }
}
