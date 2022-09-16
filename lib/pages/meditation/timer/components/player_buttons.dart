import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/storage.dart';

Widget buildPlayerControls(TimerService timerService) {
  MediationAudioController cAudio = Get.find();
  return Padding(
    padding: const EdgeInsets.only(top: 48.0, bottom: 16),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CupertinoButton(
              onPressed: () async {
                if (cAudio.player.playing) {
                  timerService.startTimer();
                }
                await cAudio.prev();
                timerService.setTime(
                  cAudio.player.duration.inSeconds,
                );
              },
              child: const Icon(
                Icons.skip_previous_rounded,
                size: 50,
                color: Colors.white,
              ),
            ),
            Flexible(
              child: Obx(
                () => Text(
                  cAudio.currAudioName.value,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: menuState == MenuState.MORNING
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
            ),
            CupertinoButton(
              onPressed: () async {
                // cAudio.audioSource.clear();
                if (cAudio.player.playing) {
                  timerService.startTimer();
                }
                await cAudio.next();
                timerService.setTime(
                  cAudio.player.duration.inSeconds,
                );
                // print("------------------------------------------------------------------------------------------------ ${cAudio.audioSource.toSet().toList().length}");

                // print("------------------------ ${cAudio.audioSource} ---------------------");
                // print(" ----------------------------------------------------------- ${cAudio.currAudioName} ----------------------------------------------");
              },
              child: const Icon(
                Icons.skip_next_rounded,
                size: 50,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
