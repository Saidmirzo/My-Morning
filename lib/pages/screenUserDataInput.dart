import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morningmagic/db/hive.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:morningmagic/my_const.dart';
import 'package:morningmagic/widgets/my_checkbox.dart';
import 'package:morningmagic/widgets/my_url.dart';
import '../db/model/user/user.dart';
import '../db/resource.dart';
import '../pages/settingsPage.dart';
import '../resources/colors.dart';
import '../widgets/animatedButton.dart';
import '../widgets/language_switcher.dart';

class UserDataInputScreen extends StatefulWidget {
  @override
  State createState() {
    return UserDataInputScreenState();
  }
}

class UserDataInputScreenState extends State<UserDataInputScreen> {
  TextEditingController myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            width:
                MediaQuery.of(context).size.width, // match parent(all screen)
            height: MediaQuery.of(context)
                .size
                .height, // match parent(all screen)
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
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 50, right: 50),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: 10,
                                      top:
                                          MediaQuery.of(context).size.height /
                                              3),
                                  child: Text(
                                    'your_name'.tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: "sans-serif",
                                      fontStyle: FontStyle.normal,
                                      color: AppColors.VIOLET,
                                    ),
                                  ),
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(30.0),
                                      color: AppColors.TRANSPARENT_WHITE,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 15, right: 15, bottom: 5),
                                      child: TextFormField(
                                        controller: myController,
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty) {
                                            return 'name'.tr();
                                          }
                                          return null;
                                        },
                                        minLines: 1,
                                        maxLines: 1,
                                        cursorColor: AppColors.VIOLET,
                                        keyboardType: TextInputType.text,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "sans-serif",
                                            fontStyle: FontStyle.normal,
                                            color: AppColors.VIOLET,
                                            decoration: TextDecoration.none),
                                        decoration: new InputDecoration(),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          LanguageSwitcher(Alignment.center),
                          const SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            // bottom:MediaQuery.of(context).size.height / 28),
                            child: ButtonTheme(
                              minWidth: 180.0,
                              height: 50.0,
                              child: AnimatedButton(() {
                                if (_formKey.currentState.validate()) {
                                  saveNameToBox();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SettingsPage()),
                                  );
                                }
                              },
                                'sans-serif',
                                'next_button'.tr(),
                                null, null, null
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }

  void saveNameToBox() async{
    if (myController.text != null && myController.text.isNotEmpty) {
      await MyDB().getBox().put(MyResource.USER_KEY, User(myController.text));
      print(myController.text);
    }
  }
}
