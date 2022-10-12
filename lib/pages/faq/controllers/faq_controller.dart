import 'package:get/get.dart';
import '../faq_category.dart';

class FaqController extends GetX {
  String cat_support = 'faq_cat_support'.tr;
  String cat_why = 'faq_cat_why'.tr;
  String cat_tarifs = 'faq_cat_tarifs'.tr;

  void openCategory(String _cat) {
    Get.to(FaqCategoryPage(category: _cat));
  }

  List<Map<String, String>> getQuestionsByCategory(String cat) {
    if (cat == cat_support) {
      return [
        {'test'.tr: 'test'.tr},
      ];
    } else if (cat == cat_why) {
      return [
        {'faq_about_title_1'.tr: 'faq_about_desc_1'.tr},
        {'faq_about_title_2'.tr: 'faq_about_desc_2'.tr},
        {'faq_about_title_3'.tr: 'faq_about_desc_3'.tr},
        {'faq_about_title_4'.tr: 'faq_about_desc_4'.tr},
        {'faq_about_title_5'.tr: 'faq_about_desc_5'.tr},
        {'faq_about_title_6'.tr: 'faq_about_desc_6'.tr},
      ];
    } else if (cat == cat_tarifs) {
      return [
        {'faq_tarifs_title_1'.tr: 'faq_tarifs_desc_1'.tr},
        {'faq_tarifs_title_2'.tr: 'faq_tarifs_desc_2'.tr},
        {'faq_tarifs_title_3'.tr: 'faq_tarifs_desc_3'.tr},
        {'faq_tarifs_title_4'.tr: 'faq_tarifs_desc_4'.tr},
        {'faq_tarifs_title_5'.tr: 'faq_tarifs_desc_5'.tr},
      ];
    } else {
      return [];
    }
  }
}
