import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/fitness/presentation/pages/fitness_main_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/animatedButton.dart';

class FitnessProgramScreen extends StatefulWidget {
  final int pageId;

  const FitnessProgramScreen({Key key, @required this.pageId})
      : super(key: key);

  @override
  State createState() {
    return FitnessProgramScreenState();
  }
}

class FitnessProgramScreenState extends State<FitnessProgramScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width, // match parent(all screen)
          height:
              MediaQuery.of(context).size.height, // match parent(all screen)
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.topGradient,
              AppColors.middleGradient,
              AppColors.bottomGradient
            ],
          )),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: Text(
                      'fitness'.tr,
                      style: const TextStyle(
                        fontSize: 32,
                        fontStyle: FontStyle.normal,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Text(
                    'fitness_title'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 19,
                      fontStyle: FontStyle.italic,
                      color: AppColors.violet,
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 70,
                child: AnimatedButton(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FitnessMainPage(pageId: widget.pageId)));
                }, 'next_button'.tr, 22, null, null),
              )
            ],
          ),
        ),
      ),
    );
  }
}
