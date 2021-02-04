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

  // Вылранный трек по умолчанию при запуске таймера
  var isRating = true.obs;
  var audioPlayer = AssetsAudioPlayer().obs;
}
