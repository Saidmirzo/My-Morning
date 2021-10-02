import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/progress/components/appbar.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/progress.dart';

import 'diary_progress.dart';

class journalMyDitails extends StatefulWidget {
  String id;
  String text;
  String date;
  Map<String, dynamic> map;

  journalMyDitails(this.id, this.text, this.date, this.map);

  @override
  _journalMyDitailsState createState() => _journalMyDitailsState();
}

class _journalMyDitailsState extends State<journalMyDitails> {
  TextEditingController controller;
  FocusNode focusNode;
  bool isEnabled = false;
  ProgressController progressController = Get.find();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
    focusNode = FocusNode();
    focusNode.addListener(
        () => print('focusNode updated: hasFocus: ${focusNode.hasFocus}'));
  }

  void setFocus() {
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                  child: Hero(
                    tag: widget.id,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(
                            bottom: 15, left: 5, right: 5, top: 15),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Icon(Icons.access_time),
                                  ),
                                  Container(width: 10),
                                  Text(widget.date),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isEnabled = true;
                                      });
                                      Future.delayed(
                                          Duration(milliseconds: 300), () {
                                        setFocus();
                                      });
                                    },
                                    child: Icon(Icons.edit_outlined),
                                  ),
                                  Container(width: 10),
                                  InkWell(
                                    onTap: () {
                                      print('!!!delete_outline!!!');
                                      _showAlert(context);
                                    },
                                    child: Icon(
                                      Icons.delete_outline,
                                      //size: 40,
                                      //color: AppColors.VIOLET,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                  child: TextField(
                                focusNode: focusNode,
                                controller: controller,
                                maxLines: 100,
                                enabled: isEnabled ? true : false,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                // enabled: true,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.04, //16,
                                  color: Colors.black54,
                                ),
                              )),
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
                  ),
                ),
                saveBtn(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InkWell saveBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.map[widget.date].note = controller.text;
          myDbBox.put(MyResource.DIARY_JOURNAL, widget.map);
        });
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
              child: Text('save_diary'.tr,
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.VIOLET,
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                  )),
            ),
          ],
        ),
      ),
    );
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
                    'sure'.tr,
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
                        'yes'.tr,
                        style: TextStyle(
                          color: AppColors.FIX_TOP,
                          fontSize: 40,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.map.remove(widget.date);
                          myDbBox.put(MyResource.DIARY_JOURNAL, widget.map);
                        });
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyDiaryProgress()));
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'no'.tr,
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
}
