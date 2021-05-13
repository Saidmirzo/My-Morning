import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/affirmation/affirmation_dialog/models/affirmation_text_model.dart';

import 'models/affirmation_cat_model.dart';

class AffirmationController extends GetxController {
  var affirmations = RxList<AffirmationCategoryModel>().obs;
  Rx<AffirmationCategoryModel> selectedAffirmation;

  @override
  void onInit() {
    readAffirmations();
    super.onInit();
  }

  // Запишем дефолтные аффирмации если список пуст
  initDefAffirmations() async {
    affirmations.value.addAll([
      AffirmationCategoryModel(
        'for_confidence',
        affirmations: [
          AffirmationTextModel("confidence_text_1"),
          AffirmationTextModel("confidence_text_2"),
          AffirmationTextModel("confidence_text_3"),
          AffirmationTextModel("confidence_text_4"),
          AffirmationTextModel("confidence_text_5"),
          AffirmationTextModel("confidence_text_6"),
        ],
      ),
      AffirmationCategoryModel(
        'for_love',
        affirmations: [
          AffirmationTextModel("love_text_1"),
          AffirmationTextModel("love_text_2"),
          AffirmationTextModel("love_text_3"),
          AffirmationTextModel("love_text_4"),
          AffirmationTextModel("love_text_5"),
          AffirmationTextModel("love_text_6"),
          AffirmationTextModel("love_text_7"),
          AffirmationTextModel("love_text_8"),
          AffirmationTextModel("love_text_9"),
          AffirmationTextModel("love_text_10"),
          AffirmationTextModel("love_text_11"),
        ],
      ),
      AffirmationCategoryModel(
        'for_health',
        affirmations: [
          AffirmationTextModel("health_text_1"),
          AffirmationTextModel("health_text_2"),
          AffirmationTextModel("health_text_3"),
          AffirmationTextModel("health_text_4"),
          AffirmationTextModel("health_text_5"),
          AffirmationTextModel("health_text_6"),
          AffirmationTextModel("health_text_7"),
          AffirmationTextModel("health_text_8"),
          AffirmationTextModel("health_text_9"),
          AffirmationTextModel("health_text_10"),
        ],
      ),
      AffirmationCategoryModel(
        'for_success',
        affirmations: [
          AffirmationTextModel("success_text_1"),
          AffirmationTextModel("success_text_2"),
          AffirmationTextModel("success_text_3"),
          AffirmationTextModel("success_text_4"),
          AffirmationTextModel("success_text_5"),
          AffirmationTextModel("success_text_6"),
          AffirmationTextModel("success_text_7"),
          AffirmationTextModel("success_text_8"),
          AffirmationTextModel("success_text_9"),
          AffirmationTextModel("success_text_10"),
          AffirmationTextModel("success_text_11"),
        ],
      ),
      AffirmationCategoryModel(
        'for_career',
        affirmations: [
          AffirmationTextModel("career_text_1"),
          AffirmationTextModel("career_text_2"),
          AffirmationTextModel("career_text_3"),
          AffirmationTextModel("career_text_4"),
          AffirmationTextModel("career_text_5"),
          AffirmationTextModel("career_text_6"),
          AffirmationTextModel("career_text_7"),
          AffirmationTextModel("career_text_8"),
          AffirmationTextModel("career_text_9"),
          AffirmationTextModel("career_text_10"),
          AffirmationTextModel("career_text_11"),
        ],
      ),
      AffirmationCategoryModel(
        'for_wealth',
        affirmations: [
          AffirmationTextModel("wealth_text_1"),
          AffirmationTextModel("wealth_text_2"),
          AffirmationTextModel("wealth_text_3"),
          AffirmationTextModel("wealth_text_4"),
          AffirmationTextModel("wealth_text_5"),
          AffirmationTextModel("wealth_text_6"),
          AffirmationTextModel("wealth_text_7"),
          AffirmationTextModel("wealth_text_8"),
          AffirmationTextModel("wealth_text_9"),
          AffirmationTextModel("wealth_text_10"),
        ],
      ),
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
    affirmations.value
        .add(AffirmationCategoryModel(name, isCustom: true, affirmations: []));
    save();
  }

  // Добавление текста в категорию
  void addAffirmationText(String text) async {
    selectedAffirmation.value.affirmations
        .add(AffirmationTextModel(text, isCustom: true));
    selectedAffirmation.refresh();
    save();
  }
}
