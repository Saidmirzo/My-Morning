import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/route_values.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/widgets/animatedButton.dart';

class FAQScreen extends StatefulWidget {
  @override
  State createState() {
    return FAQStateScreen();
  }
}

class FAQStateScreen extends State<FAQScreen> {
  @override
  void initState() {
    super.initState();
    AnalyticService.screenView('FAQ_page');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Center(
          child: Container(
              width:
                  MediaQuery.of(context).size.width, // match parent(all screen)
              height: MediaQuery.of(context)
                  .size
                  .height, // match parent(all screen)
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
              child: LayoutBuilder(
                builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 9,
                              bottom: MediaQuery.of(context).size.height / 15,
                            ),
                            child: Text(
                              "FAQ",
                              style: TextStyle(
                                fontSize: 32,
                                fontStyle: FontStyle.normal,
                                color: AppColors.WHITE,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                bottom:
                                    MediaQuery.of(context).size.height / 15),
                            child: Html(
                                data: 'faq_desc'.tr,
                                defaultTextStyle: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal,
                                  color: AppColors.VIOLET,
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: AnimatedButton(() {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, homePageRoute, (r) => false);
                            }, 'back_button'.tr, 19, null, null),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    AppRouting.navigateToHomeWithClearHistory();
    return false;
  }
}
