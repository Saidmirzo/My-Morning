import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/meditation_audio/data/repositories/audio_repository_impl.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/pages/meditation/meditation_page.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/utils/other.dart';

class SelectedMEditationsScreen extends StatefulWidget {
  const SelectedMEditationsScreen({Key key}) : super(key: key);

  @override
  State<SelectedMEditationsScreen> createState() =>
      _SelectedMEditationsScreenState();
}

class _SelectedMEditationsScreenState extends State<SelectedMEditationsScreen> {
  MediationAudioController _audioController;

  @override
  void initState() {
    super.initState();
    Get.put(MediationAudioController(repository: AudioRepositoryImpl()));
    _audioController = Get.find();
    if (_audioController.favoriteAudios.value.isNotEmpty) {
      _audioController.changeAudioSource(_audioController.favoriteAudios.value);
    }
    print(_audioController.favoriteAudios.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/${menuState == MenuState.NIGT ? 'night_bg' : 'meditaton_bg'}.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                _audioController.playingIndex.value = -1;
                _audioController.bfPlayer.value.stop();
                Get.to(
                  const MeditationPage(),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 45, left: 25),
                child: Icon(
                  Icons.west,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 38,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  size: 35,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 7,
                ),
                Text(
                  'Meditations'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.center,
              child: Obx(() {
                return Text(
                  _audioController.favoriteAudios.value.isEmpty
                      ? "You haven't added any meditations to your favorites".tr
                      : 'Choose favorite meditations'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                  ),
                  textAlign: TextAlign.center,
                );
              }),
            ),
            const SizedBox(
              height: 16.48,
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: _audioController.favoriteAudios.value.length,
                  itemBuilder: (context, i) {
                    return FavoriteItem(
                      audioController: _audioController,
                      meditationAudio: _audioController.favoriteAudios.value[i],
                      id: i,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({
    Key key,
    this.meditationAudio,
    this.audioController,
    this.id,
  }) : super(key: key);
  final MeditationAudio meditationAudio;
  final MediationAudioController audioController;
  final int id;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.fromLTRB(31, 0, 31, 10),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: double.maxFinite,
            // margin: const EdgeInsets.fromLTRB(31, 0, 31, 10),
            padding:
                const EdgeInsets.symmetric(horizontal: 28.9, vertical: 22.5),
            decoration: BoxDecoration(
              color: menuState == MenuState.NIGT
                  ? const Color(0xffFAF5FF)
                  : Colors.white.withOpacity(.56),
              borderRadius: BorderRadius.circular(19),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: handlePlayPauseButton,
                  child: Obx(() {
                    return Image.asset(
                      'assets/images/meditation/${audioController.playingIndex.value == id ? 'stop' : 'resume'}_icon.png',
                      width: 30,
                      height: 30,
                      color: const Color(0xff592F72),
                    );
                  }),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        meditationAudio.name,
                        style: const TextStyle(
                          color: Color(0xff592F72),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4.25,
                    ),
                    Container(
                      width: 44.84,
                      height: 19.92,
                      decoration: BoxDecoration(
                        color: const Color(0xff592F72).withOpacity(.07),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        printDuration(
                            meditationAudio.duration ??
                                audioController.player.duration,
                            h: false),
                        style: const TextStyle(
                          color: Color(0xff592F72),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    menuState == MenuState.MORNING
                        ? audioController.setAudioFavorite(meditationAudio)
                        : audioController
                            .setAudioNightFavorite(meditationAudio);

                    audioController.bfPlayer.value.stop();
                    audioController.playingIndex.value = -1;
                  },
                  child: const Icon(
                    Icons.close,
                    color: Color(0xff592F72),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handlePlayPauseButton() async {
    if (audioController.playingIndex.value == id) {
      await audioController.bfPlayer.value.pause();
      audioController.playingIndex.value = -1;
    } else {
      playNewTrack(meditationAudio);
    }
  }

  void playNewTrack(MeditationAudio track) async {
    audioController.playingIndex.value = id;
    audioController.isAudioLoading.value = true;
    final _cachedAudioFile = await getCachedAudioFile(track);
    if (_cachedAudioFile == null) {
      await audioController.bfPlayer.value.setUrl(track.url);
    } else {
      final _filePath = _cachedAudioFile.path;
      await audioController.bfPlayer.value.setFilePath(_filePath);
    }
    audioController.bfPlayer.value.play();

    audioController.isAudioLoading.value = false;
  }

  Future<File> getCachedAudioFile(
    MeditationAudio track,
  ) async {
    MeditationAudio audioFile = audioController.audioSource
        .firstWhere((element) => element == track, orElse: () => null);
    if (audioFile?.filePath != null) {
      return File(audioFile.filePath);
    } else {
      var fl = await audioController.cacheAudioFile(track);
      return fl != null ? File(fl.filePath) : null;
    }
  }
}
