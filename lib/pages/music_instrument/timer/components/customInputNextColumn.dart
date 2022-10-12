import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/progress/reading_progress/reading_progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/progress/progress_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/my_const.dart';
import 'package:morningmagic/services/progress.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import '../../../../resources/colors.dart';
import '../../../../widgets/primary_circle_button.dart';

class InputTextColumn extends StatefulWidget {
  final VoidCallback onPressed;
  final bool fromHomeMenu;
  final int passedSec;
  final bool isSkip;

  const InputTextColumn(this.onPressed, this.passedSec, this.isSkip,
      {this.fromHomeMenu = false});

  @override
  State createState() {
    return InputTextColumnState();
  }
}

class InputTextColumnState extends State<InputTextColumn> {
  TextEditingController controller = TextEditingController();
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  void saveProg(bool isSkip) {
    print('widget.passedSec : ${widget.passedSec}');
    if (widget.passedSec > minPassedSec) {
      String book = MyDB().getBox().get(MyResource.BOOK_KEY, defaultValue: '');
      int pages = int.tryParse(controller.text) ?? 0;
      ReadingProgress model =
          ReadingProgress(book, pages, widget.passedSec, isSkip: isSkip);
      ProgressController cPg = Get.find();
      cPg.saveJournal(MyResource.READING_JOURNAL, model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width, // match parent(all screen)
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              'pages'.tr,
              style: const TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3.2,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                      bottom: 10, top: 10, left: 15, right: 15),
                  child: TextField(
                    controller: controller,
                    minLines: 1,
                    maxLines: 1,
                    cursorColor: AppColors.VIOLET,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 27,
                        fontStyle: FontStyle.normal,
                        color: AppColors.primary,
                        decoration: TextDecoration.none),
                    decoration: null,
                  ),
                )),
          ),
          const SizedBox(height: 40),
          PrimaryCircleButton(
            icon: const Icon(Icons.arrow_forward, color: AppColors.primary),
            onPressed: () {
              saveProg(widget.isSkip);
              widget.onPressed();
              OrderUtil().getRouteById(4).then((value) {
                Get.off(() => widget.fromHomeMenu ? const ProgressPage() : value);
              });
            },
          ),
        ],
      ),
    );
  }
}
