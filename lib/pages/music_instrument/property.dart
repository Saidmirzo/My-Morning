import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/instruments_audio/controllers/instruments_audio_controller.dart';
import 'package:morningmagic/features/instruments_audio/data/instrument_audio_data.dart';
import 'package:morningmagic/pages/add_time_page/add_time_period.dart';
import 'package:morningmagic/pages/music_instrument/controllers/music_instrument_controllers.dart';
import 'package:morningmagic/pages/music_instrument/model/instrument_model.dart';
import 'package:morningmagic/pages/reading/timer/timer_page.dart';
import 'package:morningmagic/services/timer_service.dart';

Function() onInstrumentClick(
    Instrument instrument, MusicInstrumentControllers controllers) {
  InstrumentAudioController audioControlelr = Get.find();

  audioControlelr.playAudio(instrument);
}

Function() playPause() {
  InstrumentAudioController audioControlelr = Get.find();
  audioControlelr.playPause();
}

Function() onShowPlayList(Widget child) {
  Get.bottomSheet(child);
}

Function() gotToTimerPage(TimerService timerService) {
  Get.to(ReadingTimerPage());
}

Future setTimePeriod(TimerService timerService) async {
  await Get.to(AddTimePeriod(
    timerService: timerService,
    nightMode: true,
  ));

  print('time ${timerService.time.value}');
}
