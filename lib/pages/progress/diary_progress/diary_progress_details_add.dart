import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:morningmagic/db/model/progress/diary_progress/diary_note_progress.dart';
import 'package:morningmagic/pages/progress/components/appbar.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/progress.dart';

import 'diary_progress.dart';

class JournalMyDitailsAdd extends StatefulWidget {
  @override
  _JournalMyDitailsAddState createState() => _JournalMyDitailsAddState();
}

class _JournalMyDitailsAddState extends State<JournalMyDitailsAdd> {
  DateTime date = DateTime.now();
  RxString text = ''.obs;
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width:
                MediaQuery.of(context).size.width, // match parent(all screen)
            height:
                MediaQuery.of(context).size.height, // match parent(all screen)
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.repeated,
                colors: [
                  AppColors.TOP_GRADIENT,
                  AppColors.MIDDLE_GRADIENT,
                  AppColors.BOTTOM_GRADIENT,
                ],
              ),
            ),
            child: Column(
              children: [
                appBarProgress('my_diary'.tr),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(
                        bottom: 15, left: 5, right: 5, top: 15),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Icon(Icons.access_time),
                              ),
                              Container(
                                width: 10,
                              ),
                              Text(
                                '${date.day}.${date.month}.${date.year}',
                                style: TextStyle(),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              minLines: 10,
                              //controller: nameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Text',
                              ),
                              onChanged: (value) {
                                text.value = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      border: Border.all(width: 1, color: AppColors.BLUE),
                    ),
                  ),
                ),
                addBtn(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InkWell addBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        var model = DiaryNoteProgress(text.value, 0, true);
        ProgressController pg = Get.find();
        pg.saveDiaryJournal(model);
        setState(() {});
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MyDiaryProgress()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              size: 40,
              //color: AppColors.VIOLET,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10,
              ),
              //width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                'save_diary'.tr,
                //textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.VIOLET,
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_showAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        titleTextStyle: TextStyle(
          backgroundColor: AppColors.SHADER_BOTTOM,
        ),
        titlePadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(0),
        buttonPadding: EdgeInsets.all(0),
        backgroundColor: AppColors.BOTTOM_GRADIENT,
        content: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Вы уверены ?',
                  style: TextStyle(
                    color: AppColors.VIOLET,
                    fontSize: 40,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    child: Text(
                      "Да",
                      style: TextStyle(
                        color: AppColors.FIX_TOP,
                        fontSize: 40,
                      ),
                    ),
                    onPressed: () {
                      //Put your code here which you want to execute on Yes button click.
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "Нет",
                      style: TextStyle(
                        color: AppColors.FIX_TOP,
                        fontSize: 40,
                      ),
                    ),
                    onPressed: () {
                      //Put your code here which you want to execute on No button click.
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
