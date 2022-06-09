import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/storage.dart';

Widget buildPlayerControls(TimerService timerService) {
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
              Flexible(
                child: Obx(() =>
                    Text(cAudio.currAudioName.value, textAlign: TextAlign.center, overflow: TextOverflow.clip, style: TextStyle(color: menuState == MenuState.MORNING ? Colors.black : Colors.white))),
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
        ],
      ),
    ),
  );
}
