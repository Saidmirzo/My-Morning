import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/notepad.dart';
import 'package:morningmagic/db/resource.dart';

import '../app_states.dart';
import '../resources/colors.dart';

import 'journalMyDetailsAdd.dart';
import 'journalMyDitails.dart';
import 'package:easy_localization/easy_localization.dart';

class journalMy extends StatefulWidget {
  @override
  _journalMyState createState() => _journalMyState();
}

class _journalMyState extends State<journalMy> {
  List<dynamic> list;
  @override
  void initState() {
    super.initState();
    list = MyDB().getBox().get(MyResource.NOTEPADS) ?? [];
    print(MyDB().getBox().get(MyResource.NOTEPADS));
  }

  AudioPlayer audioPlayer = AudioPlayer();
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
            //SingleChildScrollView
            child: Padding(
              padding: const EdgeInsets.only(top: 75, bottom: 75),
              child: GridView(
                //padding: const EdgeInsets.all(25),
                children: list.isNotEmpty
                    ? List.generate(
                        list.length,
                        (index) => !list[index][1].contains('/')
                            ? CategoryItem(
                                list.isNotEmpty ? list[index][0] : '0',
                                list.isNotEmpty ? list[index][1] : '0',
                                list.isNotEmpty ? list[index][2] : '01.01.2020',
                              )
                            : CategoryRecordItem(
                                list.isNotEmpty ? list[index][0] : '0',
                                list.isNotEmpty ? list[index][1] : '0',
                                list.isNotEmpty ? list[index][2] : '01.01.2020',
                                audioPlayer,
                              ),
                      )
                    : [],
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                  childAspectRatio: 5 / 4.1,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => JournalMyDitailsAdd()));
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
                        'add_note'.tr(),
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

class CategoryItem extends StatelessWidget {
  final String id;
  final String text;
  final String date;

  CategoryItem(this.id, this.text, this.date);

  void selectCategory(BuildContext ctx) {
    Navigator.push(
        ctx,
        MaterialPageRoute(
            builder: (context) => journalMyDitails(id, text, date)));
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
                    //style: Theme.of(context).textTheme.title,
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
                        date,
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
  final assetsAudioPlayer = AssetsAudioPlayer();

  void onPlayAudio() async {
    isPlayed.value = true;
    await widget.audioPlayer.play(widget.text, isLocal: true);
  }

  void onStopAudio() async {
    isPlayed.value = false;
    await widget.audioPlayer.stop();
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
                child: StreamBuilder<AudioPlayerState>(
                    stream: widget.audioPlayer.onPlayerStateChanged,
                    builder: (context, snapshot) {
                      if (snapshot.data == AudioPlayerState.COMPLETED) {
                        onStopAudio();
                      }
                      return GestureDetector(
                        onTap: () {
                          onPlayAudio();
                          if (snapshot.data == AudioPlayerState.STOPPED) {
                          } else if (snapshot.data ==
                              AudioPlayerState.PLAYING) {
                            onStopAudio();
                          }
                        },
                        child: Obx(() => Icon(
                            isPlayed.value ? Icons.pause : Icons.play_arrow,
                            size: 70,
                            color: AppColors.VIOLET)),
                      );
                    }),
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
                    widget.date,
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

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  AppStates appStates = Get.put(AppStates());

  List<dynamic> list;
  @override
  void initState() {
    super.initState();
    list = MyDB().getBox().get(MyResource.NOTEPADS);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 75, bottom: 75),
      child: GridView(
        //padding: const EdgeInsets.all(25),
        children: list != null
            ? List.generate(
                list != null ? list.length : 1,
                (index) => CategoryItem(
                  list[index].id,
                  list[index].text,
                  list[index].date,
                ),
              )
            : [],
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
          childAspectRatio: 5 / 4.1,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
      ),
    );
  }
}
