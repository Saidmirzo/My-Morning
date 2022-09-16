import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';

class QuestionsDialog extends StatelessWidget {
  const QuestionsDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
              child: Container(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          Column(
            children: [
              const Spacer(),
              Container(
                width: Get.width - 41.34,
                padding: const EdgeInsets.all(27),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text.rich(
                        TextSpan(
                          text: 'mornings'.tr,
                          style: const TextStyle(
                            color: Color(0xff5F3777),
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            fontFamily: 'Montserrat',
                          ),
                          children: [
                            TextSpan(
                              text: 'complexs'.tr,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 42,
                    ),
                    FittedBox(
                      child: Text(
                        'Organize your morning routine with ease using the complex program'
                            .tr,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'komplex'.tr,
                        style: const TextStyle(
                          color: Color(0xff5F3777),
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                        ),
                        children: [
                          TextSpan(
                            text:
                                'is a consistent set of your morning daily rituals. '
                                    .tr,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    Text.rich(
                      TextSpan(
                        text:
                            'Customize the sequence and duration of your rituals in the Settings section.'
                                .tr,
                        children: [
                          const WidgetSpan(
                            child: Icon(Icons.keyboard_double_arrow_left,
                                size: 15),
                          ),
                          const WidgetSpan(
                            child: ImageIcon(
                              AssetImage(
                                'assets/images/home_menu/settings_icon_1.png',
                              ),
                              color: Color(0xff592F72),
                              size: 20,
                            ),
                          ),
                          TextSpan(
                            text: 'Settings section'.tr,
                            style: const TextStyle(
                                color: Color(0xff592F72),
                                fontWeight: FontWeight.w600),
                          ),
                          const WidgetSpan(
                            child: Icon(
                              Icons.keyboard_double_arrow_right,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const SizedBox(
                      height: 22.75,
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xff5F3777),
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'For instance'.tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            '1) Meditation - 5 minutes2) Fitness & Yoga - 15 minutes 3) Reading - 20 minutes'
                                .tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 3,
              )
            ],
          ),
        ],
      ),
    );
  }
}
