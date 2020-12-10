import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/analyticService.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/services/menu_service.dart';

import '../pages/screenProgress.dart';
import '../resources/colors.dart';
import '../widgets/animatedButton.dart';
import 'askedQuestionsScreen.dart';

class StartScreen extends StatefulWidget {
  @override
  State createState() {
    return StartScreenState();
  }
}

class StartScreenState extends State<StartScreen> {
  int dayHolderSize;
  MenuService menuService = MenuService();

  @override
  void initState() {
    menuService.init(context);
    menuService.getDayHolderSize().then((int value) {
      dayHolderSize = value;
    });
    AnalyticService.screenView('menu_page');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width, // match parent(all screen)
          // height: MediaQuery.of(context).size.height, // match parent(all screen)
          decoration: BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.TOP_GRADIENT,
              AppColors.MIDDLE_GRADIENT,
              AppColors.BOTTOM_GRADIENT
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // Начать
              AnimatedButton(
                () => menuService.btnStart(),
                'sans-serif',
                'start'.tr(),
                null, null, null
              ),
              SizedBox(height: 15),
              // Прогресс
              AnimatedButton(() => menuService.btnProgress(choseWidget()),
                "sans-serif",
                'progress_item'.tr(),
                null, null, null
              ),
              SizedBox(height: 15),
              // Настройки
              AnimatedButton(() => menuService.btnSettings(),
                "sans-serif",
                'settings'.tr(),
                null, null, null
              ),
              SizedBox(height: 15),
              // Помощь
              AnimatedButton(
                () => menuService.btnFaq(),
                "sans-serif",
                'faq'.tr(),
                null, null, null
              ),
              SizedBox(height: MediaQuery.of(context).size.height/10),
            ],
          ),
        ),
      ),
    );
  }

  Widget choseWidget() {
    if (dayHolderSize != null && dayHolderSize > 0) {
      return AskedQuestionsScreen();
    } else {
      return ProgressScreen();
    }
  }
}
