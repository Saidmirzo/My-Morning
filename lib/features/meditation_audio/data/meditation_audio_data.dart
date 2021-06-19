import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';

class MeditationAudioData {
  List<MeditationAudio> soundSource = [
    MeditationAudio(
        name: 'Early winter',
        url:
            'https://storage.yandexcloud.net/myaudio/Sound/Early%20winter%2C%20the%20sound%20of%20ice%20in%20the%20ocean.mp3'),
    MeditationAudio(
        name: 'Fire Fireplace',
        url:
            'https://storage.yandexcloud.net/myaudio/Sound/Fire%20Fireplace.mp3'),
    MeditationAudio(
        name: 'Ice Thundering',
        url:
            'https://storage.yandexcloud.net/myaudio/Sound/Ice%20Thundering.mp3'),
    MeditationAudio(
        name: 'Jungle animals',
        url:
            'https://storage.yandexcloud.net/myaudio/Sound/Jungle%20animals.mp3'),
    MeditationAudio(
        name: 'Lake Ambience Environment',
        url:
            'https://storage.yandexcloud.net/myaudio/Sound/Lake%20Ambience%20Environment.mp3'),
    MeditationAudio(
        name: 'Rain on Porch with Eavestrough',
        url:
            'https://storage.yandexcloud.net/myaudio/Sound/Rain%20on%20Porch%20with%20Eavestrough.mp3'),
    MeditationAudio(
        name: 'Rain on plastic',
        url:
            'https://storage.yandexcloud.net/myaudio/Sound/Rain%20on%20plastic.mp3'),
    MeditationAudio(
        name: 'Sea coast',
        url: 'https://storage.yandexcloud.net/myaudio/Sound/Sea%20coast.mp3'),
    MeditationAudio(
        name: 'Troubled Ocean',
        url:
            'https://storage.yandexcloud.net/myaudio/Sound/Troubled%20Ocean.mp3'),
    MeditationAudio(
        name: 'Waterfall',
        url: 'https://storage.yandexcloud.net/myaudio/Sound/Waterfall.mp3'),
    MeditationAudio(
        name: 'Ocean Roar',
        url:
            'https://storage.yandexcloud.net/myaudio/Meditation/Ocean%20Roar.mp3'),
    MeditationAudio(
        name: 'Forest wizard',
        url:
            'https://storage.yandexcloud.net/myaudio/Meditation/Forest%20wizard.mp3'),
    MeditationAudio(
        name: 'Dawn chorus',
        url:
            'https://storage.yandexcloud.net/myaudio/Meditation/Dawn%20Chorus.mp3'),
    MeditationAudio(
        name: 'Sounds of the forest',
        url:
            'https://storage.yandexcloud.net/myaudio/Meditation/Sounds%20of%20the%20forest.mp3'),
  ];

  List<MeditationAudio> musicSource = [
    // Первые 2 трека используются для голосовых медитаций в качестве фоновой музыки
    MeditationAudio(
        name: 'Pepe - La Vallee',
        url:
            'https://storage.yandexcloud.net/myaudio/Nastavnik/Zvyki/Pepe%20-%20La%20Vallee%20Des%20Anges.mp3'),
    MeditationAudio(
        name: 'Tibetan bowls',
        url:
            'https://storage.yandexcloud.net/myaudio/Nastavnik/Zvyki/Tibetskie_poyuschie_chashi_Ravnovesie_-_variant_8_-_Klub_yogi_Oum_ru_www_oum_ru.mp3'),
    MeditationAudio(
        name: 'Bell temple',
        url:
            'https://storage.yandexcloud.net/myaudio/Meditation/Bell%20Temple.mp3'),
    MeditationAudio(
        name: 'Eclectopedia',
        url:
            'https://storage.yandexcloud.net/myaudio/Meditation/Eclectopedia.mp3'),
    MeditationAudio(
        name: 'Hommic',
        url: 'https://storage.yandexcloud.net/myaudio/Meditation/Hommik.mp3'),
    MeditationAudio(
        name: 'Meditation space',
        url:
            'https://storage.yandexcloud.net/myaudio/Meditation/Meditation%20spa%D1%81e.mp3'),
    MeditationAudio(
        name: 'Unlock your brainpower',
        url:
            'https://storage.yandexcloud.net/myaudio/Meditation/Unlock%20Your%20Brainpower.mp3'),
    MeditationAudio(
        name: 'Elf meditation',
        url:
            'https://storage.yandexcloud.net/myaudio/Meditation/Elf%20meditation.mp3'),
    MeditationAudio(
        name: 'Jellyfish scan',
        url:
            'https://storage.yandexcloud.net/myaudio/Meditation/Jellyfish%20scan.mp3'),
    MeditationAudio(
        name: 'Thoribass and Breath',
        url:
            'https://storage.yandexcloud.net/myaudio/Meditation/Thoribass%20and%20Breath.mp3'),
    MeditationAudio(
        name: 'Om Marapa Tsanati',
        url:
            'https://storage.yandexcloud.net/myaudio/Meditation/Om%20Marapa%20Tsanati.mp3'),
  ];

  List<MeditationAudio> meditationRuSource = [
    MeditationAudio(
        name: 'Утренняя медитация благодарности',
        url:
            'https://storage.yandexcloud.net/myaudio/Nastavnik/Ru/1%20%D0%A3%D1%82%D1%80%D0%B5%D0%BD%D0%BD%D1%8F%D1%8F%20%D0%BC%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D0%B1%D0%BB%D0%B0%D0%B3%D0%BE%D0%B4%D0%B0%D1%80%D0%BD%D0%BE%D1%81%D1%82%D0%B8.mp3',
        duration: Duration(minutes: 5, seconds: 49)),
    MeditationAudio(
        name: 'Утренняя медитация с аффирмацией',
        url:
            'https://storage.yandexcloud.net/myaudio/Nastavnik/Ru/2%20%D0%A3%D1%82%D1%80%D0%B5%D0%BD%D0%BD%D1%8F%D1%8F%20%D0%BC%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D1%81%20%D0%B0%D1%84%D1%84%D0%B8%D1%80%D0%BC%D0%B0%D1%86%D0%B8%D0%B5%D0%B9.mp3',
        duration: Duration(minutes: 2, seconds: 2)),
    MeditationAudio(
        name: 'Медитация против стресса',
        url:
            'https://storage.yandexcloud.net/myaudio/Nastavnik/Ru/3%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D0%BF%D1%80%D0%BE%D1%82%D0%B8%D0%B2%20%D1%81%D1%82%D1%80%D0%B5%D1%81%D1%81%D0%B0.mp3',
        duration: Duration(minutes: 4, seconds: 22)),
    MeditationAudio(
        name: 'Медитация «осознание тела»',
        url:
            'https://storage.yandexcloud.net/myaudio/Nastavnik/Ru/4%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%C2%AB%D0%BE%D1%81%D0%BE%D0%B7%D0%BD%D0%B0%D0%BD%D0%B8%D0%B5%20%D1%82%D0%B5%D0%BB%D0%B0%C2%BB%20(%D1%8D%D0%BA%D1%81%D0%BF%D1%80%D0%B5%D1%81%D1%81).mp3',
        duration: Duration(minutes: 2, seconds: 13)),
    MeditationAudio(
        name: 'Медитация для расслабления и подготовки ко сну',
        url:
            'https://storage.yandexcloud.net/myaudio/Nastavnik/Ru/5%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D0%B4%D0%BB%D1%8F%20%D1%80%D0%B0%D1%81%D1%81%D0%BB%D0%B0%D0%B1%D0%BB%D0%B5%D0%BD%D0%B8%D1%8F%20%D0%B8%20%D0%BF%D0%BE%D0%B4%D0%B3%D0%BE%D1%82%D0%BE%D0%B2%D0%BA%D0%B8%20%D0%BA%D0%BE%20%D1%81%D0%BD%D1%83.mp3',
        duration: Duration(minutes: 5, seconds: 17)),
    MeditationAudio(
        name: 'Медитация для контроля дыхания',
        url:
            'https://storage.yandexcloud.net/myaudio/Nastavnik/Ru/6%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D0%B4%D0%BB%D1%8F%20%D0%BA%D0%BE%D0%BD%D1%82%D1%80%D0%BE%D0%BB%D1%8F%20%D0%B4%D1%8B%D1%85%D0%B0%D0%BD%D0%B8%D1%8F.mp3',
        duration: Duration(minutes: 3, seconds: 0)),
  ];

  List<MeditationAudio> meditationEnSource = [
    MeditationAudio(
        name: 'Morning Thankgiving Meditation',
        url:
            'https://storage.yandexcloud.net/myaudio/Nastavnik/En/1.Morning%20Thankgiving%20Meditation.mp3',
        duration: Duration(minutes: 5, seconds: 49)),
    MeditationAudio(
        name: 'Morning Meditation with Affirmation',
        url:
            'https://storage.yandexcloud.net/myaudio/Nastavnik/En/2.Morning%20Meditation%20with%20Affirmation.mp3',
        duration: Duration(minutes: 2, seconds: 2)),
    MeditationAudio(
        name: 'Non-stress Meditation',
        url:
            'https://storage.yandexcloud.net/myaudio/Nastavnik/En/3.%20Non-stress%20Meditation.mp3',
        duration: Duration(minutes: 4, seconds: 22)),
    MeditationAudio(
        name: 'Meditation for relaxation and sleep preparation',
        url:
            'https://storage.yandexcloud.net/myaudio/Nastavnik/En/5.%20Meditation%20for%20relaxation%20and%20sleep%20preparation.mp3',
        duration: Duration(minutes: 2, seconds: 13)),
    MeditationAudio(
        name: 'Meditation for breathing control',
        url:
            'https://storage.yandexcloud.net/myaudio/Nastavnik/En/6.%20Meditation%20for%20breathing%20control.mp3',
        duration: Duration(minutes: 5, seconds: 17)),
  ];
}

MeditationAudioData meditationAudioData = MeditationAudioData();
