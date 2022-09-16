import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/progress/components/appbar.dart';
import 'package:morningmagic/pages/progress/diary_progress/diary_progress.dart';
import 'package:morningmagic/resources/colors.dart';

class journalMyDitails extends StatefulWidget {
  String id;
  String text;
  String date;

  journalMyDitails(this.id, this.text, this.date);

  @override
  _journalMyDitailsState createState() => _journalMyDitailsState();
}

class _journalMyDitailsState extends State<journalMyDitails> {
  List<dynamic> list;
  List<dynamic> tempList;
  TextEditingController controller;
  FocusNode focusNode;
  bool isEnabled = false;
  @override
  void initState() {
    super.initState();
    list = MyDB().getBox().get(MyResource.NOTEPADS);
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
            decoration: const BoxDecoration(
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
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(Icons.access_time),
                                  ),
                                  Container(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.date,
                                    style: const TextStyle(),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isEnabled = true;
                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 300), () {
                                        setFocus();
                                      });
                                    },
                                    child: const Icon(
                                      Icons.edit_outlined,
                                      //size: 40,
                                      //color: AppColors.VIOLET,
                                    ),
                                  ),
                                  Container(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print('!!!delete_outline!!!');
                                      _showAlert(context);
                                    },
                                    child: const Icon(
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
                                decoration: const InputDecoration(
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
          list.removeWhere((value) => value[0] == widget.id);
          list.insert(
              int.parse(widget.id), [widget.id, controller.text, widget.date]);
        });
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
              //color: AppColors.VIOLET,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              //width: MediaQuery.of(context).size.width * 0.75,
              child: Text('save_diary'.tr,
                  //textAlign: TextAlign.center,
                  style: const TextStyle(
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
          titleTextStyle: const TextStyle(
            backgroundColor: AppColors.SHADER_BOTTOM,
          ),
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(0),
          actionsPadding: const EdgeInsets.all(0),
          buttonPadding: const EdgeInsets.all(0),
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
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'sure'.tr,
                    style: const TextStyle(
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
                        style: const TextStyle(
                          color: AppColors.FIX_TOP,
                          fontSize: 40,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          list.removeWhere((value) => value[0] == widget.id);
                        });
                        setState(() {
                          MyDB().getBox().put(MyResource.NOTEPADS, list);
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
                        style: const TextStyle(
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
