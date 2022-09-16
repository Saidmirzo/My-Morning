import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';

class MeditationAudioData {
  // List<MeditationAudio> soundSource = [
  //   MeditationAudio(
  //       name: 'Early winter',
  //       url:
  //           'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FEarly%20winter%2C%20the%20sound%20of%20ice%20in%20the%20ocean.mp3?alt=media&token=7c5a185b-64de-464a-a52d-4c32ead45c06'),
  //   MeditationAudio(
  //       name: 'Fire Fireplace',
  //       url: 'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FFire%20Fireplace.mp3?alt=media&token=23952b22-79f3-4d2c-9b19-c7e47514ebf2'),
  //   MeditationAudio(
  //       name: 'Ice Thundering',
  //       url: 'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FIce%20Thundering.mp3?alt=media&token=62b276f3-a4f3-4cb3-ad45-13181908a3a1'),
  //   MeditationAudio(
  //       name: 'Jungle animals',
  //       url: 'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FJungle%20animals.mp3?alt=media&token=6af20d39-4d73-4eb7-8574-c826fa09172e'),
  //   MeditationAudio(
  //       name: 'Lake Ambience Environment',
  //       url: 'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FLake%20Ambience%20Environment.mp3?alt=media&token=363deb25-5aad-4102-8ad1-6e9a67c657ab'),
  //   MeditationAudio(
  //       name: 'Rain on Porch with Eavestrough',
  //       url:
  //           'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FRain%20on%20Porch%20with%20Eavestrough.mp3?alt=media&token=6984de58-5a2a-4ccb-b4c0-3fd1b3cc3bff'),
  //   MeditationAudio(
  //       name: 'Rain on plastic',
  //       url: 'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FRain%20on%20plastic.mp3?alt=media&token=9d856eda-47f3-46b9-a4ca-735f1a075676'),
  //   MeditationAudio(
  //       name: 'Sea coast', url: 'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FSea%20coast.mp3?alt=media&token=e22a3b8a-d705-4607-b938-33fae1050f8b'),
  //   MeditationAudio(
  //       name: 'Troubled Ocean',
  //       url: 'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FTroubled%20Ocean.mp3?alt=media&token=917af00e-72c1-40f1-b099-cafe58f9439a'),
  //   MeditationAudio(
  //       name: 'Waterfall', url: 'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FWaterfall.mp3?alt=media&token=97eae8b7-a736-4bc1-8b1f-3145afc89bd1'),
  //   MeditationAudio(
  //       name: 'Ocean Roar', url: 'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FOcean%20Roar.mp3?alt=media&token=284e5fe9-4fa0-46d1-8eb0-ba44127e5372'),
  //   MeditationAudio(
  //       name: 'Forest wizard',
  //       url: 'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FForest%20wizard.mp3?alt=media&token=7fa85f55-c677-43ec-8c8e-11f122b1c839'),
  //   MeditationAudio(
  //       name: 'Dawn chorus',
  //       url: 'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FDawn%20Chorus.mp3?alt=media&token=8fbd54aa-c6e8-46c6-87fb-eeafaa1fd138'),
  //   MeditationAudio(
  //       name: 'Sounds of the forest',
  //       url: 'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FSounds%20of%20the%20forest.mp3?alt=media&token=44581c67-664e-4285-a61f-1326b515ad99'),
  // ];

  List<MeditationAudio> musicSource = [
    // Первые 2 трека используются для голосовых медитаций в качестве фоновой музыки
    const MeditationAudio(
        duration: Duration(minutes: 5, seconds: 10),
        name: 'Pepe - La Vallee',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FPepe%20-%20La%20Vallee%20Des%20Anges.mp3?alt=media&token=22f3d810-cdc9-48c1-b5d9-241af2b2fcc9'),
    const MeditationAudio(
        duration: Duration(minutes: 6, seconds: 54),
        name: 'Tibetan bowls',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FTibetskie_poyuschie_chashi_Ravnovesie_-_variant_8_-_Klub_yogi_Oum_ru_www_oum_ru.mp3?alt=media&token=a83955a6-ef3a-46ed-9c30-570373068ff5'),
    const MeditationAudio(
        duration: Duration(minutes: 2, seconds: 23),
        name: 'Bell temple',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FBell%20Temple.mp3?alt=media&token=7e06a3e1-f3be-4890-967f-fdf89d9768c3'),
    const MeditationAudio(
        duration: Duration(minutes: 5, seconds: 17),
        name: 'Eclectopedia',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FEclectopedia.mp3?alt=media&token=baa97a6c-b865-43a3-b1b0-7c23abdbb13a'),
    const MeditationAudio(
        duration: Duration(minutes: 5, seconds: 26),
        name: 'Hommic',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FHommik.mp3?alt=media&token=288097e1-9d69-4590-9d8b-6362d84f065a'),
    const MeditationAudio(
        duration: Duration(minutes: 5, seconds: 9),
        name: 'Meditation space',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FMeditation%20spa%D1%81e.mp3?alt=media&token=44ddf8e1-5103-4ee7-83a4-f62d13744d9d'),
    const MeditationAudio(
        duration: Duration(minutes: 5, seconds: 40),
        name: 'Unlock your brainpower',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FUnlock%20Your%20Brainpower.mp3?alt=media&token=4846de12-2ccd-44c3-82ab-033dbb720a59'),
    const MeditationAudio(
        duration: Duration(minutes: 4, seconds: 16),
        name: 'Elf meditation',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FElf%20meditation.mp3?alt=media&token=4b1f35ba-4188-4af4-9838-093d7894b3e5'),
    const MeditationAudio(
        duration: Duration(minutes: 2, seconds: 58),
        name: 'Jellyfish scan',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FJellyfish%20scan.mp3?alt=media&token=483473a0-8fb2-4353-9dae-811ddcf91531'),
    const MeditationAudio(
        duration: Duration(minutes: 4, seconds: 43),
        name: 'Thoribass and Breath',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FThoribass%20and%20Breath.mp3?alt=media&token=deae8afc-0bd5-4040-82ea-1fe6c49cab23'),
    const MeditationAudio(
        duration: Duration(minutes: 4, seconds: 50),
        name: 'Om Marapa Tsanati',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FOm%20Marapa%20Tsanati.mp3?alt=media&token=78794e6d-e785-44aa-b5a0-284e0ddb5af0'),
    const MeditationAudio(
        duration: Duration(minutes: 1, seconds: 19),
        name: 'Early winter',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FEarly%20winter%2C%20the%20sound%20of%20ice%20in%20the%20ocean.mp3?alt=media&token=7c5a185b-64de-464a-a52d-4c32ead45c06'),
    const MeditationAudio(
        duration: Duration(minutes: 1, seconds: 52),
        name: 'Fire Fireplace',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FFire%20Fireplace.mp3?alt=media&token=23952b22-79f3-4d2c-9b19-c7e47514ebf2'),
    const MeditationAudio(
        duration: Duration(minutes: 1, seconds: 20),
        name: 'Ice Thundering',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FIce%20Thundering.mp3?alt=media&token=62b276f3-a4f3-4cb3-ad45-13181908a3a1'),
    const MeditationAudio(
        duration: Duration(minutes: 1),
        name: 'Jungle animals',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FJungle%20animals.mp3?alt=media&token=6af20d39-4d73-4eb7-8574-c826fa09172e'),
    const MeditationAudio(
        duration: Duration(minutes: 1),
        name: 'Lake Ambience Environment',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FLake%20Ambience%20Environment.mp3?alt=media&token=363deb25-5aad-4102-8ad1-6e9a67c657ab'),
    const MeditationAudio(
        duration: Duration(minutes: 1, seconds: 56),
        name: 'Rain on Porch with Eavestrough',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FRain%20on%20Porch%20with%20Eavestrough.mp3?alt=media&token=6984de58-5a2a-4ccb-b4c0-3fd1b3cc3bff'),
    const MeditationAudio(
        duration: Duration(seconds: 49),
        name: 'Rain on plastic',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FRain%20on%20plastic.mp3?alt=media&token=9d856eda-47f3-46b9-a4ca-735f1a075676'),
    const MeditationAudio(
        duration: Duration(
          minutes: 1,
        ),
        name: 'Sea coast',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FSea%20coast.mp3?alt=media&token=e22a3b8a-d705-4607-b938-33fae1050f8b'),
    const MeditationAudio(
        duration: Duration(minutes: 2, seconds: 53),
        name: 'Troubled Ocean',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FTroubled%20Ocean.mp3?alt=media&token=917af00e-72c1-40f1-b099-cafe58f9439a'),
    const MeditationAudio(
        duration: Duration(minutes: 2),
        name: 'Waterfall',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FWaterfall.mp3?alt=media&token=97eae8b7-a736-4bc1-8b1f-3145afc89bd1'),
    const MeditationAudio(
        duration: Duration(minutes: 2, seconds: 36),
        name: 'Ocean Roar',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FOcean%20Roar.mp3?alt=media&token=284e5fe9-4fa0-46d1-8eb0-ba44127e5372'),
    const MeditationAudio(
        duration: Duration(minutes: 2, seconds: 57),
        name: 'Forest wizard',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FForest%20wizard.mp3?alt=media&token=7fa85f55-c677-43ec-8c8e-11f122b1c839'),
    const MeditationAudio(
        duration: Duration(minutes: 5, seconds: 4),
        name: 'Dawn chorus',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FDawn%20Chorus.mp3?alt=media&token=8fbd54aa-c6e8-46c6-87fb-eeafaa1fd138'),
    const MeditationAudio(
        duration: Duration(minutes: 3),
        name: 'Sounds of the forest',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2FSounds%20of%20the%20forest.mp3?alt=media&token=44581c67-664e-4285-a61f-1326b515ad99'),
  ];

  List<MeditationAudio> meditationRuSource = [
    const MeditationAudio(
        name: 'Утренняя медитация благодарности',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F1%20%D0%A3%D1%82%D1%80%D0%B5%D0%BD%D0%BD%D1%8F%D1%8F%20%D0%BC%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D0%B1%D0%BB%D0%B0%D0%B3%D0%BE%D0%B4%D0%B0%D1%80%D0%BD%D0%BE%D1%81%D1%82%D0%B8.mp3?alt=media&token=2fac0538-7237-4edc-8145-21b8f34f8bb3',
        duration: Duration(minutes: 5, seconds: 49)),
    const MeditationAudio(
        name: 'Утренняя медитация с аффирмацией',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F2%20%D0%A3%D1%82%D1%80%D0%B5%D0%BD%D0%BD%D1%8F%D1%8F%20%D0%BC%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D1%81%20%D0%B0%D1%84%D1%84%D0%B8%D1%80%D0%BC%D0%B0%D1%86%D0%B8%D0%B5%D0%B8%CC%86.mp3?alt=media&token=4345ca9c-32a8-4c7a-8916-3a026d543324',
        duration: Duration(minutes: 2, seconds: 2)),
    const MeditationAudio(
        name: 'Медитация против стресса',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F3%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D0%BF%D1%80%D0%BE%D1%82%D0%B8%D0%B2%20%D1%81%D1%82%D1%80%D0%B5%D1%81%D1%81%D0%B0.mp3?alt=media&token=b34f6230-4ced-4c5c-bc50-7fce2f76dd19',
        duration: Duration(minutes: 4, seconds: 22)),
    const MeditationAudio(
        name: 'Медитация «осознание тела»',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F4%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%C2%AB%D0%BE%D1%81%D0%BE%D0%B7%D0%BD%D0%B0%D0%BD%D0%B8%D0%B5%20%D1%82%D0%B5%D0%BB%D0%B0%C2%BB%20(%D1%8D%D0%BA%D1%81%D0%BF%D1%80%D0%B5%D1%81%D1%81).mp3?alt=media&token=e09e3f80-1ee8-4286-b03c-994e2e182383',
        duration: Duration(minutes: 2, seconds: 13)),
    const MeditationAudio(
        name: 'Медитация для расслабления и подготовки ко сну',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F5%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D0%B4%D0%BB%D1%8F%20%D1%80%D0%B0%D1%81%D1%81%D0%BB%D0%B0%D0%B1%D0%BB%D0%B5%D0%BD%D0%B8%D1%8F%20%D0%B8%20%D0%BF%D0%BE%D0%B4%D0%B3%D0%BE%D1%82%D0%BE%D0%B2%D0%BA%D0%B8%20%D0%BA%D0%BE%20%D1%81%D0%BD%D1%83.mp3?alt=media&token=46bb1455-3ace-40d4-81de-ac2626829894',
        duration: Duration(minutes: 5, seconds: 17)),
    const MeditationAudio(
        name: 'Медитация для контроля дыхания',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F6%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D0%B4%D0%BB%D1%8F%20%D0%BA%D0%BE%D0%BD%D1%82%D1%80%D0%BE%D0%BB%D1%8F%20%D0%B4%D1%8B%D1%85%D0%B0%D0%BD%D0%B8%D1%8F.mp3?alt=media&token=5a3ac012-f112-405e-8113-46cf1c4d9b5e',
        duration: Duration(minutes: 3, seconds: 0)),
    const MeditationAudio(
        name: 'Медитация на желание',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F7%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D0%BD%D0%B0%20%D0%B6%D0%B5%D0%BB%D0%B0%D0%BD%D0%B8%D0%B5.mp3?alt=media&token=f813c34b-4ffc-4b44-89c9-74364c378182',
        duration: Duration(minutes: 13, seconds: 5)),
    const MeditationAudio(
        name: ' Медитация на устранение денежных блоков',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F8%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D0%BD%D0%B0%20%D1%83%D1%81%D1%82%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D0%B5%20%D0%B4%D0%B5%D0%BD%D0%B5%D0%B6%D0%BD%D1%8B%D1%85%20%D0%B1%D0%BB%D0%BE%D0%BA%D0%BE%D0%B2.mp3?alt=media&token=22572696-5bc0-45a7-a13e-d71e784dee1f',
        duration: Duration(minutes: 13, seconds: 17)),
    const MeditationAudio(
        name: 'Медитация «Идеальный день»',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F9%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%C2%AB%D0%98%D0%B4%D0%B5%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B9%20%D0%B4%D0%B5%D0%BD%D1%8C%C2%BB.mp3?alt=media&token=0b8faf4f-bd40-49f8-8d3b-6cc20c99b07d',
        duration: Duration(minutes: 12, seconds: 48)),
    const MeditationAudio(
        name: 'Медитация на увереннос',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F10%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D0%BD%D0%B0%20%D1%83%D0%B2%D0%B5%D1%80%D0%B5%D0%BD%D0%BD%D0%BE%D1%81%D1%82%D1%8C.mp3?alt=media&token=a4b4b2cd-85af-49a4-a45c-f2032a10f758',
        duration: Duration(minutes: 12, seconds: 31)),
    const MeditationAudio(
        name: 'Медитация «Реализация»',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F11%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%C2%AB%D0%A0%D0%B5%D0%B0%D0%BB%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F%C2%BB.mp3?alt=media&token=877aeb90-8cc6-4f40-a640-bb9e6da61ada',
        duration: Duration(minutes: 13, seconds: 19)),
    const MeditationAudio(
        name: 'Медитация «Новые возможности»',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F12%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%C2%AB%D0%9D%D0%BE%D0%B2%D1%8B%D0%B5%20%D0%B2%D0%BE%D0%B7%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%D1%81%D1%82%D0%B8%C2%BB.mp3?alt=media&token=07715e22-2e40-47e8-bfea-2257c5ff5198',
        duration: Duration(minutes: 9, seconds: 53)),
    const MeditationAudio(
        name: 'Медитация «Творец судьбы»',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F13%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%C2%AB%D0%A2%D0%B2%D0%BE%D1%80%D0%B5%D1%86%20%D1%81%D1%83%D0%B4%D1%8C%D0%B1%D1%8B%C2%BB.mp3?alt=media&token=8c5c102b-00d3-4694-acfa-3120346ec16d',
        duration: Duration(minutes: 11, seconds: 57)),
    const MeditationAudio(
        name: 'Медитация «Энергия денег»',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F14.%20Meditation%20%22Energy%20of%20Money%22.mp3?alt=media&token=ce0c3ace-64c5-491a-adba-d3b47bddd6f9',
        duration: Duration(minutes: 11, seconds: 40)),
    const MeditationAudio(
        name: 'Медитация на изобилие',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F15%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D0%BD%D0%B0%20%D0%B8%D0%B7%D0%BE%D0%B1%D0%B8%D0%BB%D0%B8%D0%B5.mp3?alt=media&token=9ad177c5-909e-4dc8-b355-f2cf775eea6a',
        duration: Duration(minutes: 13, seconds: 48)),
    const MeditationAudio(
        name: 'Медитация благодарности',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F16%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D0%B1%D0%BB%D0%B0%D0%B3%D0%BE%D0%B4%D0%B0%D1%80%D0%BD%D0%BE%D1%81%D1%82%D0%B8.mp3?alt=media&token=cb205483-dd82-4723-9312-eefe50378a5b',
        duration: Duration(minutes: 11, seconds: 14)),
  ];

  List<MeditationAudio> meditationEnSource = [
    const MeditationAudio(
        name: 'Morning Thankgiving Meditation',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F1.Morning%20Thankgiving%20Meditation.mp3?alt=media&token=40d86ff9-f892-4678-a09c-15d3bfe659ef',
        duration: Duration(minutes: 5, seconds: 49)),
    const MeditationAudio(
        name: 'Morning Meditation with Affirmation',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F2.Morning%20Meditation%20with%20Affirmation.mp3?alt=media&token=368c23f7-8c0f-4f2a-84e6-921888a68e32',
        duration: Duration(minutes: 2, seconds: 2)),
    const MeditationAudio(
        name: 'Non-stress Meditation',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F3.%20Non-stress%20Meditation.mp3?alt=media&token=b8b1335a-85c9-4608-b91f-472ad639f831',
        duration: Duration(minutes: 4, seconds: 22)),
    const MeditationAudio(
        name: 'Meditation for relaxation and sleep preparation',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F5.%20Meditation%20for%20relaxation%20and%20sleep%20preparation.mp3?alt=media&token=15823b63-7a42-4020-9580-dbcd0bb0b966',
        duration: Duration(minutes: 2, seconds: 13)),
    const MeditationAudio(
        name: 'Meditation for breathing control',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F6.%20Meditation%20for%20breathing%20control.mp3?alt=media&token=67e6a4aa-ae92-4372-8d59-75ccc1e51b62',
        duration: Duration(minutes: 5, seconds: 17)),
    const MeditationAudio(
        name: 'Meditation for manifesting desires',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F7.%20Meditation%20for%20manifesting%20desires.mp3?alt=media&token=267d5499-6c5b-48bc-af87-d61000493f6e',
        duration: Duration(minutes: 13, seconds: 54)),
    const MeditationAudio(
        name: 'Remove money blocks meditation',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F8.%20Remove%20money%20blocks%20meditation.mp3?alt=media&token=d5b93a3b-235a-4f1e-ad3f-c7629a570a3a',
        duration: Duration(minutes: 10, seconds: 16)),
    const MeditationAudio(
        name: 'Meditation "Perfect Day"',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F9.%20Meditation%20%22Perfect%20Day%22.mp3?alt=media&token=6762f974-4b51-4a3f-8bb6-0d46fef6a571',
        duration: Duration(minutes: 13, seconds: 28)),
    const MeditationAudio(
        name: 'Meditation for confidence',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F10.%20Meditation%20for%20confidence.mp3?alt=media&token=441697ec-53e7-4000-8e69-8a8f8e3c8699',
        duration: Duration(minutes: 13, seconds: 46)),
    const MeditationAudio(
        name: 'Meditation "Realization"',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F11.%20Meditation%20%22Realization%22.mp3?alt=media&token=264b5bf4-b0a1-4c5b-a7be-728dd8bf58d7',
        duration: Duration(minutes: 10, seconds: 29)),
    const MeditationAudio(
        name: 'Meditation "New Opportunities"',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F12.%20Meditation%20%22New%20Opportunities%22.mp3?alt=media&token=ffe00538-0140-4ee1-9b93-fc9e88d77f58',
        duration: Duration(minutes: 9, seconds: 48)),
    const MeditationAudio(
        name: 'Meditation "Creator of Destiny"',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F13.%20Meditation%20%22Creator%20of%20Destiny%22.mp3?alt=media&token=84cbec55-e415-4f06-95d4-bb615cf53c6c',
        duration: Duration(minutes: 13, seconds: 34)),
    const MeditationAudio(
        name: 'Meditation "Energy of Money"',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F14%20%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%C2%AB%D0%AD%D0%BD%D0%B5%D1%80%D0%B3%D0%B8%D1%8F%20%D0%B4%D0%B5%D0%BD%D0%B5%D0%B3%C2%BB.mp3?alt=media&token=b5e8ac04-5c11-4b37-b6e7-916938d43056',
        duration: Duration(minutes: 10, seconds: 49)),
    const MeditationAudio(
        name: ' Meditation for abundance',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F15.%20Meditation%20for%20abundance.mp3?alt=media&token=2956708c-22b1-414e-9b28-c14faeb7478f',
        duration: Duration(minutes: 13, seconds: 24)),
    const MeditationAudio(
        name: 'Gratitude meditation',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F16.%20Gratitude%20meditation.mp3?alt=media&token=5360bdf6-8b1f-4559-9399-2d4d6bb9955c',
        duration: Duration(minutes: 10, seconds: 29)),
  ];

  List<MeditationAudio> meditationNightRuSource = [
    const MeditationAudio(
        name: 'Медитация для быстрого засыпания',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D0%B4%D0%BB%D1%8F%20%D0%B1%D1%8B%D1%81%D1%82%D1%80%D0%BE%D0%B3%D0%BE%20%D0%B7%D0%B0%D1%81%D1%8B%D0%BF%D0%B0%D0%BD%D0%B8%D1%8F.mp3?alt=media&token=e83102d1-ba3d-493d-9821-3d90624dde4c',
        duration: Duration(minutes: 4, seconds: 21)),
    const MeditationAudio(
        name: 'Не можешь уснуть? Сверхглубокий сон',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F%D0%9D%D0%B5%20%D0%BC%D0%BE%D0%B6%D0%B5%D1%88%D1%8C%20%D1%83%D1%81%D0%BD%D1%83%D1%82%D1%8C%2C%20%D1%81%D0%B2%D0%B5%D1%80%D1%85%D0%B3%D0%BB%D1%83%D0%B1%D0%BE%D0%BA%D0%B8%D0%B8%CC%86%20%D1%81%D0%BE%D0%BD.mp3?alt=media&token=813f6f27-3172-4769-beaf-8cc1d5c1affb',
        duration: Duration(minutes: 3, seconds: 22)),
    const MeditationAudio(
        name: 'Короткая медитация перед сном',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F%D0%9A%D0%BE%D1%80%D0%BE%D1%82%D0%BA%D0%B0%D1%8F%20%D0%BC%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D0%BF%D0%B5%D1%80%D0%B5%D0%B4%20%D1%81%D0%BD%D0%BE%D0%BC.mp3?alt=media&token=a566401d-97c2-4d44-9d82-014179d25e39',
        duration: Duration(minutes: 4, seconds: 0)),
    const MeditationAudio(
        name: 'Медитация для успокоения разума',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D0%B4%D0%BB%D1%8F%20%D1%83%D1%81%D0%BF%D0%BE%D0%BA%D0%BE%D0%B5%D0%BD%D0%B8%D1%8F%20%D1%80%D0%B0%D0%B7%D1%83%D0%BC%D0%B0.mp3?alt=media&token=6725ea94-c200-4859-84b9-59da718b9061',
        duration: Duration(minutes: 3, seconds: 56)),
    const MeditationAudio(
        name: 'Медитация чтобы отпустить и простить',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F%D0%9C%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20%D1%87%D1%82%D0%BE%D0%B1%D1%8B%20%D0%BE%D1%82%D0%BF%D1%83%D1%81%D1%82%D0%B8%D1%82%D1%8C%20%D0%B8%20%D0%BF%D1%80%D0%BE%D1%81%D1%82%D0%B8%D1%82%D1%8C.mp3?alt=media&token=62f8f097-9b11-43fb-b4a7-7361a401d263',
        duration: Duration(minutes: 4, seconds: 32)),
  ];

  List<MeditationAudio> meditationNightEnSource = [
    const MeditationAudio(
        name: 'Meditation for fast falling asleep',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F1.%20Meditation%20for%20fast%20fallinh%20asleeo%204-7-8.mp3?alt=media&token=8dea30ae-9a2a-42ac-b873-77544c38139c',
        duration: Duration(minutes: 4, seconds: 47)),
    const MeditationAudio(
        name: 'Super Deep Sleep',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F2.%20Super%20Deep%20Sleep.mp3?alt=media&token=f1c8a573-fe90-41c2-8e58-5651694547a6',
        duration: Duration(minutes: 3, seconds: 47)),
    const MeditationAudio(
        name: 'Short meditation before bed',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F3.%20Short%20meditation%20before%20bed.mp3?alt=media&token=993f5d19-ac01-434e-964a-5a15c1ab4824',
        duration: Duration(minutes: 4, seconds: 03)),
    const MeditationAudio(
        name: 'Meditation to calm the mind',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F4.%20Meditation%20to%20calm%20the%20mind.mp3?alt=media&token=1b67c5be-fbc3-4397-8b02-901939c2ebe7',
        duration: Duration(minutes: 4, seconds: 59)),
    const MeditationAudio(
        name: 'Meditation to let go and forgive',
        url:
            'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/meditation_audio%2F5.%20Meditation%20to%20let%20go%20and%20forgive.mp3?alt=media&token=218286d4-5c8c-4f59-9b69-5ab90c22359b',
        duration: Duration(minutes: 5, seconds: 38)),
  ];
}

MeditationAudioData meditationAudioData = MeditationAudioData();
