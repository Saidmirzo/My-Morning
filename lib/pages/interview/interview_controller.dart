import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:morningmagic/pages/payment.dart';

import '../../db/hive.dart';
import '../../db/model/user/user.dart';
import '../../db/resource.dart';
import '../../storage.dart';
import 'models/futures.dart';

enum YesNoOther { nan, yes, no, other }

class InterviewController extends GetxController {
  InterviewController(this.countPages) {
    _user = MyDB().getBox().get(MyResource.USER_KEY);
    pageController = PageController();
    pageController.addListener(() {
      currQuestion.value = pageController.page.round();
    });
    q9Futures.value = [
      Futures(name: 'meditation_small'.tr),
      Futures(name: 'affirmation_small'.tr),
      Futures(name: 'visualization_small'.tr),
      Futures(name: 'fitness_small'.tr),
      Futures(name: 'reading_small'.tr),
      Futures(name: 'diary_small'.tr),
      Futures(name: 'other'.tr),
    ].obs;

    _data['Platform'] = GetPlatform.isAndroid
        ? 'Android'
        : GetPlatform.isIOS
            ? 'iOS'
            : 'other';
    _data['isVip'] = billingService.isPro();
  }

  int countPages = 0;

  PageController pageController;
  RxInt currQuestion = 0.obs;

  // текущий юзер, чтобы вытащить никнейм и другую инфу
  User _user;
  // Ответы на вопросы
  Map<String, dynamic> _data = {};
  // Коллекция в БД в котороую все сохраняем
  CollectionReference _collection =
      FirebaseFirestore.instance.collection('interview_1');

  // вопрос 1
  TextEditingController q1Controller = TextEditingController();
  // вопрос 2
  Rx<YesNoOther> q2val = YesNoOther.nan.obs;
  TextEditingController q2TextController = TextEditingController();
  // вопрос 3
  Rx<YesNoOther> q3val = YesNoOther.nan.obs;
  TextEditingController q3TextController = TextEditingController();
  TextEditingController q3TextController2 = TextEditingController();
  // вопрос 4
  Rx<YesNoOther> q4val = YesNoOther.nan.obs;
  TextEditingController q4TextControllerOther = TextEditingController();
  // вопрос 5
  TextEditingController q5TextController = TextEditingController();
  // вопрос 6
  TextEditingController q6TextController = TextEditingController();
  // вопрос 7
  Rx<YesNoOther> q7val = YesNoOther.nan.obs;
  TextEditingController q7TextController = TextEditingController();
  // вопрос 8
  TextEditingController q8TextController = TextEditingController();
  // вопрос 9
  var q9Futures = RxList<Futures>().obs;
  TextEditingController q9TextController = TextEditingController();
  // вопрос 10
  TextEditingController q10TextController = TextEditingController();
  // вопрос 11
  Rx<YesNoOther> q11val = YesNoOther.nan.obs;
  TextEditingController q11TextController = TextEditingController();
  TextEditingController q11TextController2 = TextEditingController();
  // вопрос 12
  Rx<YesNoOther> q12val = YesNoOther.nan.obs;
  TextEditingController q12TextController = TextEditingController();
  TextEditingController q12TextController2 = TextEditingController();
  // вопрос 13
  TextEditingController q13Controller = TextEditingController();

  void next(int i) {
    switch (i) {
      case 1:
        if (q1Controller.text.isEmpty) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data["Вопрос 1"] = q1Controller.text;
          slideNext();
        }
        break;
      case 2:
        if (q2val.value == YesNoOther.nan ||
            (q2val.value == YesNoOther.yes && q2TextController.text.isEmpty)) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          final val = q2val.value == YesNoOther.yes;
          _data["Вопрос 2"] = val;
          if (val) _data["Вопрос 2, если да"] = q2TextController.text;
          slideNext();
        }
        break;
      case 3:
        if (q3val.value == YesNoOther.nan ||
            (q3val.value == YesNoOther.other &&
                q3TextController.text.isEmpty) ||
            (q3val.value == YesNoOther.yes && q3TextController2.text.isEmpty)) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data["Вопрос 3"] = q3val.value.toString().split('.').last;
          if (q3val.value == YesNoOther.other)
            _data["Вопрос 3, другое"] = q3TextController.text;
          if (q3val.value == YesNoOther.yes)
            _data["Вопрос 3, если да"] = q3TextController2.text;
          slideNext();
        }
        break;
      case 4:
        if (q4val.value == YesNoOther.nan ||
            (q4val.value == YesNoOther.other &&
                q4TextControllerOther.text.isEmpty)) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data["Вопрос 4"] = q4val.value.toString().split('.').last;
          if (q4val.value == YesNoOther.other)
            _data["Вопрос 4, другое"] = q4TextControllerOther.text;
          slideNext();
        }
        break;
      case 5:
        if (q5TextController.text.isEmpty) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data["Вопрос 5"] = q5TextController.text;
          slideNext();
        }
        break;
      case 6:
        if (q6TextController.text.isEmpty) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data["Вопрос 6"] = q6TextController.text;
          slideNext();
        }
        break;
      case 7:
        if (q7val.value == YesNoOther.nan ||
            (q7val.value == YesNoOther.other &&
                q7TextController.text.isEmpty)) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data["Вопрос 7"] = q7val.value.toString().split('.').last;
          if (q7val.value == YesNoOther.other)
            _data["Вопрос 7, другое"] = q7TextController.text;
          slideNext();
        }
        break;
      case 8:
        if (q8TextController.text.isEmpty) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data["Вопрос 8"] = q8TextController.text;
          slideNext();
        }
        break;
      case 9:
        List<String> _items = [];
        q9Futures.value.forEach((element) {
          if (element.isActive) {
            element.name == 'other'.tr
                ? _items.add(q9TextController.text)
                : _items.add(element.name);
          }
        });
        if (_items.length == 0) return;
        _data["Вопрос 9"] = _items;
        slideNext();
        break;
      case 10:
        if (q10TextController.text.isEmpty) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data["Вопрос 10"] = q10TextController.text;
          slideNext();
        }
        break;
      case 11:
        if (q11val.value == YesNoOther.nan ||
            (q11val.value == YesNoOther.other &&
                q11TextController.text.isEmpty) ||
            (q11val.value == YesNoOther.yes &&
                q11TextController2.text.isEmpty)) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data["Вопрос 11"] = q11val.value.toString().split('.').last;
          if (q11val.value == YesNoOther.other)
            _data["Вопрос 11, другое"] = q11TextController.text;
          if (q11val.value == YesNoOther.yes)
            _data["Вопрос 11, если да"] = q11TextController2.text;
          slideNext();
        }
        break;
      case 12:
        if (q12val.value == YesNoOther.nan ||
            (q12val.value == YesNoOther.other &&
                q12TextController.text.isEmpty) ||
            (q12val.value == YesNoOther.yes &&
                q12TextController2.text.isEmpty)) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data["Вопрос 12"] = q12val.value.toString().split('.').last;
          if (q12val.value == YesNoOther.other)
            _data["Вопрос 12, другое"] = q12TextController.text;
          if (q12val.value == YesNoOther.yes)
            _data["Вопрос 12, если да"] = q12TextController2.text;
          slideNext();
        }
        break;
      case 13:
        if (q13Controller.text.isEmpty) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data["Вопрос 11"] = q13Controller.text;
          save();
          if (billingService.isPro())
            slideNext();
          else {
            Get.back();
            Get.to(PaymentPage());
          }
        }
        break;
      case 14:
        Get.back();
        break;
      default:
        print('onNext: curr index: NaN');
    }
  }

  void slideNext() {
    pageController.animateToPage(pageController.page.round() + 1,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void slideBack() {
    pageController.animateToPage(pageController.page.round() - 1,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void save() {
    _collection
        .doc('${_user?.name} ${DateTime.now()}')
        .set(_data)
        .then((value) => print("Interview Added"))
        .catchError((error) => print("Failed to add user: $error"));
    MyDB().getBox().put(MyResource.IS_DONE_INTERVIEW, true);
  }
}
