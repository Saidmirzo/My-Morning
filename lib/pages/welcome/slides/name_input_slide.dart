import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/widgets/lang_btn.dart';
import '../../../db/model/user/user.dart';
import '../../../db/resource.dart';
import '../../../resources/colors.dart';
import '../../../widgets/primary_circle_button.dart';

class NameInputSlide extends StatelessWidget {
  final PageController _pageController;
  TextEditingController myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();

  NameInputSlide(this._pageController);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _focusNode.unfocus(),
      child: Form(
        key: _formKey,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            langBtn(context),
            Spacer(
              flex: 1,
            ),
            buildTitle(),
            SizedBox(height: 21),
            buildInput(),
            SizedBox(height: 41),
            //LanguageSwitcher(),
            SizedBox(height: Get.height * .15),
            buildButton(),
            buildSkipButton(),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  Text buildTitle() {
    return Text(
      'lets_acquainted'.tr,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: Get.height * 0.022,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  PrimaryCircleButton buildButton() {
    return PrimaryCircleButton(
      size: 40,
      icon: Icon(Icons.arrow_forward, color: AppColors.primary),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          saveNameToBox();
          _pageController.nextPage(duration: 300.milliseconds, curve: Curves.easeIn);
        }
      },
    );
  }

  Container buildInput() {
    return Container(
        width: Get.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: AppColors.TRANSPARENT_WHITE,
        ),
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
          decoration: BoxDecoration(color: Color(0xffDCACC8), borderRadius: BorderRadius.circular(30)),
          child: TextFormField(
            controller: myController,
            focusNode: _focusNode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please_input_name'.tr;
              }
              return null;
            },
            minLines: 1,
            maxLines: 1,
            cursorColor: AppColors.VIOLET,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.normal,
              color: AppColors.VIOLET,
              decoration: TextDecoration.none,
            ),
            decoration: new InputDecoration(border: InputBorder.none, hintText: 'your_name'.tr, hintStyle: TextStyle(color: Colors.white)),
          ),
        ));
  }

  void saveNameToBox() async {
    if (myController.text != null && myController.text.isNotEmpty) {
      AppMetrica.reportEvent('onbording_name_set');
      await MyDB().getBox().put(MyResource.USER_KEY, User(myController.text));
      appAnalitics.logEvent('first_name');
    }
  }

  CupertinoButton buildSkipButton() {
    return CupertinoButton(
      child: Text(
        'skip'.tr,
        style: TextStyle(color: Colors.white54),
      ),
      onPressed: () {
        // AppRouting.replace(MainMenuPage());
        AppMetrica.reportEvent('onbording_name_skip');
        _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      },
    );
  }
}
