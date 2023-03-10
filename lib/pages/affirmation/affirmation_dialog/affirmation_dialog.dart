import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/pages/affirmation/affirmation_dialog/affirmation_controller.dart';
import 'package:morningmagic/pages/affirmation/affirmation_dialog/affirmation_text_dialog.dart';
import 'package:morningmagic/pages/affirmation/affirmation_dialog/models/affirmation_cat_model.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';
import 'add_category.dart';

class AffirmationCategoryDialog extends StatefulWidget {
  const AffirmationCategoryDialog({Key key}) : super(key: key);

  @override
  _AffirmationCategoryDialogState createState() =>
      _AffirmationCategoryDialogState();
}

class _AffirmationCategoryDialogState extends State<AffirmationCategoryDialog> {
  final AffirmationController _controller = Get.put(AffirmationController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'back_button'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 23,
                        fontStyle: FontStyle.normal,
                        color: AppColors.violet),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Obx(() {
                  var _af = _controller.affirmations.value;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: _af.length,
                    itemBuilder: (context, index) => item(_af[index]),
                  );
                }),
              ),
              Align(
                alignment: Alignment.center,
                child: PrimaryCircleButton(
                  onPressed: () => Get.dialog(AddCategoryAffirmation()),
                  icon: const Icon(Icons.add, color: Colors.black54),
                  bgColor: Colors.black12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget item(AffirmationCategoryModel _affirmation) {
    return InkWell(
      onTap: () async {
        _controller.selectedAffirmation = _affirmation.obs;
        String affirmationText =
            await Get.dialog(const AffirmationTextDialog());
        if (affirmationText != null) {
          Get.back(result: affirmationText);
        }
        print('affirmation text result $affirmationText');
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.0,
        height: 35.0,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: const BoxDecoration(
            color: AppColors.lightViolet,
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: Container(
          padding: const EdgeInsets.only(top: 2),
          child: Row(
            children: [
              Text(
                _affirmation.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  color: AppColors.white,
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
