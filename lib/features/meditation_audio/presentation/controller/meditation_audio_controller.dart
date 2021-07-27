import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';
import 'package:morningmagic/features/meditation_audio/domain/repositories/audio_repository.dart';

import '../../domain/entities/meditation_audio.dart';

class MenuItems {
  static const int music = 1;
  static const int sounds = 2;
  static const int yoga = 3;
  static const int favorite = 4;
}

class MediationAudioController extends GetxController {
  MediationAudioController({@required this.repository});

  RxBool withBgSound = false.obs;

  final AudioRepository repository;

  // Плеер для выбора трека, чтобы не затирать основной
  var bfPlayer = AudioPlayer().obs;
  // Основной плеер
  var audioPlayer = AudioPlayer().obs;
  // Плеер для фоновой музыки
  var bgAudioPlayer = AudioPlayer().obs;

  AudioPlayer get player => audioPlayer.value;

  var favoriteAudios = RxList<MeditationAudio>().obs;

  // чтобы подсветить нужный нам элемент
  var bufIdSelected = 0.obs;

  var selectedItemIndex = 0.obs;
  var bgSelectedItemIndex = (-1).obs;

  // Какая позиция играет на странице выбора музыки
  var playingIndex = (-1).obs;
  // Если играет на странице таймера
  RxBool isPlaying = false.obs;
  var isAudioLoading = false.obs;

  bool playFromFavorite = false;

  List<AudioSource> playList;
  List<AudioSource> bgPlayList;

  List<MeditationAudio> audioSource = [];
  List<MeditationAudio> bgAudioSource = [];

  Rx<Duration> durationPosition = Duration().obs;
  RxDouble percentDuration = 0.0.obs;

  bool get isPlaylistAudioCached =>
      player.currentIndex < audioSource.length &&
      audioSource[player.currentIndex].filePath != null;

  // Страница с которой выбрали музыку
  RxInt currentPage = MenuItems.music.obs;

  RxString currAudioName = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    print('audioController: onInit');

    loadFavoriteAudios();

    changeAudioSource(meditationAudioData.musicSource);
    changeAudioSource(meditationAudioData.musicSource, isBgSource: true);

    // 50% громкость для фоновой музыки
    bgAudioPlayer.value.setVolume(.5);

    player.positionStream.listen((event) {
      durationPosition.value = event;
      if (event == null) return;
      percentDuration.value =
          ((event?.inSeconds ?? 0 / player?.duration?.inSeconds ?? 0) / 100)
              .toDouble();
    }, onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    player.playingStream.listen((event) {
      print('playingStream $event');
      if (isPlaying.value != event) isPlaying.value = event;
    });
    player.playerStateStream.listen((state) {
      if (!state.playing &&
          (state.processingState.index == ProcessingState.loading.index ||
              state.processingState.index == ProcessingState.buffering.index)) {
        isAudioLoading.value = true;
      } else
        isAudioLoading.value = false;
    });
  }

  @override
  void onClose() {
    super.onClose();
    print('Meditation audio controller closed, player stopped and disposed');
    player.stop();
    player.dispose();
    bgAudioPlayer.value.stop();
    bgAudioPlayer.value.dispose();
  }

  void changeAudioSource(List<MeditationAudio> source,
      {bool isBgSource = false}) {
    List<MeditationAudio> list = [];
    list.addAll(source);
    if (isBgSource) {
      bgAudioSource.clear();
      bgAudioSource = list;
    } else {
      audioSource.clear();
      audioSource = list;
    }
  }

  void changeItem(int id) {
    print('changeSelectedItem withBgSound: ${withBgSound.value}');
    if (withBgSound.value) {
      bgSelectedItemIndex.value = id;
    } else {
      selectedItemIndex.value = id;
    }
  }

  void changePage(int i) {
    print('menu audio changePage to $i');
    currentPage.value = i;
  }

  void changeBgValume(double val) {
    bgAudioPlayer.value.setVolume(val);
    bgAudioPlayer.refresh();
  }

  Future<void> reinitAudioSource({bool fromDialog = false}) async {
    print('reinitAudioSource');
    if (playFromFavorite) {
      print('playFromFavorite');
      audioSource.clear();
      audioSource.addAll(favoriteAudios.value);
    } else {
      print('play From audioSource');
      if (!fromDialog) {
        print('reinitAudioSource: from chashed audio files');
        audioSource.addAll(await repository.getCachedAudioFiles(audioSource));
        if (withBgSound.value) {
          bgAudioSource
              .addAll(await repository.getCachedAudioFiles(bgAudioSource));
        }
      }
    }
    print('audioSource lenght: ${audioSource.length}');
    await loadFavoriteAudios();
  }

  Future loadFavoriteAudios() async {
    (await repository.getFavoriteAudioFiles()).forEach((element) {
      print('Favorite audio : $element');
      if (!favoriteAudios.value.contains(element))
        favoriteAudios.value.add(element);
    });
  }

  void setAudioFavorite(MeditationAudio audio) async {
    favoriteAudios.value.contains(audio)
        ? favoriteAudios.value.remove(audio)
        : favoriteAudios.value.add(audio);
    await MyDB()
        .getBox()
        .put(MyResource.MEDITATION_AUDIO_FAVORITE, favoriteAudios.value);
  }

  Future<MeditationAudio> cacheAudioFile(MeditationAudio track) async {
    try {
      MeditationAudio audioFile = await repository.getAudioFile(track);
      audioSource.add(audioFile);
      return audioFile;
    } catch (e) {
      print('cacheAudioFile: $e');
    }
    return null;
  }

  Future<MeditationAudio> cacheBgAudio(MeditationAudio track) async {
    try {
      MeditationAudio audioFile = await repository.getAudioFile(track);
      bgAudioSource.add(audioFile);
      return audioFile;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Rx<Duration> meditationTrackDuration = 0.seconds.obs;
  Future<List<AudioSource>> generateMeditationPlayList() async {
    meditationTrackDuration?.value = null;
    List<AudioSource> _result = [];
    if (playFromFavorite) {
      print('generateMeditationPlayList: playFromFavorite');
      favoriteAudios.value.forEach((value) {
        _result.add(getOneAudioItem(value));
      });
    } else {
      if (withBgSound.value) {
        print('generateMeditationPlayList : withBgSound.value');
        meditationTrackDuration.value =
            audioSource[selectedItemIndex.value].duration;
        return [getOneAudioItem(audioSource[selectedItemIndex.value])];
      } else {
        audioSource.forEach((element) {
          _result.add(getOneAudioItem(element));
        });
      }
    }
    return _result;
  }

  AudioSource getOneAudioItem(MeditationAudio element) {
    print('getOneAudioItem $element');
    final _cachedAudio = bgAudioSource.firstWhere(
      (cachedAudio) => cachedAudio.url == element.url,
      orElse: () => null,
    );
    if (_cachedAudio?.filePath != null) {
      print('getOneAudioItem filePath!=null');
      return AudioSource.uri(Uri.file(_cachedAudio.filePath));
    } else {
      print('getOneAudioItem filePath == null');
      cacheAudioFile(element);
      return ProgressiveAudioSource(Uri.parse(element.url));
    }
  }

  Future<List<AudioSource>> generateBgPlayList() async {
    List<AudioSource> _result = [];
    if (playFromFavorite) {
      favoriteAudios.value.forEach((value) {
        final _cachedAudio = bgAudioSource.firstWhere(
          (cachedAudio) => cachedAudio.url == value.url,
          orElse: () => null,
        );
        if (_cachedAudio != null && _cachedAudio.filePath != null) {
          print('_cachedAudio.filePath: ${_cachedAudio.filePath}');
          _result.add(AudioSource.uri(Uri.file(_cachedAudio.filePath)));
        } else {
          print('url: ${value.url}');
          _result.add(ProgressiveAudioSource(Uri.parse(value.url)));
          cacheAudioFile(value);
        }
      });
    } else {
      bgAudioSource.forEach((element) {
        final _cachedAudio = bgAudioSource.firstWhere(
          (cachedAudio) => cachedAudio.url == element.url,
          orElse: () => null,
        );
        if (_cachedAudio != null && _cachedAudio.filePath != null) {
          _result.add(AudioSource.uri(Uri.file(_cachedAudio.filePath)));
        } else {
          _result.add(ProgressiveAudioSource(Uri.parse(element.url)));
          cacheAudioFile(MeditationAudio(
              name: element.name, url: element.url, filePath: null));
        }
      });
    }
    return _result;
  }

  void initializeMeditationAudio(
      {bool autoplay = true,
      bool fromDialog = false,
      bool reinitMainSound = true}) async {
    print('initializeMeditationAudio');
    if (reinitMainSound) {
      print('initializeMeditationAudio: reinit main audio');
      await reinitAudioSource(fromDialog: fromDialog);
      if (reinitMainSound) updateCurrName();
      if ((bgPlayList?.length ?? 0) == 0 || currentPage.value == MenuItems.yoga)
        playList = await generateMeditationPlayList();
      await player.setAudioSource(
        ConcatenatingAudioSource(
            children:
                List.generate(playList.length, (index) => playList[index])),
        initialIndex: withBgSound.value ? 0 : selectedItemIndex.value,
      );
      await player.setLoopMode(withBgSound.value ? LoopMode.off : LoopMode.one);
    }

    if (withBgSound.value) {
      print('initializeMeditationAudio: reinit bg audio');
      // Фоновая музыка
      bgPlayList = await generateBgPlayList();
      await bgAudioPlayer.value.setAudioSource(
        ConcatenatingAudioSource(
            children:
                List.generate(bgPlayList.length, (index) => bgPlayList[index])),
        initialIndex: bgSelectedItemIndex.value >= 0
            ? bgSelectedItemIndex.value
            : selectedItemIndex.value < 3
                ? 0
                : 1,
        initialPosition: Duration.zero,
      );
      await bgAudioPlayer.value.setLoopMode(LoopMode.one);
    } else {
      bgPlayList?.clear();
    }
    if (autoplay) {
      print('autoplay start');
      player.play();
      if (withBgSound.value) bgAudioPlayer.value.play();
    }
  }

  void updateCurrName() {
    currAudioName.value = audioSource[selectedItemIndex.value].name;
  }

  void next() {
    print('audio next');
    final _playListLength = playList.length;
    if (_playListLength == 0) return;
    int _nextIndex = 0;
    if (player.currentIndex + 1 >= _playListLength)
      _nextIndex = 0;
    else
      _nextIndex = player.currentIndex + 1;
    player.seek(Duration(seconds: 0), index: _nextIndex);
    if (!withBgSound.value) {
      currAudioName.value = audioSource[_nextIndex].name;
    }
    if (!player.playing) player.play();
  }

  void prev() {
    print('audio prev');
    final _playListLength = playList.length;
    if (_playListLength == 0) return;
    int _nextIndex = 0;
    if (player.currentIndex == 0)
      _nextIndex = _playListLength - 1;
    else
      _nextIndex = player.currentIndex - 1;
    player.seek(Duration(seconds: 0), index: _nextIndex);
    if (!withBgSound.value) {
      currAudioName.value = audioSource[_nextIndex].name;
    }
    if (!player.playing) player.play();
  }

  void play() {
    print('playOrPause: player.play');
    player.play();
    isPlaying(true);
  }

  void pause() {
    print('playOrPause: player.pause');
    player.pause();
    isPlaying(false);
  }

  void playOrPause() {
    print('bgAudioPlayer.value.playing: ${bgAudioPlayer.value.playing}');
    print('player.playing: ${player.playing}');
    if (withBgSound.value) {
      player.playing ? bgAudioPlayer.value.pause() : bgAudioPlayer.value.play();
    }
    if (player.playing) {
      pause();
    } else {
      play();
    }
    print('All duration: ${player.duration}');
  }
}
