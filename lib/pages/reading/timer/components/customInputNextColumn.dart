import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/book/book.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/model/progress/reading_progress/reading_progress.dart';
import 'package:morningmagic/db/progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/progress/progress_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:get/get.dart';

import '../../../../resources/colors.dart';
import '../../../../widgets/primary_circle_button.dart';

class InputTextColumn extends StatefulWidget {
  final VoidCallback onPressed;
  final bool fromHomeMenu;
  InputTextColumn(this.onPressed, {this.fromHomeMenu = false});

  @override
  State createState() {
    return InputTextColumnState();
  }
}

class InputTextColumnState extends State<InputTextColumn> {
  TextEditingController controller = TextEditingController();
  ReadingProgress readingProgress;
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  void saveProg() {
    String type = 'reading_small'.tr;
    var box = MyResource.MY_READING_PROGRESS;
    Day day = ProgressUtil()
        .createDay(null, null, null, readingProgress, null, null, null);
    ProgressUtil().updateDayList(day);
    Book book =
        MyDB().getBox().get(MyResource.BOOK_KEY, defaultValue: Book(""));
    int pages = int.tryParse(controller.text) ?? 0;
    readingProgress = ReadingProgress(book.bookName, pages);
    List<dynamic> tempList;
    List<dynamic> list = MyDB().getBox().get(box) ?? [];
    tempList = list;
    print(list);
    print(tempList);
    if (list.isNotEmpty) {
      if (list.last[2] == '${date.day}.${date.month}.${date.year}') {
        list.add([
          tempList.isNotEmpty ? '${(int.parse(tempList.last[0]) + 1)}' : '0',
          tempList[tempList.indexOf(tempList.last)][1] +
              '\n$type - ${readingProgress.book} (${readingProgress.pages} ' +
              'pages_note'.tr +
              ')',
          '${date.day}.${date.month}.${date.year}'
        ]);
        list.removeAt(list.indexOf(list.last) - 1);
      } else {
        list.add([
          list.isNotEmpty ? '${(int.parse(list.last[0]) + 1)}' : '0',
          '\n$type - ${readingProgress.book} (${readingProgress.pages} ' +
              'pages_note'.tr +
              ')',
          '${date.day}.${date.month}.${date.year}'
        ]);
      }
    } else {
      list.add([
        list.isNotEmpty ? '${(int.parse(list.last[0]) + 1)}' : '0',
        '\n$type - ${readingProgress.book} (${readingProgress.pages} ' +
            'pages_note'.tr +
            ')',
        '${date.day}.${date.month}.${date.year}'
      ]);
    }
    MyDB().getBox().put(box, list);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // match parent(all screen)
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              'pages'.tr,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3.2,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                ),
                child: Container(
                  padding:
                      EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
                  child: TextField(
                    controller: controller,
                    minLines: 1,
                    maxLines: 1,
                    cursorColor: AppColors.VIOLET,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
            icon: Icon(Icons.arrow_forward, color: AppColors.primary),
            onPressed: () {
              saveProg();
              widget.onPressed();
              OrderUtil().getRouteById(4).then((value) {
                Get.off(widget.fromHomeMenu ? ProgressPage() : value);
              });
            },
          ),
        ],
      ),
    );
  }
}
