import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/book/book.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/model/progress/reading_progress/reading_progress.dart';
import 'package:morningmagic/db/progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:get/get.dart';

class InputTextColumn extends StatefulWidget {
  final VoidCallback onPressed;
  InputTextColumn(this.onPressed);

  @override
  State createState() {
    return InputTextColumnState();
  }
}

class InputTextColumnState extends State<InputTextColumn> {
  TextEditingController controller;
  ReadingProgress readingProgress;
  DateTime date = DateTime.now();

  @override
  void initState() {
    getTime().then((value) {
      Book book = value.get(MyResource.BOOK_KEY, defaultValue: Book(""));
      controller = TextEditingController();
      controller.addListener(() {
        if (controller != null && controller.text.isNotEmpty) {
          clearTextFunction(controller);
          int pages = int.tryParse(controller.text);
          readingProgress = ReadingProgress(book.bookName, pages);
        }
      });
    });
    super.initState();
  }

  void clearTextFunction(TextEditingController controller) {
    if (controller.text.contains(".") ||
        controller.text.contains("-") ||
        controller.text.contains(",") ||
        controller.text.contains(" ") ||
        (int.tryParse(controller.text) != null &&
            int.tryParse(controller.text) < 0)) {
      print("CLEAR !!!!!!!!!!");
      controller.clear();
      controller.text = "0";
    }
  }

  void saveProg(String box, String type) {
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

  Future<Box> getTime() async {
    return await MyDB().getBox();
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
                color: AppColors.LIGHT_VIOLET,
                fontStyle: FontStyle.normal,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3.2,
            padding: EdgeInsets.only(bottom: 20),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: AppColors.TRANSPARENT_WHITE,
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
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 27,
                        fontStyle: FontStyle.normal,
                        color: AppColors.VIOLET,
                        decoration: TextDecoration.none),
                    decoration: null,
                  ),
                )),
          ),
          Container(
            child: ButtonTheme(
              minWidth: 170.0,
              height: 50.0,
              child: RaisedButton(
                elevation: 0,
                onPressed: () {
                  OrderUtil().getRouteById(4).then((value) {
                    Navigator.push(context, value);
                  });
                  saveReadingProgress();
                  widget.onPressed();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(38.0)),
                child: Text(
                  'continue'.tr,
                  style: TextStyle(
                    color: AppColors.WHITE,
                    fontStyle: FontStyle.normal,
                    fontSize: 21,
                  ),
                ),
                color: AppColors.PINK,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void saveReadingProgress() {
    if (readingProgress != null) {
      Day day = ProgressUtil()
          .createDay(null, null, null, readingProgress, null, null, null);
      ProgressUtil().updateDayList(day);
      saveProg(MyResource.MY_READING_PROGRESS, 'reading_small'.tr);
    }
  }
}
