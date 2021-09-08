import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/dialog/langDialog.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/pages/faq/faq_support.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

import 'controllers/faq_controller.dart';

class FaqMenuPage extends StatefulWidget {
  @override
  State createState() {
    return FAQStateScreen();
  }
}

class FAQStateScreen extends State<FaqMenuPage> {
  FaqController faqController = Get.put(FaqController());

  @override
  void initState() {
    super.initState();
    AnalyticService.screenView('Faq_Menu_Page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppGradientContainer(
        gradient: AppColors.Bg_Gradient_Menu,
        child: Stack(
          children: [
            clouds,
            SafeArea(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        backBtn(),
                        Spacer(),
                        langBtn(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'faq_menu_title'.tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Get.width * .07,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 30),
                    Wrap(
                      spacing: Get.width * .05,
                      runSpacing: Get.width * .05,
                      children: [
                        buildBtn(
                          'assets/images/faq/support.svg',
                          faqController.cat_support,
                          Get.width * .4,
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          onPressed: () => Get.to(FaqSupportPage()),
                        ),
                        buildBtn(
                          'assets/images/faq/question.svg',
                          faqController.cat_why,
                          Get.width * .25,
                          padding: const EdgeInsets.fromLTRB(20, 15, 10, 0),
                          onPressed: () =>
                              faqController.openCategory(faqController.cat_why),
                        ),
                        buildBtn(
                          'assets/images/faq/about_tarifs.svg',
                          faqController.cat_tarifs,
                          Get.width * .25,
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          onPressed: () => faqController
                              .openCategory(faqController.cat_tarifs),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget langBtn() => CupertinoButton(
        onPressed: () => showLangDialog(context),
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: Get.width * .35,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  'language'.tr,
                  style: TextStyle(
                    fontSize: Get.width * .040,
                    fontWeight: FontWeight.normal,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget backBtn() {
    return Align(
      alignment: Alignment.topLeft,
      child: PrimaryCircleButton(
        icon: Icon(Icons.arrow_back, color: AppColors.primary),
        onPressed: () => Get.back(),
        size: 40,
      ),
    );
  }

  Widget get clouds => Positioned(
        bottom: 0,
        child: Container(
          width: Get.width,
          child: Image.asset(
            'assets/images/faq/clouds.png',
            fit: BoxFit.cover,
          ),
        ),
      );

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
