import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/pages/payment.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:morningmagic/services/admob.dart';

import '../resources/colors.dart';
import 'askedQuestionsScreen.dart';

class Reclama extends StatefulWidget {
  @override
  _ReclamaState createState() => _ReclamaState();
}

class _ReclamaState extends State<Reclama> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width:
                MediaQuery.of(context).size.width, // match parent(all screen)
            height:
                MediaQuery.of(context).size.height, // match parent(all screen)
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.repeated,
                colors: [
                  AppColors.TOP_GRADIENT,
                  AppColors.MIDDLE_GRADIENT,
                  AppColors.BOTTOM_GRADIENT,
                ],
              ),
            ),
            child: Container(),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 60,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaymentPage()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'buy_free'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.VIOLET,
                        fontFamily: 'rex',
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'three_days'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.VIOLET,
                        fontFamily: 'rex',
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 + 30,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AskedQuestionsScreen()));
                admobService.showInterstitial();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('my_progress'.tr(),
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.VIOLET,
                          fontSize: 20,
                          fontFamily: 'rex',
                          fontWeight: FontWeight.normal,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_showAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        titleTextStyle: TextStyle(
          backgroundColor: AppColors.SHADER_BOTTOM,
        ),
        titlePadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(0),
        buttonPadding: EdgeInsets.all(0),
        backgroundColor: AppColors.BOTTOM_GRADIENT,
        // title: Container(
        //   color: AppColors.VIOLET,
        //   child: Text(
        //     'Сообщение !',
        //     style: TextStyle(
        //       color: AppColors.VIOLET,
        //       backgroundColor: AppColors.SHADER_BOTTOM,
        //       fontSize: 30,
        //     ),
        //   ),
        // ),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Вы уверены ?',
                  style: TextStyle(
                    color: AppColors.VIOLET,
                    fontSize: 40,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    child: Text(
                      "Да",
                      style: TextStyle(
                        color: AppColors.FIX_TOP,
                        fontSize: 40,
                      ),
                    ),
                    onPressed: () {
                      //Put your code here which you want to execute on Yes button click.
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "Нет",
                      style: TextStyle(
                        color: AppColors.FIX_TOP,
                        fontSize: 40,
                      ),
                    ),
                    onPressed: () {
                      //Put your code here which you want to execute on No button click.
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
