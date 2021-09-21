import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/loading/loadingPage.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/pages/music_instrument/music_instrument_page.dart';
import 'package:morningmagic/pages/nigth/nigth.dart';
import 'package:morningmagic/pages/welcome/slides/name_input_slide.dart';
import 'package:morningmagic/pages/settings/settingsPage.dart';
import 'package:morningmagic/pages/welcome/welcome_page.dart';
import 'package:morningmagic/routing/route_values.dart';

import '../storage.dart';

class AppRouting {
  static const String initialRoute = splashRoute;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(
          builder: (_) => LoadingPage(),
        );

      case homePageRoute:
        return MaterialPageRoute(
            builder: (_) => MainMenuPage(), settings: settings);

      case settingsPageRoute:
        return MaterialPageRoute(builder: (_) => SettingsPage());

      case welcomePageRoute:
        return MaterialPageRoute(builder: (_) => WelcomePage());

      case mainMenuNigthPage:
        return MaterialPageRoute(builder: (_) => MainMenuNightPage());

      case musicInstrumentsPageRoute:
        return MaterialPageRoute(builder: (_) => MusicInstrumentPage());

      default:
        return MaterialPageRoute(builder: (_) => MainMenuPage());
    }
  }

  static void navigateToHomeWithClearHistory({MenuState menuStateValue}) {
    if (menuStateValue != null) menuState = menuStateValue;
    Navigator.pushAndRemoveUntil(
      Get.context,
      MaterialPageRoute(
          builder: (context) => menuState == MenuState.MORNING
              ? MainMenuPage()
              : MainMenuNightPage()),
      (Route<dynamic> route) => false,
    );
  }

  static void replace(Widget page) {
    Navigator.pushAndRemoveUntil(
      Get.context,
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false,
    );
  }
}
