import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/pages/affirmation/components/bg.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/styles.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';
import '../../dialog/back_to_main_menu_dialog.dart';
import 'custom_methodic_page.dart';

class CustomMethodicStartPage extends StatefulWidget {
  final String id;
  final int pageId;
  const CustomMethodicStartPage(
      {Key key, @required this.id, @required this.pageId})
      : super(key: key);

  @override
  State<CustomMethodicStartPage> createState() =>
      _CustomMethodicStartPageState();
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
          decoration: const BoxDecoration(gradient: AppColors.Bg_Gradient_2),
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: GestureDetector(
                          child: const Padding(
                            padding: EdgeInsets.only(left: 31),
                            child: Icon(
                              Icons.west,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          onTap: () {
                            if (isComplex) {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    const BackToMainMenuDialog(),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainMenuPage()),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.15),
                    Text(_info.title ?? "", style: AppStyles.treaningTitle),
                    SizedBox(height: Get.height * 0.05),
                    Text('your_own_ritual'.tr,
                        style: AppStyles.treaningSubtitle,
                        textAlign: TextAlign.center),
                    SizedBox(height: Get.height * 0.1),
                    PrimaryCircleButton(
                      icon: const Icon(Icons.arrow_forward,
                          color: AppColors.primary),
                      onPressed: () =>
                          Get.to(CustomMethodicPage(pageId: widget.pageId)),
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
