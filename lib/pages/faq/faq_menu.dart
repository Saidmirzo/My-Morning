import 'dart:io';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/user/user.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/pages/interview/interview1/interview_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/widgets/lang_btn.dart';
import 'controllers/faq_controller.dart';

class FaqMenuPage extends StatefulWidget {
  const FaqMenuPage({Key key}) : super(key: key);

  @override
  State createState() {
    return FAQStateScreen();
  }
}

class FAQStateScreen extends State<FaqMenuPage> {
  TextEditingController nameController;
  String getInitialValueForNameField() {
    String result = "";
    User user = MyDB().getBox().get(MyResource.USER_KEY);
    if (user != null) {
      result = user.name;
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    AnalyticService.screenView('Faq_Menu_Page');
    nameController = TextEditingController(text: getInitialValueForNameField());
  }

  @override
  Widget build(BuildContext context) {
    double titleFontSize = Get.width * 0.055;
    return Scaffold(
      body: SingleChildScrollView(
        child: AppGradientContainer(
          gradient: AppColors.Bg_Gradient_Menu,
          child: Stack(
            children: [
              clouds,
              SafeArea(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 40,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                backBtn(),
                                const Spacer(),
                                langBtn(context),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Colors.white),
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 11, bottom: 11, right: 20, left: 20),
                                child: TextField(
                                  onChanged: (value) {
                                    if (value != null && value.isNotEmpty) {
                                      MyDB().getBox().put(
                                          MyResource.USER_KEY, User(value));
                                    } else {
                                      MyDB()
                                          .getBox()
                                          .put(MyResource.USER_KEY, User(''));
                                    }
                                  },
                                  controller: nameController,
                                  minLines: 1,
                                  maxLines: 1,
                                  cursorColor: AppColors.VIOLET,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    fontStyle: FontStyle.normal,
                                    color: AppColors.VIOLET,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'enter_your_name'.tr,
                                      hintStyle: TextStyle(
                                          color: AppColors.VIOLET,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w600,
                                          fontSize: Get.width * .040)),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'faq_menu_title'.tr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Get.width * .07,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 30),
                            const MyWidget(),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 6,
                                    blurRadius: 60,
                                    offset: Offset(0, 0),
                                  )
                                ],
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.VIOLET_ONB,
                                  minimumSize: Size(double.infinity,
                                      Platform.isIOS ? 70 : 60),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {
                                  AppMetrica.reportEvent('poll_screen');
                                  Get.to(InterviewPage());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 25),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Text(
                                        "support_text_title".tr,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const Icon(Icons.arrow_forward, size: 25),
                                  ],
                                ),
                              ),
                            ),
                            // const SizedBox(height: 10),
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: Text(
                            //     "support_text_body".tr,
                            //     style: const TextStyle(fontSize: 12),
                            //     textAlign: TextAlign.center,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   left: 0,
                    //   right: 0,
                    //   child: BottomMenu(),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget backBtn() {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        child: const Icon(
          Icons.west,
          color: Colors.white,
          size: 30,
        ),
        onTap: () => Get.back(),
      ),
    );
  }

  Widget get clouds => Positioned(
        bottom: 0,
        child: SizedBox(
          width: Get.width,
          child: Image.asset(
            'assets/images/faq/clouds.png',
            fit: BoxFit.cover,
          ),
        ),
      );
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    Get.delete<FaqController>();
    FaqController faqController = Get.put(FaqController());
    return Wrap(
      spacing: Get.width * .05,
      runSpacing: Get.width * .05,
      children: [
        // buildBtn(
        //   'assets/images/faq/support.svg',
        //   faqController.cat_support,
        //   Get.width * .4,
        //   padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
        //   onPressed: () => Get.to(FaqSupportPage()),
        // ),
        buildBtn(
          'assets/images/faq/question.svg',
          faqController.cat_why,
          Get.width * .25,
          padding: const EdgeInsets.fromLTRB(20, 15, 10, 0),
          onPressed: () => faqController.openCategory(faqController.cat_why),
        ),
        buildBtn(
          'assets/images/faq/about_tarifs.svg',
          faqController.cat_tarifs,
          Get.width * .25,
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          onPressed: () => faqController.openCategory(faqController.cat_tarifs),
        ),
      ],
    );
  }

  Widget buildBtn(
    String img,
    String title,
    double width, {
    EdgeInsets padding = const EdgeInsets.fromLTRB(30, 10, 0, 0),
    Function onPressed,
  }) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(0),
      child: Container(
        width: Get.width * .4,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: padding,
                child: SvgPicture.asset(img),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: Get.width * .045,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
