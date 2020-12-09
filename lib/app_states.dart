import 'package:assets_audio_player/assets_audio_player.dart';
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
      List.generate(4, (index) => AssetsAudioPlayer.withId(index.toString()))
          .obs;
  var selectedMeditationIndex = 0.obs;
  var isPlayed = false.obs;
  var listNames = [
  'Morning glory',
  'Morning space',
  'Morning sunshine',
  'Relaxing journey'
].obs;
}
