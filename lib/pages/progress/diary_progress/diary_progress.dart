import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/progress/diary_progress/diary_record_progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/progress/components/appbar.dart';
import 'package:morningmagic/resources/colors.dart';

import 'diary_progress_details_add.dart';
import 'diary_progress_ditails.dart';

class MyDiaryProgress extends StatefulWidget {
  @override
  _MyDiaryProgressState createState() => _MyDiaryProgressState();
}

class _MyDiaryProgressState extends State<MyDiaryProgress> {
  Map<String, dynamic> _map;
  @override
  void initState() {
    super.initState();
    try {
      _map = MyDB().getDiaryProgress();
    } catch (e) {
      print('error get reading progress');
      myDbBox.put(MyResource.DIARY_JOURNAL, {});
      _map = MyDB().getDiaryProgress();
    }
  }

  AudioPlayer audioPlayer = AudioPlayer();

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
            //SingleChildScrollView
            child: Column(
              children: [
                appBarProgress('my_diary'.tr),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: GridView(
                      children: _map.isNotEmpty
                          ? List.generate(
                              _map.length,
                              (index) {
                                var key = _map.keys.toList()[index];
                                return _map[key] is DiaryRecordProgress
                                    ? CategoryRecordItem(
                                        key,
                                        _map[key].path,
                                        key,
                                        audioPlayer,
                                      )
                                    : CategoryItem(
                                        key,
                                        _map[key].note,
                                        key,
                                        _map,
                                      );
                              },
                            )
                          : [],
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.of(context).size.width * 0.5,
                        childAspectRatio: 5 / 4.1,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                      ),
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => JournalMyDitailsAdd()));
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
                'add_note'.tr,
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

class CategoryItem extends StatelessWidget {
  final String id;
  final String text;
  final String date;
  final Map<String, dynamic> map;

  CategoryItem(this.id, this.text, this.date, this.map);

  void selectCategory(BuildContext ctx) {
    Navigator.push(
        ctx,
        MaterialPageRoute(
            builder: (context) => journalMyDitails(id, text, date, map)));
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => selectCategory(context),
          //splashColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
            margin: const EdgeInsets.only(
              bottom: 15,
              left: 5,
              right: 5,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04, //16,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.access_time),
                      ),
                      Text(
                        DateFormat.yMMMEd()
                            .format(DateTime.parse(date))
                            .toString(),
                        style: TextStyle(),
                      )
                    ],
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
      ),
    );
  }
}

// TODO remove one of players
class CategoryRecordItem extends StatefulWidget {
  final String id;
  final String text;
  final String date;
  final AudioPlayer audioPlayer;

  CategoryRecordItem(this.id, this.text, this.date, this.audioPlayer);

  @override
  _CategoryRecordItemState createState() => _CategoryRecordItemState();
}

class _CategoryRecordItemState extends State<CategoryRecordItem> {
  var isPlayed = false.obs;

  void onPlayAudio() async {
    isPlayed.value = true;
    await widget.audioPlayer?.play(widget.text, isLocal: true);
  }

  void onStopAudio() async {
    isPlayed.value = false;
    await widget.audioPlayer?.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
        margin: const EdgeInsets.only(
          bottom: 15,
          left: 5,
          right: 5,
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    isPlayed.value ? onStopAudio() : onPlayAudio();
                  },
                  child: Obx(() => Icon(
                      isPlayed.value ? Icons.pause : Icons.play_arrow,
                      size: 70,
                      color: AppColors.VIOLET)),
                ),
              ),
            ),
            Spacer(),
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(Icons.access_time),
                  ),
                  Text(
                    DateFormat.yMMMEd()
                        .format(DateTime.parse(widget.date))
                        .toString(),
                    style: TextStyle(),
                  )
                ],
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
    );
  }
}
