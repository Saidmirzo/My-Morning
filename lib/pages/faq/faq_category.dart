import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/pages/faq/faq_support.dart';
import 'package:morningmagic/pages/interview/interview1/interview_page.dart';
import 'package:morningmagic/pages/interview/interview2/interview_page.dart';
import 'package:morningmagic/pages/paywall/payment.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/other.dart';
import 'package:morningmagic/widgets/expansion_tile.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

import 'controllers/faq_controller.dart';

class FaqCategoryPage extends StatefulWidget {
  final String category;
  const FaqCategoryPage({Key key, this.category}) : super(key: key);
  @override
  _FaqCategoryPageState createState() => _FaqCategoryPageState();
}

class _FaqCategoryPageState extends State<FaqCategoryPage> {
  FaqController faqController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppGradientContainer(
        gradient: AppColors.Bg_gradient_auth_page,
        child: SafeArea(
          bottom: false,
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backBtn(),
                const SizedBox(height: 20),
                Text(
                  widget.category,
                  style: TextStyle(color: Colors.white, fontSize: Get.width * .065, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 30),
                questionList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget questionList() {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: getList(),
      ),
    );
  }

  List<Widget> getList() {
    var list = faqController.getQuestionsByCategory(widget.category);
    List<Widget> ll = List.generate(
      list.length,
      (index) => MyExpansionTile(
        headerColor: Colors.white,
        backgroundColor: Color(0xff9A6393),
        childrenPadding: const EdgeInsets.all(10),
        title: Text(list[index].entries.first.key,
            style: TextStyle(
              fontSize: Get.width * .04,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            )),
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Html(
              data: list[index].entries.first.value,
              style: {
                "p": Style(
                  fontSize: FontSize(Get.width * .036),
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                "a": Style(
                  color: Colors.lightBlue[300],
                  textDecoration: TextDecoration.none,
                ),
                // "img": Style(width: 20, height: 20)
              },
              shrinkWrap: true,
              onLinkTap: (url, cntx, map, element) {
                if (url.contains('mailto')) openEmail(url.split(':').last, '');
                if (url.contains('screen')) {
                  print('open screen: ${url.split(':').last}');
                  if (url.split(':').last == 'support')
                    Get.to(FaqSupportPage());
                  else if (url.split(':').last == 'tarifs')
                    Get.to(PaymentPage());
                  else if (url.split(':').last == 'unsubscribe') Get.to(Interview2Page());
                }
              },
            ),
            width: Get.width,
          ),
        ],
      ),
    );
    if (widget.category == faqController.cat_tarifs)
      ll.add(
        GestureDetector(
          onTap: () => Get.to(FaqSupportPage()),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), color: Colors.white),
            child: Text(
              'faq_tarifs_title_6'.tr,
              style: TextStyle(
                fontSize: Get.width * .04,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      );
    return ll;
  }

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
}
