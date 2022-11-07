// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class AppColors {
  static const lightViolet = Color(0xFF7948c2);
  static const violet = Color(0xFF502e82);
  static const violetOnb = Color(0xFF6B0496);
  static const cream = Color(0xFFe9b7b3);
  static const lightCream = Color(0xFFf6e4e2);
  static const pink = Color(0xFFc24e95);
  static const topGradient = Color(0xFF8aa9ff);
  static const middleGradient = Color(0xFFd5c7e9);
  static const bottomGradient = Color(0xFFfde0d4);
  static const white = Color(0xFFffffff);
  static const transparentWhite = Color(0x99FFFFFF);
  static const shaderBottom = Color(0xFFed8674);
  static const gray = Color(0xFF778899);
  static const lightGray = Color(0xFFC0C0C0);
  static const blue = Color(0xFF1E90FF);
  static const transparentViolet = Color(0xff59502e82);
  static const transparent = Color(0x00000000);
  static const transparents = Color(0x3dffffff);
  static const primary = Color(0xff592F72);
  static const btnText = Color(0xff592F72);
  static const inputHintText = Color(0xff592F72);
  static const audioSelected = Color(0xffFAF1FF);
  static const purchaseDesc = Color(0xffB994DA);
  static const nightModeBG = Color(0xFF040826);
  static const nightBtnBg = Color(0xFF11123F);
  static const fixTop = Color(0xFFa0b2fa);
  static const fixBottom = Color(0xFFf8d9da);
  static const thumb = Color(0xFF673A7A);
  static const trackbarActive = Color(0xFF673A7A);
  static const loadingIndicator = Color(0xFFB994DA);
  static const timerNightBgButton = Color(0x0ffc50b2);
  static const nightButtonMenuIcons = Color(0xFFE4CDF8);
  //static const timerNightMenuIcon = Color(0xFFB994DA);

  //страница звуков dark mode
  static const instrumentTextColor = Color(0xFFCAB0DC);
  static const instrumentalBg = Color(0xFF1F1643);
  static const gradientInstrumentActive = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff592F72),
      Color(0xffFFD3DB),
    ],
  );

  // Gradients
  //Настройки времени ночной фон
  static const timerBgNight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff040826),
      Color(0xff462663),
    ],
  );
  // страница загрузки
  static const gradientSettingsPage = RadialGradient(
    colors: [AppColors.lightCream, AppColors.cream],
    radius: 0.6,
    center: Alignment(0.6, -0.2),
  );
  static const gradientMorningSun = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xffFFF0D9),
      Color(0xffFFB5C3),
    ],
  );
  static const gradientEveningSun = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xffFFF7EA),
      Color(0xffFFB8F8),
    ],
  );
  static const gradientLoadingMorningBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffAE80D6),
      Color(0xffD68FA8),
      Color(0xffFFE3BA),
    ],
  );
  static const gradientLoadingAfternooBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffFFE3BA),
      Color(0xffFFB5C3),
      Color(0xffB994DA),
    ],
  );
  static const gradientLoadingEveningBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffAE80D6),
      Color(0xffD68FA8),
    ],
  );
  static const gradientLoadingNightBg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff040826),
      Color(0xff140225),
    ],
  );

  static const gradientAfternoonSun = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xffFFFAFB),
      Color(0xffFFF0D9),
    ],
  );
  static const bgGradient1 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffF8D199),
      Color(0xffDA90AA),
      Color(0xffB994DA),
    ],
  );
  static const bgGradient2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffAE80D6),
      Color(0xffD892AB),
      Color(0xffE4C596),
    ],
  );
  static const bgGradient3 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffDA90AA),
      Color(0xffB994DA),
    ],
  );
  static const bgGradientPayments = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffB994DA),
      Color(0xffFFB5C3),
      Color(0xffFFF9EF),
    ],
  );
  //ночное чтение
  static const readingNightMode = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff53336C),
      Color(0xff2A1B4C),
    ],
  );
  // главное меню
  static const bgGradientMenu = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xffFFB5C3),
      Color(0xffAE80D6),
    ],
  );

  ///
  ///
  /// Таймеры
  ///
  ///

  static const bgGradientTimerMeditation = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffFFA0C2),
      Color(0xffFFE3BA),
    ],
  );
  static const progressGradientTimerMeditation = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xffFFE6C1),
      Color(0xffFFD3DB),
    ],
  );

  static const progressGradientTimerMeditationNight = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xff592F72),
      Color(0xff040826),
    ],
  );

  static const bgGradientTimerReading = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffB994DA),
      Color(0xffFFA8C1),
    ],
  );
  static const progressGradientTimerReading = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xff592F72),
      Color(0xffEEA6C8),
    ],
  );

  static const bgGradientTimerAffirmation = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffAE80D6),
      Color(0xffD68FA8),
      Color(0xffFFE3BA),
    ],
  );
  static const progressGradientTimerAffirmation = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xffB994DA),
      Color(0xff592F72),
    ],
  );

  static const bgGradientTimerDiary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffFFB5C3),
      Color(0xffAE80D6),
    ],
  );
  static const bgGradientTimerDiaryNote = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffFFF0D9),
      Color(0xffFFB5C3),
      Color(0xffB994DA),
    ],
  );
  static const progressGradientTimerDiary = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xffFFF0D9),
      Color(0xffB994DA),
    ],
  );
  static const progressGradientTimerDiaryNote = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xff592F72),
      Color(0xffEEA6C8),
    ],
  );

  static const bgGradientTimerFitness = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xff9F71C8),
      Color(0xffDA90AA),
    ],
  );
  static const progressGradientTimerFitness = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xff592F72),
      Color(0xffEEA6C8),
    ],
  );

  static const interviewGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xffE2AABE),
      Color(0xffB994DA),
    ],
  );

  // Форма входа
  static const bgGradientAuthPage = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffAE80D6),
      Color(0xffD68FA8),
      Color(0xffFFE3BA),
    ],
  );
}
