import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/widgets/timer_circle_button.dart';

Widget buildPlayerControls() {
  MediationAudioController cAudio = Get.find();
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(top: 48.0, bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CupertinoButton(
                onPressed: cAudio.prev,
                child: Icon(
                  Icons.skip_previous_rounded,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              Obx(
                () => TimerCircleButton(
                  onPressed: cAudio.playOrPause,
                  child: Icon(
                    cAudio.isPlaying.value ? Icons.pause : Icons.play_arrow,
                    size: 40,
                    color: AppColors.VIOLET,
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: cAudio.next,
                child: Icon(
                  Icons.skip_next_rounded,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
              width: Get.width * 0.8,
              alignment: Alignment.center,
              child: Obx(() => Text(cAudio.currAudioName.value,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      color: menuState == MenuState.MORNING
                          ? Colors.black
                          : Colors.white)))),
        ],
      ),
    ),
  );
}
