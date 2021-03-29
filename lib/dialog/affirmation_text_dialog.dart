import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

import 'models/affirmation_category.dart';

class AffirmationTextDialog extends StatefulWidget {
  final AffirmationCategory affirmationCategory;

  const AffirmationTextDialog({Key key, @required this.affirmationCategory})
      : super(key: key);

  @override
  _AffirmationTextDialogState createState() => _AffirmationTextDialogState();
}

class _AffirmationTextDialogState extends State<AffirmationTextDialog> {
  List<String> _affirmationTextList;
  int _selectedItemIndex;

  @override
  void initState() {
    super.initState();
    _affirmationTextList = _getAffirmationTextList(widget.affirmationCategory);
  }

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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 16.0),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
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
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 16.0),
                    child: InkWell(
                      onTap: (_selectedItemIndex == null)
                          ? null
                          : () {
                              Navigator.pop(context,
                                  _affirmationTextList[_selectedItemIndex]);
                            },
                      child: Text(
                        'choose'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 23,
                            fontStyle: FontStyle.normal,
                            color: _selectedItemIndex == null
                                ? AppColors.VIOLET.withAlpha(70)
                                : AppColors.VIOLET),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _affirmationTextList.length,
                  itemBuilder: (context, index) => AffirmationTextItem(
                    text: _affirmationTextList[index],
                    onItemSelected: () {
                      setState(() {
                        (_selectedItemIndex == index)
                            ? _selectedItemIndex = null
                            : _selectedItemIndex = index;
                      });
                    },
                    isSelected: _selectedItemIndex == index ? true : false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getAffirmationTextList(
      AffirmationCategory affirmationCategory) {
    switch (affirmationCategory) {
      case AffirmationCategory.confidence:
        return [
          "confidence_text_1".tr,
          "confidence_text_2".tr,
          "confidence_text_3".tr,
          "confidence_text_4".tr,
          "confidence_text_5".tr,
          "confidence_text_6".tr
        ];
        break;
      case AffirmationCategory.health:
        return [
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
        ];
        break;
      case AffirmationCategory.love:
        return [
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
        ];
        break;
      case AffirmationCategory.success:
        return [
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
        ];
        break;
      case AffirmationCategory.career:
        return [
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
        ];

        break;
      case AffirmationCategory.wealth:
        return [
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
        ];
        break;
      default:
        throw UnsupportedError("unknown affirmation category");
    }
  }
}

class AffirmationTextItem extends StatelessWidget {
  final String text;
  final VoidCallback onItemSelected;
  final isSelected;

  const AffirmationTextItem(
      {Key key,
      @required this.text,
      @required this.onItemSelected,
      @required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemSelected,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.0,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.PINK : AppColors.LIGHT_VIOLET,
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: Container(
          padding: EdgeInsets.only(top: 2),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: AppColors.WHITE,
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
