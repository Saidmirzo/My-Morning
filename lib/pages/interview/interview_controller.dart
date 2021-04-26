import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:morningmagic/pages/payment.dart';
import 'package:morningmagic/routing/app_routing.dart';

import '../../db/hive.dart';
import '../../db/model/user/user.dart';
import '../../db/resource.dart';
import 'models/futures.dart';

enum YesNoOther { nan, yes, no, other }

class InterviewController extends GetxController {
  InterviewController() {
    _user = MyDB().getBox().get(MyResource.USER_KEY);
    pageController = PageController();
    pageController.addListener(() {
      currQuestion.value = pageController.page.round();
    });
    q5Futures.value = [
      Futures(name: 'meditation_small'.tr),
      Futures(name: 'affirmation_small'.tr),
      Futures(name: 'visualization_small'.tr),
      Futures(name: 'fitness_small'.tr),
      Futures(name: 'reading_small'.tr),
      Futures(name: 'diary_small'.tr),
    ].obs;
  }

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
  var q5Futures = RxList<Futures>().obs;
  // вопрос 6
  TextEditingController q6TextController = TextEditingController();
  // вопрос 7
  Rx<YesNoOther> q7val = YesNoOther.nan.obs;
  TextEditingController q7TextController = TextEditingController();
  TextEditingController q7TextController2 = TextEditingController();
  // вопрос 8
  Rx<YesNoOther> q8val = YesNoOther.nan.obs;
  TextEditingController q8TextController = TextEditingController();
  TextEditingController q8TextController2 = TextEditingController();
  // вопрос 9
  Rx<YesNoOther> q9val = YesNoOther.nan.obs;
  TextEditingController q9TextControllerOther = TextEditingController();
  // вопрос 10
  RxInt q10val = (-2).obs;
  TextEditingController q10TextControllerOther = TextEditingController();
  List<int> dollars = [0, 1, 2, 3, 4, 5, -1];
  // вопрос 11
  TextEditingController q11Controller = TextEditingController();

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
        List<String> _items = [];
        q5Futures.value.forEach((element) {
          if (element.isActive) _items.add(element.name);
        });
        if (_items.length == 0) return;
        _data["Вопрос 5"] = _items;
        slideNext();
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
                q7TextController.text.isEmpty) ||
            (q7val.value == YesNoOther.yes && q7TextController2.text.isEmpty)) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data["Вопрос 7"] = q7val.value.toString().split('.').last;
          if (q7val.value == YesNoOther.other)
            _data["Вопрос 7, другое"] = q7TextController.text;
          if (q7val.value == YesNoOther.yes)
            _data["Вопрос 7, если да"] = q7TextController2.text;
          slideNext();
        }
        break;
      case 8:
        if (q8val.value == YesNoOther.nan ||
            (q8val.value == YesNoOther.other &&
                q8TextController.text.isEmpty) ||
            (q8val.value == YesNoOther.yes && q8TextController2.text.isEmpty)) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data["Вопрос 8"] = q8val.value.toString().split('.').last;
          if (q8val.value == YesNoOther.other)
            _data["Вопрос 8, другое"] = q8TextController.text;
          if (q8val.value == YesNoOther.yes)
            _data["Вопрос 8, если да"] = q8TextController2.text;
          slideNext();
        }
        break;
      case 9:
        if (q9val.value == YesNoOther.nan ||
            (q9val.value == YesNoOther.other &&
                q9TextControllerOther.text.isEmpty)) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data["Вопрос 9"] = q4val.value.toString().split('.').last;
          if (q9val.value == YesNoOther.other)
            _data["Вопрос 9, другое"] = q9TextControllerOther.text;
          slideNext();
        }
        break;
      case 10:
        if (q10val.value == -2 ||
            (q10val.value == -1 && q10TextControllerOther.text.isEmpty)) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          if (q10val.value > 0)
            _data["Вопрос 10"] = dollars[q10val.value].toString() + "\$";
          if (q10val.value == -1)
            _data["Вопрос 10, другое"] = q10TextControllerOther.text;
          slideNext();
        }
        break;
      case 11:
        if (q11Controller.text.isEmpty) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data["Вопрос 11"] = q11Controller.text;
          save();
          Get.back();
          Get.to(PaymentPage());
        }
        break;
      default:
        print('onNext: curr index: NaN');
    }
  }

  void slideNext() {
    pageController.animateToPage(pageController.page.round() + 1,
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
