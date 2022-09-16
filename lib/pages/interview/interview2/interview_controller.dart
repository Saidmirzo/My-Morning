import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../db/hive.dart';
import '../../../db/model/user/user.dart';
import '../../../db/resource.dart';
import '../../../storage.dart';

enum YesNoOther { nan, yes, no, other }

class Interview2Controller extends GetxController {
  Interview2Controller(this.countPages) {
    _user = MyDB().getBox().get(MyResource.USER_KEY);
    pageController = PageController();
    pageController.addListener(() {
      currQuestion.value = pageController.page.round();
    });
    data['Platform'] = GetPlatform.isAndroid
        ? 'Android'
        : GetPlatform.isIOS
            ? 'iOS'
            : 'other';
    data['isVip'] = billingService.isPro();
    data['nickname'] = _user?.name;
    data['timestamp'] = DateTime.now();
  }

  int countPages = 0;

  PageController pageController;
  RxInt currQuestion = 0.obs;

  // текущий юзер, чтобы вытащить никнейм и другую инфу
  User _user;
  // Ответы на вопросы
  Map<String, dynamic> data = {};
  // Коллекция в БД в котороую все сохраняем
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('interview_2');

  void slideNext() {
    if (pageController.page.round() == countPages - 2) save();
    pageController.animateToPage(pageController.page.round() + 1,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void slideBack() {
    pageController.animateToPage(pageController.page.round() - 1,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void save() async {
    print('startSave interview');
    _collection
        .doc('${DateTime.now()}')
        .set(data)
        .then((value) => print("Interview Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
