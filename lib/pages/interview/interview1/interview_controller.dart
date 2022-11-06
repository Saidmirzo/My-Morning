// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/paywall/new_paywall.dart';
import '../../../db/hive.dart';
import '../../../db/model/user/user.dart';
import '../../../db/resource.dart';
import '../../../services/ab_testing_service.dart';
import '../../../storage.dart';
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
    _data['nickname'] = _user?.name;
    _data['timestamp'] = DateTime.now();
  }

  int countPages = 0;

  PageController pageController;
  RxInt currQuestion = 0.obs;

  // текущий юзер, чтобы вытащить никнейм и другую инфу
  User _user;
  // Ответы на вопросы
  final Map<String, dynamic> _data = {};
  // Коллекция в БД в котороую все сохраняем
  final CollectionReference _collection =
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
          _data['question'.tr + " 1"] = q1Controller.text;
          slideNext();
        }
        break;
      case 2:
        if (q2val.value == YesNoOther.nan ||
            (q2val.value == YesNoOther.yes && q2TextController.text.isEmpty)) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          final val = q2val.value == YesNoOther.yes;
          _data['question'.tr + " 2"] = val;
          if (val) _data['question'.tr + " 2, " + 'if_yes'.tr] = q2TextController.text;
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
          _data['question'.tr + " 3"] = q3val.value.toString().split('.').last;
          if (q3val.value == YesNoOther.other)
            _data['question'.tr + " 3, " + 'other'.tr] = q3TextController.text;
          if (q3val.value == YesNoOther.yes)
            _data['question'.tr + " 3, " + 'if_yes'.tr] = q3TextController2.text;
          slideNext();
        }
        break;
      case 4:
        if (q4val.value == YesNoOther.nan ||
            (q4val.value == YesNoOther.other &&
                q4TextControllerOther.text.isEmpty)) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data['question'.tr + " 4"] = q4val.value.toString().split('.').last;
          if (q4val.value == YesNoOther.other)
            _data['question'.tr + " 4, " + 'other'.tr] = q4TextControllerOther.text;
          slideNext();
        }
        break;
      case 5:
        if (q5TextController.text.isEmpty) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data['question'.tr + " 5"] = q5TextController.text;
          slideNext();
        }
        break;
      case 6:
        if (q6TextController.text.isEmpty) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data['question'.tr + " 6"] = q6TextController.text;
          slideNext();
        }
        break;
      case 7:
        if (q7val.value == YesNoOther.nan ||
            (q7val.value == YesNoOther.other &&
                q7TextController.text.isEmpty)) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data['question'.tr + " 7"] = q7val.value.toString().split('.').last;
          if (q7val.value == YesNoOther.other)
            _data['question'.tr + " 7, " + 'other'.tr] = q7TextController.text;
          slideNext();
        }
        break;
      case 8:
        if (q8TextController.text.isEmpty) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data['question'.tr + " 8"] = q8TextController.text;
          slideNext();
        }
        break;
      case 9:
        List<String> _items = [];
        for (var element in q9Futures.value) {
          if (element.isActive) {
            element.name == 'other'.tr
                ? _items.add(q9TextController.text)
                : _items.add(element.name);
          }
        }
        if (_items.isEmpty) return;
        _data['question'.tr + " 9"] = _items;
        slideNext();
        break;
      case 10:
        if (q10TextController.text.isEmpty) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data['question'.tr + " 10"] = q10TextController.text;
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
          _data['question'.tr + " 11"] = q11val.value.toString().split('.').last;
          if (q11val.value == YesNoOther.other)
            _data['question'.tr + " 11, " + 'other'.tr] = q11TextController.text;
          if (q11val.value == YesNoOther.yes)
            _data['question'.tr + " 11, " + 'if_yes'.tr] = q11TextController2.text;
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
          _data['question'.tr + " 12"] = q12val.value.toString().split('.').last;
          if (q12val.value == YesNoOther.other)
            _data['question'.tr + " 12, " + 'other'.tr] = q12TextController.text;
          if (q12val.value == YesNoOther.yes)
            _data['question'.tr + " 12, " + 'if_yes'.tr] = q12TextController2.text;
          slideNext();
        }
        break;
      case 13:
        if (q13Controller.text.isEmpty) {
          Get.snackbar(null, 'please_fill_all_fields'.tr);
        } else {
          _data['question'.tr + " 11"] = q13Controller.text;
          save();
          if (billingService.isPro()) {
            slideNext();
          } else {
            Get.back();
            Get.to(() => ABTestingService.getPaywall(true));
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
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void slideBack() {
    pageController.animateToPage(pageController.page.round() - 1,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void save() async {
    _collection
        .doc('${DateTime.now()}')
        .set(_data)
        .then((value) => print("Interview Added"))
        .catchError((error) => print("Failed to add user: $error"));
    await MyDB().getBox().put(MyResource.IS_DONE_INTERVIEW, true);
    // billingService.getProduct();
  }
}
