import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/shared_preferences.dart';

class LanguageSwitcher extends StatefulWidget {
  final Alignment alignment;

  LanguageSwitcher(this.alignment);

  @override
  LanguageSwitcherState createState() {
    return LanguageSwitcherState();
  }
}

class LanguageSwitcherState extends State<LanguageSwitcher> {
  BuildContext rootContext;
  @override
  Widget build(BuildContext context) {
    rootContext = context;
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 5),
          child: Align(
            alignment: widget.alignment,
            child: Text(
              'language'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.VIOLET,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'sans-serif-black',
                  fontSize: 26),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: FutureBuilder(
                      future: CustomSharedPreferences().getLanguage(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> value) {
                        return Text('ru',
                            style: TextStyle(
                              color: chooseRusColor(
                                  value.data == null ? true : value.data),
                              fontStyle: FontStyle.normal,
                              fontSize: 25,
                              fontFamily: 'sans-serif',
                            ));
                      }),
                ),
                Container(
                  child: Switch( 
                    value: context.locale.languageCode =='ru' ? false : true,
                    inactiveThumbColor: AppColors.PINK,
                    inactiveTrackColor: AppColors.PINK,
                    activeColor: AppColors.BLUE,
                    activeTrackColor: AppColors.BLUE,
                    onChanged: (bool value) {
                      setState(() {
                        Locale ru = Locale('ru');
                        Locale en = Locale('en');
                        if (context.locale==en) {
                          context.locale = ru;
                        } else {
                          context.locale = en;
                        }
                      });
                    },
                  ),
                ),
                Container(
                  child: FutureBuilder(
                      future: CustomSharedPreferences().getLanguage(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> value) {
                        return Text('eng',
                            style: TextStyle(
                              color: chooseEngColor(
                                  value.data == null ? false : value.data),
                              fontStyle: FontStyle.normal,
                              fontSize: 25,
                              fontFamily: 'sans-serif',
                            ));
                      }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color chooseRusColor(bool value) {
    return value ? AppColors.TRANSPARENT_WHITE : AppColors.PINK;
  }

  Color chooseEngColor(bool value) {
    return value ? AppColors.BLUE : AppColors.TRANSPARENT_WHITE;
  }
}