import 'package:flutter/material.dart';

class AppColors {
  static const LIGHT_VIOLET = Color(0xFF7948c2);
  static const VIOLET = Color(0xFF502e82);
  static const CREAM = Color(0xFFe9b7b3);
  static const LIGHT_CREAM = Color(0xFFf6e4e2);
  static const PINK = Color(0xFFc24e95);
  static const TOP_GRADIENT = Color(0xFF8aa9ff);
  static const MIDDLE_GRADIENT = Color(0xFFd5c7e9);
  static const BOTTOM_GRADIENT = Color(0xFFfde0d4);
  static const WHITE = Color(0xFFffffff);
  static const TRANSPARENT_WHITE = Color(0x99FFFFFF);
  static const SHADER_BOTTOM = Color(0xFFed8674);
  static const GRAY = Color(0xFF778899);
  static const LIGHT_GRAY = Color(0xFFC0C0C0);
  static const BLUE = Color(0xFF1E90FF);
  static const TRANSPARENT_VIOLET = Color(0xFF59502e82);
  static const TRANSPARENT = Color(0);
  static const TRANSPARENTS = Color(0x3dffffff);
  static const primary = Color(0xff592F72);
  static const btnText = Color(0xff592F72);
  static const inputHintText = Color(0xff592F72);
  static const audiuSelected = Color(0xffFAF1FF);
  static const purchaseDesc = Color(0xffB994DA);
  static const nightModeBG = Color(0xFF040826);
  static const nightBtnBg = Color(0xFF11123F);
  static const FIX_TOP = Color(0xFFa0b2fa);
  static const FIX_BOTTOM = Color(0xFFf8d9da);
  static const THUMB = Color(0xFF673A7A);
  static const TRACKBAR_ACTIVE = Color(0xFF673A7A);
  static const TRACKBAR_UNACTIVE = Color(0xFFB994DA);
  //страница звуков dark mode
  static const instrumentalBg = Color(0xFF1F1643);
  static const gradient_instrument_active = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xff592F72),
      const Color(0xffFFD3DB),
    ],
  );

  // Gradients
  // страница загрузки
  static const gradient_settings_page = RadialGradient(
    colors: [AppColors.LIGHT_CREAM, AppColors.CREAM],
    radius: 0.6,
    center: Alignment(0.6, -0.2),
  );
  static const gradient_morning_sun = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xffFFF0D9),
      const Color(0xffFFB5C3),
    ],
  );
  static const gradient_evening_sun = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xffFFF7EA),
      const Color(0xffFFB8F8),
    ],
  );
  static const gradient_loading_morning_bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xffAE80D6),
      const Color(0xffD68FA8),
      const Color(0xffFFE3BA),
    ],
  );
  static const gradient_loading_afternoon_bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xffFFE3BA),
      const Color(0xffFFB5C3),
      const Color(0xffB994DA),
    ],
  );
  static const gradient_loading_evening_bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xffAE80D6),
      const Color(0xffD68FA8),
    ],
  );
  static const gradient_loading_night_bg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xff040826),
      const Color(0xff140225),
    ],
  );

  static const gradient_afternoon_sun = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xffFFFAFB),
      const Color(0xffFFF0D9),
    ],
  );
  static const Bg_Gradient_1 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xffF8D199),
      const Color(0xffDA90AA),
      const Color(0xffB994DA),
    ],
  );
  static const Bg_Gradient_2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xffAE80D6),
      const Color(0xffD892AB),
      const Color(0xffE4C596),
    ],
  );
  static const Bg_Gradient_3 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xffDA90AA),
      const Color(0xffB994DA),
    ],
  );
  static const Bg_Gradient_Payments = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xffB994DA),
      const Color(0xffFFB5C3),
      const Color(0xffFFF9EF),
    ],
  );
  // главное меню
  static const Bg_Gradient_Menu = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xffFFB5C3),
      const Color(0xffAE80D6),
    ],
  );

  ///
  ///
  /// Таймеры
  ///
  ///

  static const Bg_Gradient_Timer_Meditation = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xffFFA0C2),
      const Color(0xffFFE3BA),
    ],
  );
  static const Progress_Gradient_Timer_Meditation = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      const Color(0xffFFE6C1),
      const Color(0xffFFD3DB),
    ],
  );

  static const Bg_Gradient_Timer_Reading = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xffB994DA),
      const Color(0xffFFA8C1),
    ],
  );
  static const Progress_Gradient_Timer_Reading = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      const Color(0xff592F72),
      const Color(0xffEEA6C8),
    ],
  );

  static const Bg_Gradient_Timer_Affirmation = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xffAE80D6),
      const Color(0xffD68FA8),
      const Color(0xffFFE3BA),
    ],
  );
  static const Progress_Gradient_Timer_Affirmation = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      const Color(0xffB994DA),
      const Color(0xff592F72),
    ],
  );

  static const Bg_Gradient_Timer_Diary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xffFFB5C3),
      const Color(0xffAE80D6),
    ],
  );
  static const Bg_Gradient_Timer_Diary_Note = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xffFFF0D9),
      const Color(0xffFFB5C3),
      const Color(0xffB994DA),
    ],
  );
  static const Progress_Gradient_Timer_Diary = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      const Color(0xffFFF0D9),
      const Color(0xffB994DA),
    ],
  );
  static const Progress_Gradient_Timer_Diary_Note = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      const Color(0xff592F72),
      const Color(0xffEEA6C8),
    ],
  );

  static const Bg_Gradient_Timer_Fitnes = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xff9F71C8),
      const Color(0xffDA90AA),
    ],
  );
  static const Progress_Gradient_Timer_Fitnes = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      const Color(0xff592F72),
      const Color(0xffEEA6C8),
    ],
  );

  static const Interview_Gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xffE2AABE),
      const Color(0xffB994DA),
    ],
  );

  // Форма входа
  static const Bg_gradient_auth_page = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xffAE80D6),
      const Color(0xffD68FA8),
      const Color(0xffFFE3BA),
    ],
  );
}
