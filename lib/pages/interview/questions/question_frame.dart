import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/interview/components/title_question.dart';

import '../../../widgets/primary_circle_button.dart';
import '../interview_controller.dart';

class QuestionFrame extends StatelessWidget {
  final String title;
  final Widget child;
  final int index;
  const QuestionFrame(
      {Key key, this.title = '', @required this.child, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    InterviewController _controller = Get.find();
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titleQuestion(title),
            const SizedBox(height: 20),
            child,
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return ![0, _controller.countPages - 1]
                          .contains(_controller.currQuestion.value)
                      ? PrimaryCircleButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: _controller.slideBack,
                          size: 50)
                      : SizedBox();
                }),
                PrimaryCircleButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      _controller.next(index);
                    },
                    icon: Icon(Icons.arrow_forward),
                    size: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
