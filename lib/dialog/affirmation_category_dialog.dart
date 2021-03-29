import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/dialog/affirmation_text_dialog.dart';
import 'package:morningmagic/dialog/models/affirmation_category.dart';
import 'package:morningmagic/resources/colors.dart';

class AffirmationCategoryDialog extends StatefulWidget {
  @override
  _AffirmationCategoryDialogState createState() =>
      _AffirmationCategoryDialogState();
}

class _AffirmationCategoryDialogState extends State<AffirmationCategoryDialog> {
  final _affirmationList = AffirmationCategory.values.toList();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
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
                    style: TextStyle(
                        fontSize: 23,
                        fontStyle: FontStyle.normal,
                        color: AppColors.VIOLET),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _affirmationList.length,
                itemBuilder: (context, index) => MainAffirmationDialogItem(
                    affirmationCategory: _affirmationList[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainAffirmationDialogItem extends StatefulWidget {
  final AffirmationCategory affirmationCategory;

  const MainAffirmationDialogItem({Key key, @required this.affirmationCategory})
      : super(key: key);

  @override
  _MainAffirmationDialogItemState createState() =>
      _MainAffirmationDialogItemState();
}

class _MainAffirmationDialogItemState extends State<MainAffirmationDialogItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        String affirmationText = await _showAffirmationSelectionDialog(
            context, widget.affirmationCategory);
        if (affirmationText != null) {
          Navigator.pop(context, affirmationText);
        }
        print('affirmation text result $affirmationText');
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.0,
        height: 35.0,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            color: AppColors.LIGHT_VIOLET,
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: Container(
          padding: EdgeInsets.only(top: 2),
          child: Row(
            children: [
              Text(
                _getAffirmationCategoryText(widget.affirmationCategory),
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: AppColors.WHITE,
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  String _getAffirmationCategoryText(AffirmationCategory affirmation) {
    switch (affirmation) {
      case AffirmationCategory.confidence:
        return 'for_confidence'.tr;
        break;
      case AffirmationCategory.love:
        return 'for_love'.tr;
        break;
      case AffirmationCategory.health:
        return 'for_health'.tr;
        break;
      case AffirmationCategory.success:
        return 'for_success'.tr;
        break;
      case AffirmationCategory.career:
        return 'for_career'.tr;
        break;
      case AffirmationCategory.wealth:
        return 'for_wealth'.tr;
        break;
      default:
        return 'unknown category';
    }
  }

  Future<String> _showAffirmationSelectionDialog(
      BuildContext context, AffirmationCategory affirmationCategory) {
    return showDialog(
        context: context,
        builder: (BuildContext context) =>
            AffirmationTextDialog(affirmationCategory: affirmationCategory));
  }
}
