import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';

import 'components/bg.dart';
import 'components/dot_panel.dart';
import 'interview_controller.dart';
import 'questions/question1.dart';
import 'questions/question10.dart';
import 'questions/question11.dart';
import 'questions/question12.dart';
import 'questions/question13.dart';
import 'questions/question2.dart';
import 'questions/question3.dart';
import 'questions/question4.dart';
import 'questions/question5.dart';
import 'questions/question6.dart';
import 'questions/question7.dart';
import 'questions/question8.dart';
import 'questions/question9.dart';
import 'questions/thanks_screen.dart';

class InterviewPage extends StatefulWidget {
  @override
  _InterviewPageState createState() => _InterviewPageState();
}

class _InterviewPageState extends State<InterviewPage> {
  InterviewController _controller = Get.put(InterviewController(14));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: AppColors.Interview_Gradient),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            bg(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                dotPanel(_pages.length),
                Expanded(
                  child: PageView(
                    controller: _controller.pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: _pages,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  List<Widget> _pages = [
    q1(),
    q2(),
    q3(),
    q4(),
    q5(),
    q6(),
    q7(),
    q8(),
    q9(),
    q10(),
    q11(),
    q12(),
    q13(),
    thanksScreen(),
  ];
}
