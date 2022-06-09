import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/pages/affirmation/components/bg.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/styles.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

import 'custom_methodic_page.dart';

class CustomMethodicStartPage extends StatefulWidget {
  final String id;
  final int pageId;
  CustomMethodicStartPage({Key key, @required this.id, @required this.pageId}) : super(key: key);

  @override
  State<CustomMethodicStartPage> createState() => _CustomMethodicStartPageState();
}

class _CustomMethodicStartPageState extends State<CustomMethodicStartPage> {
  var _info;
  @override
  void initState() {
    _info = MyDB().getBox().get(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(gradient: AppColors.Bg_Gradient_2),
          width: Get.width,
          height: Get.height,
          child: SafeArea(
            bottom: false,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                bg(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: PrimaryCircleButton(
                        icon: Icon(Icons.arrow_back, color: AppColors.primary),
                        onPressed: () {
                          // if (widget.fromHomeMenu) return Get.off(MainMenuPage(), opaque: true);
                          // OrderUtil().getPreviousRouteById(TimerPageId.Affirmation).then((value) {
                          //   Get.off(value);
                          // });
                        },
                      ),
                    ),
                    SizedBox(height: Get.height * 0.15),
                    Text(_info.title ?? "", style: AppStyles.treaningTitle),
                    SizedBox(height: Get.height * 0.05),
                    Text('your_own_ritual'.tr, style: AppStyles.treaningSubtitle, textAlign: TextAlign.center),
                    SizedBox(height: Get.height * 0.1),
                    PrimaryCircleButton(
                      icon: Icon(Icons.arrow_forward, color: AppColors.primary),
                      onPressed: () => Get.to(CustomMethodicPage(pageId: widget.pageId)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    AppRouting.navigateToHomeWithClearHistory();
    return false;
  }
}
