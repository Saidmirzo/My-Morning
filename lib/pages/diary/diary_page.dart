import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/progress/diary_progress/diary_note_progress.dart';
import 'package:morningmagic/db/model/progress/diary_progress/diary_record_progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/dialog/back_to_main_menu_dialog.dart';
import 'package:morningmagic/pages/diary/diary_provider.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/resources/styles.dart';
import 'package:morningmagic/routing/route_values.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/storage.dart';
import 'package:provider/provider.dart';
import '../progress/diary_progress/diary_progress_ditails.dart';
import 'timer/note_page.dart';
import 'timer/audio_record_page.dart';

class DiaryPage extends StatefulWidget {
  final bool fromHomeMenu;
  const DiaryPage({Key key, this.fromHomeMenu = false}) : super(key: key);
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  Map<String, dynamic> _map;
  int i = -1;
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
    context.read<DiaryProvider>().onDispose();
  }

// @override
//   void dispose() {
//     super.dispose();
//   }

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/diary_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 67, left: 31),
                    child: GestureDetector(
                      onTap: () {
                        if (isComplex) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const BackToMainMenuDialog();
                            },
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MainMenuPage()),
                          );
                        }
                      },
                      child: const Icon(
                        Icons.west,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text('diary'.tr, style: AppStyles.trainingTitle),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: _map.length,
                    itemBuilder: (context, i) {
                      var key = _map.keys.toList()[i];
                      return DiaryItem(
                        lenght: _map.length,
                        title: _map[key] is DiaryNoteProgress ? _map[key].note : null,
                        audioPlayer: audioPlayer,
                        isRecord: _map[key] is DiaryRecordProgress,
                        id: key,
                        date: DateTime.parse(key),
                        map: _map,
                        index: i,
                      );
                    },
                  ),
                ),

                //////////////////////////////////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 31),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xff592F72).withOpacity(.5),
                            blurRadius: 50,
                            spreadRadius: 15,
                            offset: const Offset(0, -10),
                            blurStyle: BlurStyle.normal),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Get.to(() => TimerNotePage(fromHomeMenu: widget.fromHomeMenu)),
                            child: Container(
                              height: 70,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: const Color(0xff592F72),
                              ),
                              child: Text(
                                'Add note'.tr,
                                style: const TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: Get.height * 0.01),
                        GestureDetector(
                          onTap: () => Get.to(() => TimerRecordPage(fromHomeMenu: widget.fromHomeMenu)),
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: const Color(0xff592F72),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 26),
                              child: Image.asset(
                                'assets/images/micrafon.png',
                              ),
                            ),
                          ),
                        ),
                        // PrimaryButton(
                        //     child: Image.asset('assets/images/micrafon.png'),
                        //     pWidth: 0.2,
                        //     onPressed: () => Get.to(TimerRecordPage(
                        //         fromHomeMenu: widget.fromHomeMenu))),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 69.4,
                ),
              ],
            ),
            if (isComplex)
              Positioned(
                top: 40,
                right: 30,
                child: GestureDetector(
                  onTap: () {
                    appAnalitics.logEvent('first_menu_setings');
                    Navigator.pushNamed(context, settingsPageRoute);
                  },
                  child: Container(
                    width: 47.05,
                    height: 47.05,
                    padding: const EdgeInsets.all(12.76),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      'assets/images/home_menu/settings_icon_2.png',
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DiaryItem extends StatefulWidget {
  const DiaryItem({
    Key key,
    this.lenght,
    this.id,
    this.audioPlayer,
    this.title,
    this.isRecord,
    this.date,
    this.map,
    this.index,
  }) : super(key: key);
  final int lenght;
  final DateTime date;
  final String id;
  final AudioPlayer audioPlayer;
  final String title;
  final bool isRecord;
  final Map<String, dynamic> map;
  final int index;

  @override
  State<DiaryItem> createState() => _DiaryItemState();
}

class _DiaryItemState extends State<DiaryItem> {
  var isPlayed = false.obs;

  void onPlayAudio(DiaryProvider prov) async {
    isPlayed.value = true;
    await widget.audioPlayer?.play(AssetSource(widget.map[widget.id].path));
    widget.audioPlayer.onPlayerComplete.listen((event) {
      prov.selectAudio(-1);
    });
    prov.selectAudio(widget.index);
  }

  void onStopAudio(DiaryProvider prov) async {
    isPlayed.value = false;
    await widget.audioPlayer?.stop();
    prov.selectAudio(-1);
  }

  final List<String> weekdays = [
    'Monday'.tr,
    'Tuesday'.tr,
    'Wednesday'.tr,
    'Thursday'.tr,
    'Friday'.tr,
    'Saturday'.tr,
    'Sunday'.tr,
  ];

  final List<String> months = [
    'January'.tr,
    'February'.tr,
    'March'.tr,
    'April'.tr,
    'May'.tr,
    'June'.tr,
    'July'.tr,
    'August'.tr,
    'September'.tr,
    'October'.tr,
    'November'.tr,
    'December'.tr,
  ];

  @override
  Widget build(BuildContext context) {
    DiaryProvider prov = context.watch<DiaryProvider>();
    return GestureDetector(
      onTap: widget.isRecord
          ? null
          : () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          journalMyDitails(widget.id, widget.title ?? 'voice_note'.tr, widget.id, widget.map)));
            },
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.fromLTRB(31, 0, 31, 10),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 0.5),
            child: Container(
              width: double.maxFinite,
              // margin: const EdgeInsets.fromLTRB(31, 0, 31, 10),
              padding: const EdgeInsets.symmetric(horizontal: 28.9, vertical: 28.4),
              decoration: BoxDecoration(
                color: menuState == MenuState.NIGT ? const Color(0xffFAF5FF) : Colors.white.withOpacity(.37),
                borderRadius: BorderRadius.circular(19),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: widget.isRecord
                        ? () {
                            isPlayed.value ? onStopAudio(prov) : onPlayAudio(prov);
                          }
                        : null,
                    child: Image.asset(
                      widget.isRecord
                          ? prov.i == widget.index
                              ? 'assets/images/meditation/stop_icon.png'
                              : 'assets/images/meditation/resume_icon.png'
                          : 'assets/images/diary/paper_icon.png',
                      width: 30,
                      height: 30,
                      color: const Color(0xff592F72),
                    ),
                  ),
                  const SizedBox(
                    width: 13.81,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title ?? 'voice_note'.tr,
                          style: const TextStyle(
                            color: Color(0xff592F72),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          '${weekdays[widget.date.weekday - 1]}, ${widget.date.day} ${months[widget.date.month - 1]} , ${widget.date.year}',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertForDelete(
                            audioPlayer: widget.audioPlayer,
                            mapKey: widget.id,
                            map: widget.map,
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.close,
                      color: Color(0xff592F72),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AlertForDelete extends StatefulWidget {
  const AlertForDelete({Key key, this.map, this.mapKey, this.audioPlayer}) : super(key: key);
  final Map<String, dynamic> map;
  final String mapKey;
  final AudioPlayer audioPlayer;
  @override
  State<AlertForDelete> createState() => _AlertForDeleteState();
}

class _AlertForDeleteState extends State<AlertForDelete> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  color: Colors.white.withOpacity(.1),
                ),
              ),
            ),
          ),
          Column(
            children: [
              const Spacer(),
              Container(
                width: double.maxFinite,
                margin: const EdgeInsets.symmetric(horizontal: 31),
                padding: const EdgeInsets.fromLTRB(17, 18.6, 17, 19.3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.close,
                          color: Color(0xff592F72),
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/diary/warning_icon.png',
                      width: 60.78,
                      height: 60.78,
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Text(
                      'Are you sure you want to delete a note?'.tr,
                      style: const TextStyle(
                        color: Color(0xff592F72),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.audioPlayer.stop();
                        setState(() {
                          widget.map.remove(widget.mapKey);
                          myDbBox.put(MyResource.DIARY_JOURNAL, widget.map);
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DiaryPage(
                                      fromHomeMenu: true,
                                    )));
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: 61.25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xff592F72),
                          borderRadius: BorderRadius.circular(16.96),
                        ),
                        child: Text(
                          'Delete a note'.tr,
                          style: const TextStyle(
                            color: Color(0xffFFFFFE),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
