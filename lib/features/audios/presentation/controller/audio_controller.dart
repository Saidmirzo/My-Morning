import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:morningmagic/features/audios/data/audio_data.dart';
import 'package:morningmagic/features/audios/domain/entities/audio_file.dart';
import 'package:morningmagic/features/audios/domain/repositories/audio_repository.dart';

class AudioController extends GetxController {
  final AudioRepository audioRepository;

  AudioController({@required this.audioRepository});

  var audios = [].obs();

  // List<String> audioTitles = AudioData.audioSources.keys.toList();
  // TODO make
  AudioData getAudio(String title) {

  }



}

enum AudioWidgetState {loading, loaded, }
