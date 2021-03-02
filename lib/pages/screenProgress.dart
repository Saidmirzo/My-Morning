import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/routing/app_routing.dart';

import '../resources/colors.dart';
import '../widgets/animatedButton.dart';

class ProgressScreen extends StatefulWidget {
  @override
  State createState() {
    return ProgressScreenState();
  }
}

class ProgressScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Center(
          child: Container(
            width:
                MediaQuery.of(context).size.width, // match parent(all screen)
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
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 35),
                      child: Text(
                        'progress'.tr(),
                        style: TextStyle(
                          fontSize: 32,
                          fontStyle: FontStyle.normal,
                          fontFamily: "sans-serif-black",
                          color: AppColors.WHITE,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'progress_title'.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: "sans-serif",
                          fontStyle: FontStyle.normal,
                          color: AppColors.VIOLET,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 75,
                  child: AnimatedButton(() {
                    AppRouting.navigateToHomeWithClearHistory(context);
                  }, 'sans-serif', 'back_button'.tr(), 22, null, null),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    AppRouting.navigateToHomeWithClearHistory(context);
    return false;
  }
}
