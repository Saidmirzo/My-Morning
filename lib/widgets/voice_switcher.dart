import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/shared_preferences.dart';

class VoiceSwitcher extends StatefulWidget {
  @override
  VoiceSwitcherState createState() {
    return VoiceSwitcherState();
  }
}

class VoiceSwitcherState extends State<VoiceSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'player_voice'.tr,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: AppColors.VIOLET,
                  fontStyle: FontStyle.normal,
                  fontSize: 26),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: FutureBuilder(
                      future: CustomSharedPreferences().getVoice(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> value) {
                        return Text('female'.tr,
                            style: TextStyle(
                              color: chooseWomanColor(
                                  value.data ?? true),
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                            ));
                      }),
                ),
                Container(
                  child: FutureBuilder(
                    future: CustomSharedPreferences().getVoice(),
                    builder: (BuildContext context, AsyncSnapshot<bool> value) {
                      return Switch(
                        value: value.data ?? true,
                        inactiveThumbColor: AppColors.PINK,
                        inactiveTrackColor: AppColors.PINK,
                        activeColor: AppColors.BLUE,
                        activeTrackColor: AppColors.BLUE,
                        onChanged: (bool value) {
                          setState(() {
                            CustomSharedPreferences().setVoice(value);
                          });
                        },
                      );
                    },
                  ),
                ),
                Container(
                  child: FutureBuilder(
                      future: CustomSharedPreferences().getVoice(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> value) {
                        return Text('male'.tr,
                            style: TextStyle(
                              color: chooseManColor(
                                  value.data ?? true),
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
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

  Color chooseWomanColor(bool value) {
    return value ? AppColors.TRANSPARENT_WHITE : AppColors.PINK;
  }

  Color chooseManColor(bool value) {
    return value ? AppColors.BLUE : AppColors.TRANSPARENT_WHITE;
  }
}
