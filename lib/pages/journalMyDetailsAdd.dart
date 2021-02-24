import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';

import '../app_states.dart';
import '../resources/colors.dart';
import 'journalMy.dart';

class JournalMyDitailsAdd extends StatefulWidget {
  @override
  _JournalMyDitailsAddState createState() => _JournalMyDitailsAddState();
}

class _JournalMyDitailsAddState extends State<JournalMyDitailsAdd> {
  DateTime date = DateTime.now();
  AppStates appStates = Get.put(AppStates());
  RxString text = ''.obs;
  TextEditingController controller;

  List<dynamic> list;
  @override
  void initState() {
    controller = TextEditingController();
    list = MyDB().getBox().get(MyResource.NOTEPADS) ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
            child: Container(
              padding: const EdgeInsets.all(15),
              margin:
                  const EdgeInsets.only(bottom: 75, left: 5, right: 5, top: 75),
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
                  Spacer(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: SingleChildScrollView(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 25,
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
                    // Text(
                    //   widget.text,
                    //   style: TextStyle(
                    //     fontSize:
                    //         MediaQuery.of(context).size.width * 0.04, //16,
                    //     color: Colors.black54,
                    //   ),
                    //   //style: Theme.of(context).textTheme.title,
                    // ),
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
          Positioned(
            top: 30,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.keyboard_arrow_left_rounded,
                    size: 40,
                    color: AppColors.VIOLET,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Text(
                      'my_diary'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.VIOLET,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: InkWell(
              onTap: () {
                print('!!!save note!!!');
                setState(() {
                  list.add([
                    list.isNotEmpty
                        ? (int.parse(list.last[0]) + 1).toString()
                        : '0',
                    text.value,
                    '${date.day}.${date.month}.${date.year}',
                  ]);
                });
                print(list);
                setState(() {
                  MyDB().getBox().put(MyResource.NOTEPADS, list);
                });
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => journalMy()));
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
                        'save_diary'.tr(),
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
            ),
          ),
        ],
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
        // title: Container(
        //   color: AppColors.VIOLET,
        //   child: Text(
        //     'Сообщение !',
        //     style: TextStyle(
        //       color: AppColors.VIOLET,
        //       backgroundColor: AppColors.SHADER_BOTTOM,
        //       fontSize: 30,
        //     ),
        //   ),
        // ),
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
