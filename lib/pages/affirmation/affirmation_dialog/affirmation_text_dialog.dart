import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';
import 'add_text.dart';
import 'affirmation_controller.dart';

class AffirmationTextDialog extends StatefulWidget {
  const AffirmationTextDialog({Key key}) : super(key: key);

  @override
  _AffirmationTextDialogState createState() => _AffirmationTextDialogState();
}

class _AffirmationTextDialogState extends State<AffirmationTextDialog> {
  final AffirmationController _controller = Get.find();
  int _selectedItemIndex;

  @override
  void initState() {
    super.initState();
  }

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
                        style: const TextStyle(
                            fontSize: 23,
                            fontStyle: FontStyle.normal,
                            color: AppColors.violet),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 16.0),
                    child: InkWell(
                      onTap: (_selectedItemIndex == null)
                          ? null
                          : () {
                              Get.back(
                                  result: _controller.selectedAffirmation.value
                                      .affirmations[_selectedItemIndex].text);
                            },
                      child: Text(
                        'choose'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 23,
                            fontStyle: FontStyle.normal,
                            color: _selectedItemIndex == null
                                ? AppColors.violet.withAlpha(70)
                                : AppColors.violet),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: _controller
                        .selectedAffirmation.value.affirmations.length,
                    itemBuilder: (context, index) => AffirmationTextItem(
                      text: _controller
                          .selectedAffirmation.value.affirmations[index].text,
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
              ),
              Align(
                alignment: Alignment.center,
                child: PrimaryCircleButton(
                  onPressed: () => Get.dialog(AddTextAffirmation()),
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
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.pink : AppColors.lightViolet,
            borderRadius: const BorderRadius.all(Radius.circular(40))),
        child: Container(
          padding: const EdgeInsets.only(top: 2),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  color: AppColors.white,
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
