import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

import 'db/model/notepad.dart';

class AppStates extends GetxController {
  var isAffirmationComplete = false;
  var isMeditationComplete = false;
  var isFitnessComplete = false;
  var isDiaryComplete = false;
  var isReadingComplete = false;
  var isVisualizationComplete = false;

  var listOfNotepads = [Notepad('0', '', '02.07.2020')].obs;

  var audioList =
      List.generate(7, (index) => AssetsAudioPlayer.withId(index.toString()))
          .obs;
  var selectedMeditationIndex = 0.obs;
  var isPlayed = false.obs;
  var listNames = [
    'Bell temple',
    'Dawn chorus',
    'Eclectopedia',
    'Hommic',
    'Meditation space',
    'Sounds of the forest',
    'Unlock your brainpower'
  ].obs;
}
