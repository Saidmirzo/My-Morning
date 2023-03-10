// ignore_for_file: avoid_print

import 'dart:async';
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
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/storage.dart';

import '../../domain/entities/meditation_audio.dart';

class MenuItems {
  static const int music = 1;
  static const int sounds = 2;
  static const int yoga = 3;
  static const int favorite = 4;
  static const int meditationNight = 5;
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
  Duration get currentDurationTrack => player.duration;
  bool playFromFavorite = false;

  List<AudioSource> playList;
  List<AudioSource> bgPlayList;

  List<MeditationAudio> audioSource = [];
  List<MeditationAudio> bgAudioSource = [];

  Rx<Duration> durationPosition = const Duration().obs;
  RxDouble percentDuration = 0.0.obs;
  //для ночной медитации, чтобы заинициализировать таймер
  TimerService timerService;

  bool get isPlaylistAudioCached =>
      player.currentIndex < audioSource.length &&
      audioSource[player.currentIndex].filePath != null;

  // Страница с которой выбрали музыку
  RxInt currentPage = menuState == MenuState.MORNING
      ? MenuItems.music.obs
      : MenuItems.meditationNight.obs;

  RxString currAudioName = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    print('audioController: onInit');

    loadFavoriteAudios();

    if (menuState == MenuState.MORNING) {
      changeAudioSource(meditationAudioData.musicSource);
      // changeAudioSource(meditationAudioData.musicSource, isBgSource: true);
    } else {
      changeAudioSource(Get.locale.languageCode == 'ru'
          ? meditationAudioData.meditationNightRuSource
          : meditationAudioData.meditationNightEnSource);
    }

    // 50% громкость для фоновой музыки
    bgAudioPlayer.value.setVolume(1);

    player.positionStream.listen((event) {
      durationPosition.value = event;
      //stugel!!!!!!!!!
      if (event != null) return;
      percentDuration.value =
          (event.inSeconds / player.duration.inSeconds).toDouble();
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
      } else {
        isAudioLoading.value = false;
      }
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
    for (var element in (await repository.getFavoriteAudioFiles(
        menuState == MenuState.MORNING ? false : true))) {
      print('Favorite audio : $element');
      if (!favoriteAudios.value.contains(element)) {
        favoriteAudios.value.add(element);
      }
    }
  }

  void setAudioFavorite(MeditationAudio audio) async {
    favoriteAudios.value.contains(audio)
        ? favoriteAudios.value.remove(audio)
        : favoriteAudios.value.add(audio);
    await MyDB()
        .getBox()
        .put(MyResource.MEDITATION_AUDIO_FAVORITE, favoriteAudios.value);
  }

  void setAudioNightFavorite(MeditationAudio audio) async {
    favoriteAudios.value.contains(audio)
        ? favoriteAudios.value.remove(audio)
        : favoriteAudios.value.add(audio);
    await MyDB()
        .getBox()
        .put(MyResource.MEDITATION_AUDIO_NIGHT_FAVORITE, favoriteAudios.value);
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
      for (var value in favoriteAudios.value) {
        _result.add(getOneAudioItem(value));
      }
    } else {
      if (withBgSound.value) {
        print('generateMeditationPlayList : withBgSound.value');
        meditationTrackDuration.value =
            audioSource[selectedItemIndex.value].duration;
        return [getOneAudioItem(audioSource[selectedItemIndex.value])];
      } else {
        for (var element in audioSource) {
          _result.add(getOneAudioItem(element));
        }
      }
    }
    return _result.toSet().toList();
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
      // return ProgressiveAudioSource(Uri.parse(element.url));
    }
  }

  Future<List<AudioSource>> generateBgPlayList() async {
    List<AudioSource> _result = [];
    if (playFromFavorite) {
      for (var value in favoriteAudios.value) {
        final _cachedAudio = bgAudioSource.firstWhere(
          (cachedAudio) => cachedAudio.url == value.url,
          orElse: () => null,
        );
        if (_cachedAudio != null && _cachedAudio.filePath != null) {
          print('_cachedAudio.filePath: ${_cachedAudio.filePath}');
          _result.add(ProgressiveAudioSource(Uri.file(_cachedAudio.filePath)));
        } else {
          print('url: ${value.url}');
          _result.add(ProgressiveAudioSource(Uri.parse(value.url)));
          cacheAudioFile(value);
        }
      }
    } else {
      for (var element in bgAudioSource) {
        final _cachedAudio = bgAudioSource.firstWhere(
          (cachedAudio) => cachedAudio.url == element.url,
          orElse: () => null,
        );
        if (_cachedAudio != null && _cachedAudio.filePath != null) {
          _result.add(ProgressiveAudioSource(Uri.file(_cachedAudio.filePath)));
        } else {
          _result.add(ProgressiveAudioSource(Uri.parse(element.url)));
          cacheAudioFile(MeditationAudio(
              name: element.name,
              url: element.url,
              filePath: null,
              duration: element.duration));
        }
      }
    }
    return _result;
  }

  Future<void> initializeMeditationAudio(
      {bool autoplay = true,
      bool fromDialog = false,
      bool reinitMainSound = true}) async {
    print('initializeMeditationAudio');
    if (reinitMainSound) {
      print('initializeMeditationAudio: reinit main audio');
      await reinitAudioSource(fromDialog: fromDialog);
      if (reinitMainSound) updateCurrName();
      if ((bgPlayList?.length ?? 0) == 0 ||
          currentPage.value == MenuItems.yoga) {
        playList = await generateMeditationPlayList();
      }
      await player.setAudioSource(
        ConcatenatingAudioSource(
          children: List.generate(
            playList.length,
            (index) => playList[index],
          ),
        ),
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
          children: List.generate(
            bgPlayList.length,
            (index) => bgPlayList[index],
          ),
        ),
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
    if (!player.playing) {
      print('autoplay start');
      player.play();
      if (withBgSound.value) bgAudioPlayer.value.play();
    }
  }

  void updateCurrName() {
    currAudioName.value = audioSource[selectedItemIndex.value].name;
  }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> next() async {
    print('audio next');
    // if (menuState == MenuState.NIGT && !billingService.isPro()) {
    //   if (player.currentIndex >= 1) return;
    // }

    final _playListLength = playList.toSet().toList().length;

    if (_playListLength == 0) return;

    int _nextIndex = 0;

    if (player.currentIndex + 1 >= _playListLength) {
      _nextIndex = 0;
    } else {
      _nextIndex = player.currentIndex + 1;
    }

    if (timerService != null) {
      // timerService.startTimer();
      timerService.nightMeditationStart(player.duration);
    }

    await player.seek(const Duration(seconds: 0), index: _nextIndex);
    if (!withBgSound.value) {
      currAudioName.value = audioSource[_nextIndex].name;
    }
    player.play();
    selectedItemIndex.value = player.currentIndex;
  }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> prev() async {
    // print('audio prev');
    // if (menuState == MenuState.NIGT && !billingService.isPro()) {
    //   if (player.currentIndex == 0) return;
    // }

    final _playListLength = playList.length;

    if (_playListLength == 0) return;

    int _nextIndex = 0;

    if (player.currentIndex == 0) {
      _nextIndex = _playListLength - 1;
    } else {
      _nextIndex = player.currentIndex - 1;
    }

    if (timerService != null) {
      timerService.nightMeditationStart(audioSource[_nextIndex].duration);
    }

    await player.seek(const Duration(seconds: 0), index: _nextIndex);
    if (!withBgSound.value) {
      currAudioName.value = audioSource[_nextIndex].name;
    }
    player.play();
    selectedItemIndex.value = player.currentIndex;
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<void> play() async {
    print('playOrPause: player.play');

    await player.play();
    isPlaying(true);
  }

  Future<void> pause() async {
    print('playOrPause: player.pause');
    await player.pause();
    isPlaying(false);
  }

  Future<void> playOrPause() async {
    print('bgAudioPlayer.value.playing: ${bgAudioPlayer.value.playing}');
    print('player.playing: ${player.playing}');
    if (withBgSound.value) {
      player.playing ? bgAudioPlayer.value.pause() : bgAudioPlayer.value.play();
    }
    if (player.playing) {
      await pause();
    } else {
      await play();
    }
    print('All duration: ${player.duration}');
  }
}
