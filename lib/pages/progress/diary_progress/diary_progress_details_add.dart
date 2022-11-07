import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.repeated,
                colors: [
                  AppColors.topGradient,
                  AppColors.middleGradient,
                  AppColors.bottomGradient,
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
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.access_time),
                              ),
                              Container(
                                width: 10,
                              ),
                              Text(
                                '${date.day}.${date.month}.${date.year}',
                                style: const TextStyle(),
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
                              decoration: const InputDecoration(
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
                      border: Border.all(width: 1, color: AppColors.blue),
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
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_circle_outline,
              size: 40,
              //color: AppColors.violet,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              //width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                'save_diary'.tr,
                //textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.violet,
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
        titleTextStyle: const TextStyle(
          backgroundColor: AppColors.shaderBottom,
        ),
        titlePadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.all(0),
        actionsPadding: const EdgeInsets.all(0),
        buttonPadding: const EdgeInsets.all(0),
        backgroundColor: AppColors.bottomGradient,
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('sure'.tr,
                  style: const TextStyle(
                    color: AppColors.violet,
                    fontSize: 40,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text('yes'.tr,
                      style: const TextStyle(
                        color: AppColors.fixTop,
                        fontSize: 40,
                      ),
                    ),
                    onPressed: () {
                      //Put your code here which you want to execute on Yes button click.
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('no'.tr,
                      style: const TextStyle(
                        color: AppColors.fixTop,
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
