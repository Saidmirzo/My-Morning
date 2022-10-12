import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/progress.dart';
import 'package:intl/intl.dart';
import '../../diary/diary_page.dart';

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
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/diary_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // appBarProgress('my_diary'.tr),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 67, left: 25),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.west,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.04),
            buildTitle(),
            const SizedBox(height: 25),
            Expanded(
              child: Hero(
                tag: widget.id,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(
                        bottom: 21.48, left: 23, right: 23, top: 0),
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
                              Container(width: 10),
                              Text(DateFormat('yyyy-MM-dd – kk:mm')
                                  .format(DateTime.parse(widget.date))),
                              const Spacer(),
                              // GestureDetector(
                              //   onTap: () {
                              //     setState(() {
                              //       isEnabled = true;
                              //     });
                              //     Future.delayed(
                              //         const Duration(milliseconds: 300), () {
                              //       setFocus();
                              //     });
                              //   },
                              //   child: const Icon(Icons.edit_outlined),
                              // ),
                              // Container(width: 10),
                              // InkWell(
                              //   onTap: () {
                              //     print('!!!delete_outline!!!');
                              //     _showAlert(context);
                              //   },
                              //   child: const Icon(
                              //     Icons.delete_outline,
                              //     //size: 40,
                              //     //color: AppColors.VIOLET,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                              child: TextField(
                            focusNode: focusNode,
                            controller: controller,
                            maxLines: 100,
                            enabled: true,
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
                      color: Colors.white.withOpacity(.47),
                    ),
                  ),
                ),
              ),
            ),
            saveBtn(context),
            const SizedBox(
              height: 30,
            )
          ],
        ),
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
            .push(MaterialPageRoute(builder: (context) => const DiaryPage()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: const Color(0xff592F72),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Save note'.tr,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'sure'.tr,
                  style: const TextStyle(
                    color: AppColors.VIOLET,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Montserrat",
                  ),
                ),
                Image.asset(
                  'assets/images/diary/warning_icon.png',
                  width: 90,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: onPositiveAnswer,
                      child: Container(
                        width: 80,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Text(
                          'yes'.tr,
                          style: const TextStyle(
                            color: AppColors.VIOLET,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: onNegativeAnswer,
                      child: Container(
                        width: 80,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.VIOLET,
                        ),
                        child: Text(
                          'no'.tr,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onPositiveAnswer() {
    setState(() {
      widget.map.remove(widget.date);
      myDbBox.put(MyResource.DIARY_JOURNAL, widget.map);
    });
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DiaryPage(),
      ),
    );
  }

  void onNegativeAnswer() => Get.to(const DiaryPage());

  // _showAlert(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         titleTextStyle: const TextStyle(
  //           backgroundColor: AppColors.SHADER_BOTTOM,
  //         ),
  //         titlePadding: const EdgeInsets.all(0),
  //         contentPadding: const EdgeInsets.all(0),
  //         actionsPadding: const EdgeInsets.all(0),
  //         buttonPadding: const EdgeInsets.all(0),
  //         backgroundColor: AppColors.BOTTOM_GRADIENT,
  //         content: SizedBox(
  //           height: MediaQuery.of(context).size.height * 0.2,
  //           width: MediaQuery.of(context).size.width,
  //           child: Column(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 20),
  //                 child: Text(
  //                   'sure'.tr,
  //                   style: const TextStyle(
  //                     color: AppColors.VIOLET,
  //                     fontSize: 40,
  //                   ),
  //                 ),
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   FlatButton(
  //                     child: Text(
  //                       'yes'.tr,
  //                       style: const TextStyle(
  //                         color: AppColors.FIX_TOP,
  //                         fontSize: 40,
  //                       ),
  //                     ),
  //                     onPressed: () {
  //                       setState(() {
  //                         widget.map.remove(widget.date);
  //                         myDbBox.put(MyResource.DIARY_JOURNAL, widget.map);
  //                       });
  //                       Navigator.of(context).pop();
  //                       Navigator.of(context).pop();
  //                       Navigator.of(context).pop();
  //                       Navigator.of(context).push(MaterialPageRoute(
  //                           builder: (context) => MyDiaryProgress()));
  //                     },
  //                   ),
  //                   FlatButton(
  //                     child: Text(
  //                       'no'.tr,
  //                       style: const TextStyle(
  //                         color: AppColors.FIX_TOP,
  //                         fontSize: 40,
  //                       ),
  //                     ),
  //                     onPressed: () {
  //                       //Put your code here which you want to execute on No button click.
  //                       Navigator.of(context).pop();
  //                     },
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  Text buildTitle() {
    return Text(
      'diary'.tr,
      style: TextStyle(
        fontSize: Get.height * 0.035,
        fontStyle: FontStyle.normal,
        color: AppColors.WHITE,
      ),
    );
  }
}
