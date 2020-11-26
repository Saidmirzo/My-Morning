import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import '../pages/screenExerciseDesk.dart';
import '../resources/colors.dart';
import '../widgets/animatedButton.dart';
import 'exerciseDetails.dart';

class FitnessScreen extends StatefulWidget {
  final int pageId;

  const FitnessScreen({Key key, @required this.pageId}) : super(key: key);
  
  @override
  State createState() {
    return FitnessScreenState();
  }
}

class FitnessScreenState extends State<FitnessScreen> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width, // match parent(all screen)
          height: MediaQuery.of(context).size.height, // match parent(all screen)
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
                  'fitness'.tr(),
                  style: TextStyle(
                    fontSize: 32,
                    fontStyle: FontStyle.normal,
                    fontFamily: "rex",
                    color: AppColors.WHITE,
                  ),
                ),
              ),
              Positioned(
                bottom: (MediaQuery.of(context).size.height / 2) - (MediaQuery.of(context).size.height / 2 / 2.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 25),
                      child: AnimatedButton(() {
                          Navigator.push( context, MaterialPageRoute(builder: (context) => ExerciseDetails(stepId: 0, isCustomProgramm: false, pageId: widget.pageId)));
                        },
                        'rex',
                        'fitness_program'.tr(),
                        20,
                        220,
                        null),
                    ),
                    AnimatedButton(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ExerciseDeskScreen(pageId: widget.pageId)));
                    },
                    'rex',
                    'fitness_my_program'.tr(),
                    20,
                    220,
                    null),
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
