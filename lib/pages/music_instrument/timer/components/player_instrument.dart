import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/instruments_audio/controllers/instruments_audio_controller.dart';
import 'package:morningmagic/pages/music_instrument/components/dialog_play_list.dart';
import 'package:morningmagic/pages/music_instrument/property.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/services/timer_service.dart';

Widget instrumentPlayer(
    {InstrumentAudioController audioController,
    TimerService timerService,
    bool fromTimer = false}) {
  return Container(
    height: 39,
    decoration: BoxDecoration(
        color: AppColors.purchaseDesc, borderRadius: BorderRadius.circular(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (!fromTimer)
          _playButton(SvgAssets.time,
              onPress: () => setTimePeriod(timerService)),
        Obx(
          () => _playButton(
              audioController.audioSourse.isEmpty
                  ? SvgAssets.play
                  : audioController.isPause == false
                      ? SvgAssets.pause
                      : SvgAssets.play, onPress: () {
            playPause();
            timerService.startTimer();
          }),
        ),
        Stack(
          children: [
            _playButton(
              SvgAssets.playList,
              onPress: () => onShowPlayList(
                dilaogPlayList(fromTimer: fromTimer),
              ),
            ),
            Obx(
              () => Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                    child: Text(
                      '${audioController.audioSourse.isEmpty ? '' : audioController.audioSourse.length}',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (!fromTimer)
          Obx(
            () => _playButton(
              SvgAssets.next,
              onPress: audioController.audioSourse.isNotEmpty
                  ? () => gotToTimerPage(timerService)
                  : () {},
            ),
          ),
      ],
    ),
  );
}

Widget _playButton(String icon, {Function() onPress}) {
  return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: onPress,
      child: SvgPicture.asset(
        icon,
        height: 18,
        width: 18,
      ));
}
