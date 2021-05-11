import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:get/get.dart';

import 'models/affirmation_model.dart';

class AffirmationController extends GetxController {
  var affirmations = RxList<AffirmationyModel>().obs;
  Rx<AffirmationyModel> selectedAffirmation;

  @override
  void onInit() {
    readAffirmations();
    super.onInit();
  }

  // Запишем дефолтные аффирмации если список пуст
  initDefAffirmations() async {
    affirmations.value.addAll([
      AffirmationyModel(name: 'for_confidence'.tr, affirmations: [
        "confidence_text_1".tr,
        "confidence_text_2".tr,
        "confidence_text_3".tr,
        "confidence_text_4".tr,
        "confidence_text_5".tr,
        "confidence_text_6".tr
      ]),
      AffirmationyModel(name: 'for_love'.tr, affirmations: [
        "love_text_1".tr,
        "love_text_2".tr,
        "love_text_3".tr,
        "love_text_4".tr,
        "love_text_5".tr,
        "love_text_6".tr,
        "love_text_7".tr,
        "love_text_8".tr,
        "love_text_9".tr,
        "love_text_10".tr,
        "love_text_11".tr,
      ]),
      AffirmationyModel(name: 'for_health'.tr, affirmations: [
        "health_text_1".tr,
        "health_text_2".tr,
        "health_text_3".tr,
        "health_text_4".tr,
        "health_text_5".tr,
        "health_text_6".tr,
        "health_text_7".tr,
        "health_text_8".tr,
        "health_text_9".tr,
        "health_text_10".tr,
      ]),
      AffirmationyModel(name: 'for_success'.tr, affirmations: [
        "success_text_1".tr,
        "success_text_2".tr,
        "success_text_3".tr,
        "success_text_4".tr,
        "success_text_5".tr,
        "success_text_6".tr,
        "success_text_7".tr,
        "success_text_8".tr,
        "success_text_9".tr,
        "success_text_10".tr,
        "success_text_11".tr,
      ]),
      AffirmationyModel(name: 'for_career'.tr, affirmations: [
        "career_text_1".tr,
        "career_text_2".tr,
        "career_text_3".tr,
        "career_text_4".tr,
        "career_text_5".tr,
        "career_text_6".tr,
        "career_text_7".tr,
        "career_text_8".tr,
        "career_text_9".tr,
        "career_text_10".tr,
        "career_text_11".tr,
      ]),
      AffirmationyModel(name: 'for_wealth'.tr, affirmations: [
        "wealth_text_1".tr,
        "wealth_text_2".tr,
        "wealth_text_3".tr,
        "wealth_text_4".tr,
        "wealth_text_5".tr,
        "wealth_text_6".tr,
        "wealth_text_7".tr,
        "wealth_text_8".tr,
        "wealth_text_9".tr,
        "wealth_text_10".tr,
      ]),
    ]);
    save();
  }

  void save() async {
    await MyDB().getBox().put(MyResource.My_Affirmations, affirmations.value);
  }

  readAffirmations() async {
    print('Читаем список аффирмаций');
    var ll =
        await MyDB().getBox().get(MyResource.My_Affirmations, defaultValue: []);
    for (var item in ll) {
      affirmations.value.add(item);
    }

    if (affirmations.value.length == 0) {
      print('Аффирмаций не найдено, добавляем дефолтные');
      await initDefAffirmations();
    }
  }

  // Добавление категории
  void addAffirmationCategory(String name) {
    affirmations.value.add(AffirmationyModel(name: name, affirmations: []));
    save();
  }

  // Добавление текста в категорию
  void addAffirmationText(String text) async {
    selectedAffirmation.value.affirmations.add(text);
    selectedAffirmation.refresh();
    save();
  }
}
