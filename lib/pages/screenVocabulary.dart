import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../pages/screenNote.dart';
import '../pages/success/screenTimerRecordSuccess.dart';
import '../resources/colors.dart';
import '../widgets/animatedButton.dart';

class VocabularyScreen extends StatefulWidget {
  @override
  State createState() {
    return VocabularyScreenState();
  }
}

class VocabularyScreenState extends State<VocabularyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width:
              MediaQuery.of(context).size.width, // match parent(all screen)
          height:
              MediaQuery.of(context).size.height, // match parent(all screen)
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
              Positioned(
                bottom: (MediaQuery.of(context).size.height / 2),
                child: Text(
                  'diary'.tr,
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: "rex",
                    fontStyle: FontStyle.normal,
                    color: AppColors.WHITE,
                  ),
                ),
              ),
              Positioned(
                bottom: (MediaQuery.of(context).size.height / 2) -
                    (MediaQuery.of(context).size.height / 2 / 2.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 15),
                      child: AnimatedButton(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TimerRecordSuccessScreen()));
                      },
                          'rex',
                          'voice_record'.tr,
                          20,
                          220.0,
                          null),
                    ),
                    AnimatedButton(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteScreen()));
                    },
                        'rex',
                        'written_record'.tr,
                        20,
                        220.0,
                        null)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
