import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/faq/faq_menu.dart';
import 'package:morningmagic/pages/interview/interview2/questions/q_futures.dart';
import 'package:morningmagic/pages/interview/interview2/questions/q_yes_no_other.dart';
import 'package:morningmagic/pages/interview/interview2/questions/q_yes_no_other_if_yes.dart';
import 'package:morningmagic/resources/colors.dart';
import 'components/bg.dart';
import 'components/dot_panel.dart';
import 'interview_controller.dart';
import 'questions/q_one_field.dart';
import 'questions/thanks_screen.dart';

class Interview2Page extends StatefulWidget {
  @override
  _Interview2PageState createState() => _Interview2PageState();
}

class _Interview2PageState extends State<Interview2Page> {
  final Interview2Controller _controller = Get.put(Interview2Controller(10));

  final List<Widget> _pages = [
    qOneField('interview_2_q_1'.tr, 1),
    qOneField('interview_2_q_2'.tr, 2),
    qYesNoOther('interview_2_q_3'.tr, 3),
    qOneField('interview_2_q_4'.tr, 4),
    qFutures('interview_2_q_5'.tr, 5),
    qOneField('interview_2_q_6'.tr, 6),
    qYesNoOtherIfyes('interview_2_q_7'.tr, 'interview_2_q_7_sub_1'.tr, 7),
    qYesNoOtherIfyes('interview_2_q_8'.tr, 'interview_2_q_8_sub_1'.tr, 8),
    qOneField('interview_2_q_9'.tr, 9),
    thanksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(gradient: AppColors.Interview_Gradient),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            bg(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const BackButton(
                      color: Colors.white,
                    ),
                    dotPanel(_pages.length),
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: _controller.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _pages,
                  ),
                ),
              ],
            ),
            const Positioned(
              right: 20,
              top: 20,
              child: CloseAndGoFaqMenuButton(),
            ),
          ],
        ),
      ),
    ));
  }
}

class CloseAndGoFaqMenuButton extends StatelessWidget {
  const CloseAndGoFaqMenuButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(const FaqMenuPage()),
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
              )
            ]),
        child: const Icon(
          Icons.close,
          size: 15,
        ),
      ),
    );
  }
}
