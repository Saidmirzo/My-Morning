import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:morningmagic/analyticService.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/note/note.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/model/progress/vocabulary_progress/vocabulary_note_progress.dart';
import 'package:morningmagic/db/progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/widgets/animatedButton.dart';

class NoteScreen extends StatefulWidget {
  @override
  State createState() {
    return NoteScreenState();
  }
}

class NoteScreenState extends State<NoteScreen> {
  TextEditingController textEditingController;
  int count;
  DateTime date = DateTime.now();

  String getInputString() {
    Note note =
        MyDB().getBox().get(MyResource.NOTE_KEY, defaultValue: Note(""));
    return note.note;
  }

  @override
  void initState() {
    initEditText();
    super.initState();
    count = MyDB().getBox().get(MyResource.NOTE_COUNT) ?? 0;
    Future.delayed(Duration(days: 1), () {
      MyDB().getBox().put(MyResource.NOTE_COUNT, 0);
    });
    AnalyticService.screenView('text_note_page');
  }

  void initEditText() {
    textEditingController = new TextEditingController(text: getInputString());
    textEditingController.addListener(() async {
      if (textEditingController.text != null &&
          textEditingController.text.isNotEmpty) {
        await MyDB()
            .getBox()
            .put(MyResource.NOTE_KEY, Note(textEditingController.text));
      }
    });
  }

  void saveProg(String box, String path) {
    DateTime date = DateTime.now();
    List<dynamic> list = MyDB().getBox().get(box) ?? [];
    setState(() {
      list.add([
        list.isNotEmpty ? (int.parse(list.last[0]) + 1).toString() : '0',
        path,
        '${date.day}.${date.month}.${date.year}',
      ]);
    });
    MyDB().getBox().put(box, list);
  }

  void saveNoteProgress() {
    if (textEditingController.text != null &&
        textEditingController.text.isNotEmpty) {
      VocabularyNoteProgress noteProgress =
          VocabularyNoteProgress(textEditingController.text);
      saveProg(MyResource.NOTEPADS, noteProgress.note);
      Day day = ProgressUtil()
          .createDay(null, null, null, null, noteProgress, null, null);
      ProgressUtil().updateDayList(day);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: Center(
          child: Container(
              width:
                  MediaQuery.of(context).size.width, // match parent(all screen)
              height: MediaQuery.of(context)
                  .size
                  .height, // match parent(all screen)
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.TOP_GRADIENT,
                  AppColors.MIDDLE_GRADIENT,
                  AppColors.BOTTOM_GRADIENT
                ],
              )),
              child: LayoutBuilder(builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width / 2.3,
                              bottom: MediaQuery.of(context).size.width / 7),
                          child: Text(
                            'note'.tr(),
                            style: TextStyle(
                              fontSize: 32,
                              fontStyle: FontStyle.normal,
                              fontFamily: "rex",
                              color: AppColors.WHITE,
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 30,
                                right: MediaQuery.of(context).size.width / 30),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: AppColors.TRANSPARENT_WHITE,
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: TextField(
                                    controller: textEditingController,
                                    minLines: 5,
                                    maxLines: 5,
                                    cursorColor: AppColors.VIOLET,
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 27,
                                        fontFamily: "rex",
                                        fontStyle: FontStyle.normal,
                                        color: AppColors.VIOLET,
                                        decoration: TextDecoration.none),
                                    decoration: null,
                                  ),
                                ))),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width / 3,
                              bottom: MediaQuery.of(context).size.width / 5),
                          child: AnimatedButton(() {
                            AssetsAudioPlayer assetsAudioPlayer =
                                AssetsAudioPlayer();
                            assetsAudioPlayer
                                .open(Audio("assets/audios/success.mp3"));
                            assetsAudioPlayer.play();
                            saveNoteProgress();
                            OrderUtil().getRouteById(3).then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TimerSuccessScreen(
                                              () {
                                            Navigator.push(context, value);
                                          },
                                              MyDB()
                                                  .getBox()
                                                  .get(MyResource
                                                      .VOCABULARY_TIME_KEY)
                                                  .time,
                                              false)));
                            });
                          }, 'rex', 'next_button'.tr(), 22, null, null),
                        ),
                      ],
                    ),
                  ),
                );
              })),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    saveNoteProgress();
    return true;
  }
}
