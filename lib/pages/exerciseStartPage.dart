import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:morningmagic/pages/timerPage.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/animatedButton.dart';

class ExerciseStartPage extends StatefulWidget {
  final int pageId;
  final String title;
  final String desc;
  final Function btnNext;

  const ExerciseStartPage({
    Key key,
    @required this.pageId,
    @required this.title,
    @required this.desc,
    @required this.btnNext
  }) : super(key: key);

  @override
  State createState() => ExerciseStartPageState();
}

class ExerciseStartPageState extends State<ExerciseStartPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.TOP_GRADIENT,
                AppColors.MIDDLE_GRADIENT,
                AppColors.BOTTOM_GRADIENT
              ],
            )
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 35),
                    child: Text(
                      widget.title.tr(),
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: "rex",
                        fontStyle: FontStyle.normal,
                        color: AppColors.WHITE,
                      ),
                    ),
                  ),
                  Text(
                    widget.desc.tr(),
                    style: TextStyle(
                      fontSize: 19,
                      fontFamily: "JMH",
                      fontStyle: FontStyle.italic,
                      color: AppColors.VIOLET,
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 60,
                child: ButtonTheme(
                  minWidth: 170.0,
                  height: 50.0,
                  child: AnimatedButton(
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimerPage(
                            pageId: widget.pageId ?? 5
                          )
                        )
                      );
                    },
                    'rex',
                    'next_button'.tr(),
                    null, null, null
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    Navigator.pushNamedAndRemoveUntil(context, '/start', (r) => false);
    return false;
  }
}
