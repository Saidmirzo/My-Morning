import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/loading/loadingPage.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/pages/music_instrument/music_instrument_page.dart';
import 'package:morningmagic/pages/nigth/nigth.dart';
import 'package:morningmagic/pages/settings/settingsPage.dart';
import 'package:morningmagic/pages/welcome/welcome_page.dart';
import 'package:morningmagic/routing/route_values.dart';
import 'package:morningmagic/services/injections.dart';

import '../storage.dart';

class AppRouting {
  static const String initialRoute = splashRoute;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(
          builder: (_) => LoadingPage(abTestService: injection()),
        );

      case homePageRoute:
        return MaterialPageRoute(
            builder: (_) => const MainMenuPage(), settings: settings);

      case settingsPageRoute:
        return MaterialPageRoute(builder: (_) => const SettingsPage());

      case welcomePageRoute:
        return MaterialPageRoute(builder: (_) => const WelcomePage());

      case mainMenuNigthPage:
        return MaterialPageRoute(builder: (_) => const MainMenuNightPage());

      case musicInstrumentsPageRoute:
        return MaterialPageRoute(builder: (_) => MusicInstrumentPage());

      default:
        return MaterialPageRoute(builder: (_) => const MainMenuPage());
    }
  }

  static void navigateToHomeWithClearHistory({MenuState menuStateValue}) {
    if (menuStateValue != null) menuState = menuStateValue;
    Navigator.pushAndRemoveUntil(
      Get.context,
      MaterialPageRoute(
          builder: (context) => menuState == MenuState.MORNING
              ? const MainMenuPage()
              : const MainMenuNightPage()),
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

Route createRoute(dynamic nabigationClass) {
  dynamic navigationClass = nabigationClass;
  return PageRouteBuilder(
    transitionDuration: const Duration(microseconds: 1000),
    pageBuilder: (context, animation, secondaryAnimation) => navigationClass,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // const begin = Offset(1, 0);
      const end = Offset(0, 0);
      const curve = Curves.ease;
      var tween = Tween(begin: end, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
