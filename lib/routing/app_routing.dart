import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/loading/loadingPage.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/pages/screenUserDataInput.dart';
import 'package:morningmagic/pages/settings/settingsPage.dart';
import 'package:morningmagic/routing/route_values.dart';

class AppRouting {
  static const String initialRoute = splashRoute;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(
          builder: (_) => LoadingPage(),
        );
        break;
      case homePageRoute:
        return MaterialPageRoute(
            builder: (_) => MainMenuPage(), settings: settings);
        break;
      case settingsPageRoute:
        return MaterialPageRoute(builder: (_) => SettingsPage());
        break;
      case userInputDataPageRoute:
        return MaterialPageRoute(builder: (_) => UserDataInputScreen());
        break;
      default:
        return MaterialPageRoute(builder: (_) => MainMenuPage());
    }
  }

  static void navigateToHomeWithClearHistory() {
    Navigator.pushAndRemoveUntil(
      Get.context,
      MaterialPageRoute(builder: (context) => MainMenuPage()),
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
