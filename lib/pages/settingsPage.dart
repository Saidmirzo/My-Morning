import 'dart:async';
import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../db/model/affirmation_text/affirmation_text.dart';
import '../db/model/book/book.dart';
import '../db/model/exercise_time/exercise_time.dart';
import '../db/model/user/user.dart';
import '../db/resource.dart';
import '../dialog/paymentDialog.dart';
import '../pages/menuPage.dart';
import '../resources/colors.dart';
import '../storage.dart';
import '../widgets/animatedButton.dart';
import '../widgets/language_switcher.dart';
import '../widgets/remove_progress.dart';
import '../widgets/subscribe_1_month_button.dart';
import '../widgets/wrapTable.dart';
//ftden45
import 'package:morningmagic/dialog/exerciseDialog.dart';

class SettingsPage extends StatefulWidget {
  int nomerCat = 0;
  int _numSubCategor = 0;
  SettingsPage([this.nomerCat, this._numSubCategor]);

  @override
  State createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  TextEditingController affirmationTimeController;
  TextEditingController meditationTimeController;
  TextEditingController fitnessTimeController;
  TextEditingController vocabularyTimeController;
  TextEditingController readingTimeController;
  TextEditingController visualizationTimeController;
  TextEditingController affirmationTextController;
  TextEditingController bookController;
  TextEditingController nameController;
  Widget tableList;

  //ftden45 start

  @override
  void dispose() {
    affirmationTimeController.dispose();
    meditationTimeController.dispose();
    fitnessTimeController.dispose();
    vocabularyTimeController.dispose();
    readingTimeController.dispose();
    visualizationTimeController.dispose();

    affirmationTextController.dispose();
    bookController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _init();
    _initOpenDialog();
    initPurchaseListiner();
    tableList = wrapTable(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController =
        PrimaryScrollController.of(context) ?? ScrollController();

    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: 35),
            width:
                MediaQuery.of(context).size.width, // match parent(all screen)
            decoration: BoxDecoration(
                gradient: RadialGradient(
              colors: [AppColors.LIGHT_CREAM, AppColors.CREAM],
              radius: 0.6,
              center: Alignment(0.6, -0.2),
            )),
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Form(
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Container(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'choose'.tr(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: AppColors.VIOLET,
                                  fontFamily: 'sans-serif-black',
                                  fontStyle: FontStyle.normal,
                                  fontSize: 26),
                            ),
                          )),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.only(top: 5, left: 10),
                        child: Text(
                          'choose_title'.tr(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.VIOLET,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'sans-serif',
                              fontSize: 14),
                        ),
                      ),
                    ),
                    SliverPadding(padding: EdgeInsets.only(top: 15)),
                    tableList,
                    SliverToBoxAdapter(
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      child: Text(
                                    'duration'.tr(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: AppColors.VIOLET,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'sans-serif',
                                        fontSize: 14),
                                  )),
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      'magic_morning'.tr(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: AppColors.VIOLET,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'sans-serif',
                                          fontSize: 14),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      getAndCalculateTime(),
                                      style: TextStyle(
                                          color: AppColors.VIOLET,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'sans-serif',
                                          fontSize: 21),
                                    )))
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                          padding: EdgeInsets.only(top: 15, left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'write_affirmation'.tr(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: AppColors.VIOLET,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'sans-serif-black',
                                  fontSize: 26),
                            ),
                          )),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          //ftden45 start
                          InkWell(
                            onTap: () {
                              _showSimpleDialog(
                                  context,
                                  Container(),
                                  widget.nomerCat,
                                  true,
                                  0,
                                  widget._numSubCategor);
                            }, //_myAffermatciiDialog()
                            child: Container(
                              padding: EdgeInsets.only(left: 8, top: 5),
                              width: MediaQuery.of(context).size.width,
                              //height: MediaQuery.of(context).size.height * 0.1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                    child: Text('Выбрать готовую',
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
                          ),
                          //Text('${nomerCat}-${_numSubCategor}=zzzzzzzzzzzzzz'),
                          //ftden45
                          Container(
                            padding:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: AppColors.TRANSPARENT_WHITE,
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: TextField(
                                    controller: affirmationTextController,
                                    textInputAction: TextInputAction.next,
                                    onSubmitted: (_) =>
                                        FocusScope.of(context).nextFocus(),
                                    minLines: 6,
                                    maxLines: 6,
                                    cursorColor: AppColors.VIOLET,
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "sans-serif",
                                        fontStyle: FontStyle.normal,
                                        color: AppColors.VIOLET,
                                        decoration: TextDecoration.none),
                                    decoration: InputDecoration(
                                      hintMaxLines: 8,
                                      hintText: 'affirmation_hint'.tr(),
                                      hintStyle: TextStyle(
                                        color: AppColors.LIGHT_GRAY,
                                        fontSize: 16,
                                        fontFamily: "sans-serif",
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.only(left: 10, top: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'book_name'.tr(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: AppColors.VIOLET,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'sans-serif-black',
                                fontSize: 26),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: AppColors.TRANSPARENT_WHITE,
                            ),
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 11, bottom: 11, right: 20, left: 20),
                              child: TextField(
                                controller: bookController,
                                minLines: 1,
                                maxLines: 1,
                                cursorColor: AppColors.VIOLET,
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 23,
                                    fontFamily: "sans-serif",
                                    fontStyle: FontStyle.normal,
                                    color: AppColors.VIOLET,
                                    decoration: TextDecoration.none),
                                decoration: null,
                              ),
                            )),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.only(left: 10, top: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'enter_your_name'.tr(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: AppColors.VIOLET,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'sans-serif-black',
                                fontSize: 26),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: AppColors.TRANSPARENT_WHITE,
                            ),
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 11, bottom: 11, right: 20, left: 20),
                              child: TextField(
                                controller: nameController,
                                minLines: 1,
                                maxLines: 1,
                                cursorColor: AppColors.VIOLET,
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 23,
                                    fontFamily: "sans-serif",
                                    fontStyle: FontStyle.normal,
                                    color: AppColors.VIOLET,
                                    decoration: TextDecoration.none),
                                decoration: null,
                              ),
                            )),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: RemoveProgress(),
                    ),
                    SliverToBoxAdapter(
                      child: LanguageSwitcher(Alignment.centerLeft),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: AnimatedButton(
                            () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StartScreen())),
                            'sans-serif',
                            'continue'.tr(),
                            null,
                            null,
                            null),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.only(top: 10, bottom: 20),
                        child: Subscribe1MonthButton(),
                      ),
                    ),
                    SliverPadding(padding: EdgeInsets.only(bottom: 20)),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget wrapTable(bool needReinit) {
    return WrapTable(
        affirmationTimeController,
        meditationTimeController,
        fitnessTimeController,
        vocabularyTimeController,
        readingTimeController,
        visualizationTimeController,
        needReinit);
  }

  void _init() {
    initTimerValue();
    initTextEditingControllers();
    addListenersToEditText();
  }

  initPurchaseListiner() {
    Purchases.addPurchaserInfoUpdateListener((_purchaserInfo) {
      print('Purchaser Info Listener');
      if (billingService.purchaserInfo != _purchaserInfo)
        setState(() {
          billingService.purchaserInfo = _purchaserInfo;
          print('Purchase state updatet');
          tableList = wrapTable(true);
        });
    });
  }

  void initTimerValue() {
    if (MyDB().getBox().get(MyResource.AFFIRMATION_TIME_KEY) == null) {
      MyDB().getBox().put(MyResource.AFFIRMATION_TIME_KEY, ExerciseTime(3));
    }
    if (MyDB().getBox().get(MyResource.MEDITATION_TIME_KEY) == null) {
      MyDB().getBox().put(MyResource.MEDITATION_TIME_KEY, ExerciseTime(3));
    }
    if (MyDB().getBox().get(MyResource.FITNESS_TIME_KEY) == null) {
      MyDB().getBox().put(MyResource.FITNESS_TIME_KEY, ExerciseTime(3));
    }
    if (MyDB().getBox().get(MyResource.VOCABULARY_TIME_KEY) == null) {
      MyDB().getBox().put(MyResource.VOCABULARY_TIME_KEY, ExerciseTime(3));
    }
    if (MyDB().getBox().get(MyResource.READING_TIME_KEY) == null) {
      MyDB().getBox().put(MyResource.READING_TIME_KEY, ExerciseTime(3));
    }
    if (MyDB().getBox().get(MyResource.VISUALIZATION_TIME_KEY) == null) {
      MyDB().getBox().put(MyResource.VISUALIZATION_TIME_KEY, ExerciseTime(3));
    }
  }

  void _initOpenDialog() async {
    await Future.delayed(Duration(seconds: 3));
    if (context != null) {
      _openDialog();
    }
  }

  void _openDialog() async {
    if (!billingService.isPro()) {
      showDialog(
          context: context, builder: (BuildContext context) => PaymentDialog());
    }
  }

  void initTextEditingControllers() {
    affirmationTimeController = TextEditingController(
        text: getInitialValueForTimeField(MyResource.AFFIRMATION_TIME_KEY));
    meditationTimeController = TextEditingController(
        text: getInitialValueForTimeField(MyResource.MEDITATION_TIME_KEY));
    fitnessTimeController = TextEditingController(
        text: getInitialValueForTimeField(MyResource.FITNESS_TIME_KEY));
    vocabularyTimeController = TextEditingController(
        text: getInitialValueForTimeField(MyResource.VOCABULARY_TIME_KEY));
    readingTimeController = TextEditingController(
        text: getInitialValueForTimeField(MyResource.READING_TIME_KEY));
    visualizationTimeController = TextEditingController(
        text: getInitialValueForTimeField(MyResource.VISUALIZATION_TIME_KEY));
    affirmationTextController =
        TextEditingController(text: getInitialValueForAffirmationTextField());
    bookController = TextEditingController(text: getInitialValueForBookField());
    nameController = TextEditingController(text: getInitialValueForNameField());
  }

  getInitialValueForTimeField(String key) {
    String result = "3";
    ExerciseTime time = MyDB().getBox().get(key);
    if (time != null) result = time.time.toString();
    return result;
  }

  void clearTextFunction(TextEditingController controller, String key) {
    if (controller.text.contains(".") ||
        controller.text.contains("-") ||
        controller.text.contains(",") ||
        controller.text.contains(" ") ||
        controller.text.length > 2 ||
        (int.tryParse(controller.text) != null &&
            int.tryParse(controller.text) < 1)) {
      print("CLEAR !!!!!!!!!!");
      controller.clear();
      controller.text = "1";
      MyDB().getBox().put(key, ExerciseTime(1));
    }
  }

  void addListenersToEditText() {
    affirmationTimeController.addListener(() {
      clearTextFunction(
          affirmationTimeController, MyResource.AFFIRMATION_TIME_KEY);
      if (affirmationTimeController.text != null &&
          affirmationTimeController.text.isNotEmpty) {
        int input = int.tryParse(affirmationTimeController.text);
        if (input != null) {
          MyDB()
              .getBox()
              .put(MyResource.AFFIRMATION_TIME_KEY, ExerciseTime(input));
        }
      } else {
        MyDB().getBox().put(MyResource.AFFIRMATION_TIME_KEY, ExerciseTime(0));
      }
      setState(() {});
    });
    meditationTimeController.addListener(() {
      clearTextFunction(
          meditationTimeController, MyResource.MEDITATION_TIME_KEY);
      if (meditationTimeController.text != null &&
          meditationTimeController.text.isNotEmpty) {
        int input = int.tryParse(meditationTimeController.text);
        if (input != null) {
          MyDB()
              .getBox()
              .put(MyResource.MEDITATION_TIME_KEY, ExerciseTime(input));
        }
      } else {
        MyDB().getBox().put(MyResource.MEDITATION_TIME_KEY, ExerciseTime(0));
      }
      setState(() {});
    });
    fitnessTimeController.addListener(() {
      clearTextFunction(fitnessTimeController, MyResource.FITNESS_TIME_KEY);
      if (fitnessTimeController.text != null &&
          fitnessTimeController.text.isNotEmpty) {
        int input = int.tryParse(fitnessTimeController.text);
        if (input != null) {
          MyDB().getBox().put(MyResource.FITNESS_TIME_KEY, ExerciseTime(input));
        }
      } else {
        MyDB().getBox().put(MyResource.FITNESS_TIME_KEY, ExerciseTime(0));
      }
      setState(() {});
    });
    vocabularyTimeController.addListener(() {
      clearTextFunction(
          vocabularyTimeController, MyResource.VOCABULARY_TIME_KEY);
      if (vocabularyTimeController.text != null &&
          vocabularyTimeController.text.isNotEmpty) {
        int input = int.tryParse(vocabularyTimeController.text);
        if (input != null) {
          MyDB()
              .getBox()
              .put(MyResource.VOCABULARY_TIME_KEY, ExerciseTime(input));
        }
      } else {
        MyDB().getBox().put(MyResource.VOCABULARY_TIME_KEY, ExerciseTime(0));
      }
      setState(() {});
    });
    readingTimeController.addListener(() {
      clearTextFunction(readingTimeController, MyResource.READING_TIME_KEY);
      if (readingTimeController.text != null &&
          readingTimeController.text.isNotEmpty) {
        int input = int.tryParse(readingTimeController.text);
        if (input != null) {
          MyDB().getBox().put(MyResource.READING_TIME_KEY, ExerciseTime(input));
        }
      } else {
        MyDB().getBox().put(MyResource.READING_TIME_KEY, ExerciseTime(0));
      }
      setState(() {});
    });
    visualizationTimeController.addListener(() {
      clearTextFunction(
          visualizationTimeController, MyResource.VISUALIZATION_TIME_KEY);
      if (visualizationTimeController.text != null &&
          visualizationTimeController.text.isNotEmpty) {
        int input = int.tryParse(visualizationTimeController.text);
        if (input != null) {
          MyDB()
              .getBox()
              .put(MyResource.VISUALIZATION_TIME_KEY, ExerciseTime(input));
        }
      } else {
        MyDB().getBox().put(MyResource.VISUALIZATION_TIME_KEY, ExerciseTime(0));
      }
      setState(() {});
    });
    affirmationTextController.addListener(() {
      if (affirmationTextController.text != null &&
          affirmationTextController.text.isNotEmpty) {
        MyDB().getBox().put(MyResource.AFFIRMATION_TEXT_KEY,
            AffirmationText(affirmationTextController.text));
      }
      setState(() {});
    });

    bookController.addListener(() {
      if (bookController.text != null && bookController.text.isNotEmpty) {
        MyDB().getBox().put(MyResource.BOOK_KEY, Book(bookController.text));
      }
      setState(() {});
    });
    nameController.addListener(() {
      if (nameController.text != null && nameController.text.isNotEmpty) {
        MyDB().getBox().put(MyResource.USER_KEY, User(nameController.text));
      }
      setState(() {});
    });
  }

  String getAndCalculateTime() {
    ExerciseTime affirmation = MyDB()
        .getBox()
        .get(MyResource.AFFIRMATION_TIME_KEY, defaultValue: ExerciseTime(3));
    int affirmation_time = affirmation.time;

    ExerciseTime meditation = MyDB()
        .getBox()
        .get(MyResource.MEDITATION_TIME_KEY, defaultValue: ExerciseTime(3));
    int meditation_time = meditation.time;

    ExerciseTime fitness = MyDB()
        .getBox()
        .get(MyResource.FITNESS_TIME_KEY, defaultValue: ExerciseTime(3));
    int fitness_time = fitness.time;

    ExerciseTime vocabulary = MyDB()
        .getBox()
        .get(MyResource.VOCABULARY_TIME_KEY, defaultValue: ExerciseTime(3));
    int vocabulary_time = vocabulary.time;

    ExerciseTime reading = MyDB()
        .getBox()
        .get(MyResource.READING_TIME_KEY, defaultValue: ExerciseTime(3));
    int reading_time = reading.time;

    ExerciseTime visualization = MyDB()
        .getBox()
        .get(MyResource.VISUALIZATION_TIME_KEY, defaultValue: ExerciseTime(3));
    int visualization_time = visualization.time;

    int sum = affirmation_time +
        meditation_time +
        fitness_time +
        vocabulary_time +
        reading_time +
        visualization_time;

    return 'x_minutes'.tr(namedArgs: {'x': sum.toString()});
  }

  String getInitialValueForAffirmationTextField() {
    String result = "";
    AffirmationText time = MyDB().getBox().get(MyResource.AFFIRMATION_TEXT_KEY);
    if (time != null) {
      result = time.affirmationText;
    }
    return result;
  }

  String getInitialValueForBookField() {
    String result = "";
    Book time = MyDB().getBox().get(MyResource.BOOK_KEY);
    if (time != null) {
      result = time.bookName;
    }
    return result;
  }

  String getInitialValueForNameField() {
    String result = "";
    User user = MyDB().getBox().get(MyResource.USER_KEY);
    if (user != null) {
      result = user.name;
    }
    return result;
  }

  Future<bool> _onWillPop() async {
    Navigator.pushNamedAndRemoveUntil(context, '/start', (r) => false);
    return false;
  }
}

//ftden45 start
class _showSimpleDialogOne extends StatefulWidget {
  Widget widget;
  num nomerCat;
  bool mainPopUpMenu;
  num _numDialog;
  num _numSubCategor;
  _showSimpleDialogOne(
      [this.widget,
      this.nomerCat,
      this.mainPopUpMenu,
      this._numDialog,
      this._numSubCategor]);
  @override
  __showSimpleDialogOneState createState() => __showSimpleDialogOneState();
}

class __showSimpleDialogOneState extends State<_showSimpleDialogOne> {
  @override
  Widget build(BuildContext context) {
    return DialogRadioBtn(widget.widget, widget.nomerCat, widget.nomerCat,
        widget.mainPopUpMenu, widget._numDialog, widget._numSubCategor);
  }
}

void _showSimpleDialog(context, widget, nomerCat,
    [mainPopUpMenu = true, _numDialog, _numSubCategor = 0]) {
  print('_numSubCategor ${_numSubCategor}');
  showDialog(
      context: context,
      builder: (context) {
        return _showSimpleDialogOne(
            widget, nomerCat, mainPopUpMenu, _numDialog, _numSubCategor);
      });
}

class DialogRadioBtn extends StatefulWidget {
  Widget btn;
  int _affermationChoose;
  int nomerCat;
  bool MainWidgets;
  num _numDialog;
  num _numSubCategor;

  bool Yverennost = true;
  bool NaZdorovie = false;
  bool NaLubovGen = false;
  bool NaUspeh = false;
  bool NaKariery = false;
  bool NaBogatsvo = false;
  DialogRadioBtn(this.btn,
      [this._affermationChoose = 0,
      this.nomerCat = 0,
      this.MainWidgets = true,
      this._numDialog,
      this._numSubCategor = 0]);

  @override
  _DialogRadioBtnState createState() => _DialogRadioBtnState();
}

class _DialogRadioBtnState extends State<DialogRadioBtn> {
  //num nomerCat = widget.nomerCat;
  @override
  void initState() {
    super.initState();
  }

  Widget _OneDialogCat(nomerCat) {
    return Column(
      children: [
        _categAffer(
          "На уверенность",
          () {
            //print('xxxxxxxxxxxxxxxxxxxxxxxxxxxx');
            setState(() {
              nomerCat = 0;
              // Yverennost = true;
              // NaZdorovie = false;
              // NaLubovGen = false;
              // NaUspeh = false;
              // NaKariery = false;
              // NaBogatsvo = false;
            });
            Navigator.of(context).pop();
            _showSimpleDialog(context, Column(), 0, true, 0);
          },
          16.0,
          nomerCat == 0 ? true : false,
        ),
        _categAffer(
          "На здоровье",
          () {
            //print('zzzz');
            setState(() {
              nomerCat = 1;
              // Yverennost = false;
              // NaZdorovie = true;
              // NaLubovGen = false;
              // NaUspeh = false;
              // NaKariery = false;
              // NaBogatsvo = false;
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 1, true, 0);
            });
          },
          16.0,
          nomerCat == 1 ? true : false,
        ),
        _categAffer(
          "На любовь (ж)",
          () {
            setState(() {
              nomerCat = 2;
              // Yverennost = false;
              // NaZdorovie = false;
              // NaLubovGen = true;
              // NaUspeh = false;
              // NaKariery = false;
              // NaBogatsvo = false;
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 2, true, 0);
            });
          },
          16.0,
          nomerCat == 2 ? true : false,
        ),
        _categAffer(
          "На успех",
          () {
            setState(() {
              nomerCat = 3;
              // Yverennost = false;
              // NaZdorovie = false;
              // NaLubovGen = false;
              // NaUspeh = true;
              // NaKariery = false;
              // NaBogatsvo = false;
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 3, true, 0);
            });
          },
          16.0,
          nomerCat == 3 ? true : false,
        ),
        _categAffer(
          "На карьеру",
          () {
            setState(() {
              nomerCat = 4;
              // Yverennost = false;
              // NaZdorovie = false;
              // NaLubovGen = false;
              // NaUspeh = false;
              // NaKariery = true;
              // NaBogatsvo = false;
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 4, true, 0);
            });
          },
          16.0,
          nomerCat == 4 ? true : false,
        ),
        _categAffer(
          "На богатство",
          () {
            setState(() {
              nomerCat = 5;
              print('5555');
              // Yverennost = false;
              // NaZdorovie = false;
              // NaLubovGen = false;
              // NaUspeh = false;
              // NaKariery = false;
              // NaBogatsvo = true;
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 5, true, 0);
            });
          },
          16.0,
          nomerCat == 5 ? true : false,
        ),
      ],
    );
  }

  //============================================start========
  Widget _numGroupWidget(context, _numGroupWidget, nomerCat) {
    print('_numSubCategor2 ${_numGroupWidget}');
    print('nomerCat2 ${nomerCat}');
    switch (_numGroupWidget) {
      case 0:
        return Column(
          children: [
            _categAffer(
              "Мне нравиться расширять зону комфорта и идти к новому.",
              () {
                setState(() {
                  nomerCat = 0;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 0, false, 0, nomerCat);
              },
              13.0,
              nomerCat == 0 ? true : false,
            ),
            _categAffer(
              "Я ценю свои способности.",
              () {
                setState(() {
                  nomerCat = 1;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 0, false, 0, nomerCat);
              },
              13.0,
              nomerCat == 1 ? true : false,
            ),
            _categAffer(
              "Я ощущаю спокойную уверенность в любой ситуации.",
              () {
                setState(() {
                  nomerCat = 2;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 0, false, 0, nomerCat);
              },
              13.0,
              nomerCat == 2 ? true : false,
            ),
            _categAffer(
              "Я ценю свои способности.",
              () {
                setState(() {
                  nomerCat = 3;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 0, false, 0, nomerCat);
              },
              13.0,
              nomerCat == 3 ? true : false,
            ),
            _categAffer(
              "Я имею право жить своей жизнью и исполнять свое предназначение.",
              () {
                setState(() {
                  nomerCat = 4;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 0, false, 0, nomerCat);
              },
              13.0,
              nomerCat == 4 ? true : false,
            ),
            _categAffer(
              "Я позволяю себе идти своим путем, исполняя свои мечты.",
              () {
                setState(() {
                  nomerCat = 5;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 0, false, 0, nomerCat);
              },
              13.0,
              nomerCat == 5 ? true : false,
            ),
            _categAffer(
              "Я люблю в себе всё. Я люблю каждую частицу своего тела и свою душу.",
              () {
                setState(() {
                  nomerCat = 6;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 0, false, 0, nomerCat);
              },
              13.0,
              nomerCat == 6 ? true : false,
            ),
          ],
        );

      case 1:
        return Column(
          children: [
            _categAffer(
              'Мое тело делает все возможное для сохранения отменного здоровья!',
              () {
                setState(() {
                  nomerCat = 0;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 1, false, 0, nomerCat);
              },
              13.0,
              nomerCat == 0 ? true : false,
            ),
            _categAffer(
              "Я доверяю своей интуиции. Я всегда прислушиваюсь к внутреннему голосу!",
              () {
                setState(() {
                  nomerCat = 1;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 1, false, 0, nomerCat);
              },
              13.0,
              nomerCat == 1 ? true : false,
            ),
            _categAffer(
              "Я сплю здоровым, крепким сном. Мое тело ценит мою заботу о нем!",
              () {
                setState(() {
                  nomerCat = 2;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 1, false, 0, nomerCat);
              },
              13.0,
              nomerCat == 2 ? true : false,
            ),
            _categAffer(
              "Только я могу контролировать свои пристрастия в еде. Я всегда могу отказаться от чего-либо!",
              () {
                setState(() {
                  nomerCat = 3;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 1, false, 0, nomerCat);
              },
              10.0,
              nomerCat == 3 ? true : false,
            ),
            _categAffer(
              "Я нахожусь в гармонии с частью своего «Я», которое знает секреты исцеления!",
              () {
                setState(() {
                  nomerCat = 4;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 1, false, 0, nomerCat);
              },
              10.0,
              nomerCat == 4 ? true : false,
            ),
            _categAffer(
              "С каждым днем я становлюсь здоровее и крепче",
              () {
                setState(() {
                  nomerCat = 5;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 1, false, 0, nomerCat);
              },
              13.0,
              nomerCat == 5 ? true : false,
            ),
            _categAffer(
              "У меня много жизненной силы и энергии",
              () {
                setState(() {
                  nomerCat = 6;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 1, false, 0, nomerCat);
              },
              13.0,
              nomerCat == 6 ? true : false,
            ),
            _categAffer(
              "У меня всегда хорошее самочувствие. Так как моему телу хорошо, то в душе появляются только позитивные и добрые чувства.",
              () {
                setState(() {
                  nomerCat = 7;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 1, false, 0, nomerCat);
              },
              12.0,
              nomerCat == 7 ? true : false,
            ),
            _categAffer(
              "У меня прекрасное здоровье",
              () {
                setState(() {
                  nomerCat = 8;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 1, false, 0, nomerCat);
              },
              13.0,
              nomerCat == 8 ? true : false,
            ),
            _categAffer(
              "Я позволяю телу исцелиться",
              () {
                setState(() {
                  nomerCat = 9;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 1, false, 0, nomerCat);
              },
              13.0,
              nomerCat == 9 ? true : false,
            ),
            _categAffer(
              "У меня крепкое здоровье ",
              () {
                setState(() {
                  nomerCat = 10;
                });
                Navigator.of(context).pop();
                _showSimpleDialog(context, Column(), 1, false, 0, nomerCat);
              },
              13.0,
              nomerCat == 10 ? true : false,
            ),
          ],
        );
      case 2:
        return Column(
          children: [
            _categAffer("Я открываю свое сердце для любви.", () {
              setState(() {
                nomerCat = 0;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 2, false, 0, nomerCat);
            }, 13.0, nomerCat == 0 ? true : false),
            _categAffer("Я чувствую, что любима.", () {
              setState(() {
                nomerCat = 1;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 2, false, 0, nomerCat);
            }, 13.0, nomerCat == 1 ? true : false),
            _categAffer("Я позволяю себе любить. Это безопасно.", () {
              setState(() {
                nomerCat = 2;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 2, false, 0, nomerCat);
            }, 13.0, nomerCat == 2 ? true : false),
            _categAffer(
                "Я наслаждаюсь своей магической женской притягательностью.",
                () {
              setState(() {
                nomerCat = 3;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 2, false, 0, nomerCat);
            }, 13.0, nomerCat == 3 ? true : false),
            _categAffer(
                "Я нахожусь в гармонии с частью своего «Я», которое знает секреты исцеления!",
                () {
              setState(() {
                nomerCat = 4;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 2, false, 0, nomerCat);
            }, 13.0, nomerCat == 4 ? true : false),
            _categAffer("Я открываю и принимаю свою внутреннюю женщину.", () {
              setState(() {
                nomerCat = 5;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 2, false, 0, nomerCat);
            }, 13.0, nomerCat == 5 ? true : false),
            _categAffer(
                "Я абсолютно уверена в своей женской привлекательности.", () {
              setState(() {
                nomerCat = 6;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 2, false, 0, nomerCat);
            }, 13.0, nomerCat == 6 ? true : false),
            _categAffer(
                "Я открыта для любви и гармоничных отношений с любимым и любящим меня человеком.",
                () {
              setState(() {
                nomerCat = 7;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 2, false, 0, nomerCat);
            }, 13.0, nomerCat == 7 ? true : false),
            _categAffer(
                "Я выбираю для себя радость и счастье! Я этого достойна.", () {
              setState(() {
                nomerCat = 8;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 2, false, 0, nomerCat);
            }, 13.0, nomerCat == 8 ? true : false),
            _categAffer(
                "Взаимная любовь приходит ко мне. И я наслаждаюсь прекрасными гармоничными отношениями.",
                () {
              setState(() {
                nomerCat = 9;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 2, false, 0, nomerCat);
            }, 13.0, nomerCat == 9 ? true : false),
            _categAffer(
                "Я готова к серьезным, гармоничным отношениям. Где я люблю и я любима! Благодарю",
                () {
              setState(() {
                nomerCat = 10;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 2, false, 0, nomerCat);
            }, 13.0, nomerCat == 10 ? true : false),
          ],
        );

      case 3:
        return Column(
          children: [
            _categAffer("Мой ум открыт для новых возможностей.", () {
              setState(() {
                nomerCat = 0;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 3, false, 0, nomerCat);
            }, 13.0, nomerCat == 0 ? true : false),
            _categAffer(
                "Я благодарен за свои навыки и умения, которые помогают мне достичь желаемого.",
                () {
              setState(() {
                nomerCat = 1;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 3, false, 0, nomerCat);
            }, 13.0, nomerCat == 1 ? true : false),
            _categAffer(
                "Я хорошо организован и эффективно управляю своим временем.",
                () {
              setState(() {
                nomerCat = 2;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 3, false, 0, nomerCat);
            }, 13.0, nomerCat == 2 ? true : false),
            _categAffer(
                "Я устанавливаю высокие стандарты для себя и всегда оправдываю свои ожидания.",
                () {
              setState(() {
                nomerCat = 3;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 3, false, 0, nomerCat);
            }, 13.0, nomerCat == 3 ? true : false),
            _categAffer(
                "Я доверяю своей интуиции и всегда принимаю мудрые решения.",
                () {
              setState(() {
                nomerCat = 4;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 3, false, 0, nomerCat);
            }, 13.0, nomerCat == 4 ? true : false),
            _categAffer(
                "Я последовательно привлекаю только нужные обстоятельства в нужное время.",
                () {
              setState(() {
                nomerCat = 5;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 3, false, 0, nomerCat);
            }, 13.0, nomerCat == 5 ? true : false),
            _categAffer(
                "Каждый день наполняюсь новыми идеями, которые вдохновляют и мотивируют меня.",
                () {
              setState(() {
                nomerCat = 6;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 3, false, 0, nomerCat);
            }, 13.0, nomerCat == 6 ? true : false),
            _categAffer(
                "У меня достаточно сил, чтобы процветать и иметь успех во всем, что желаю.",
                () {
              setState(() {
                nomerCat = 7;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 3, false, 0, nomerCat);
            }, 13.0, nomerCat == 7 ? true : false),
            _categAffer("Я с удовольствием принимаю сильные и смелые решения.",
                () {
              setState(() {
                nomerCat = 8;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 3, false, 0, nomerCat);
            }, 13.0, nomerCat == 8 ? true : false),
            _categAffer("Жизнь всегда готова помочь мне, дав все обходимое.",
                () {
              setState(() {
                nomerCat = 9;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 3, false, 0, nomerCat);
            }, 13.0, nomerCat == 9 ? true : false),
            _categAffer("Я смело и уверенно пользуюсь всеми благами жизни.",
                () {
              setState(() {
                nomerCat = 10;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 3, false, 0, nomerCat);
            }, 13.0, nomerCat == 10 ? true : false),
          ],
        );

      case 4:
        return Column(
          children: [
            _categAffer("Я мотивирован, последователен и целеустремлен.", () {
              setState(() {
                nomerCat = 0;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 4, false, 0, nomerCat);
            }, 13.0, nomerCat == 0 ? true : false),
            _categAffer("Я всегда достигаю своих рабочих целей.", () {
              setState(() {
                nomerCat = 1;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 4, false, 0, nomerCat);
            }, 13.0, nomerCat == 1 ? true : false),
            _categAffer("Успех на работе это легко.", () {
              setState(() {
                nomerCat = 2;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 4, false, 0, nomerCat);
            }, 13.0, nomerCat == 2 ? true : false),
            _categAffer("Со мной хорошо обращаются и уважают на работе.", () {
              setState(() {
                nomerCat = 3;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 4, false, 0, nomerCat);
            }, 13.0, nomerCat == 3 ? true : false),
            _categAffer("Идеальная компания наймет меня.", () {
              setState(() {
                nomerCat = 4;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 4, false, 0, nomerCat);
            }, 13.0, nomerCat == 4 ? true : false),
            _categAffer(
                "Я заслуживаю иметь захватывающую и приятную карьеру, о которой я мечтаю.",
                () {
              setState(() {
                nomerCat = 5;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 4, false, 0, nomerCat);
            }, 13.0, nomerCat == 5 ? true : false),
            _categAffer(
                "Я заслуживаю того, чтобы иметь жизнь, которую я хочу, и в том числе карьеру, которую я выберу",
                () {
              setState(() {
                nomerCat = 6;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 4, false, 0, nomerCat);
            }, 13.0, nomerCat == 6 ? true : false),
            _categAffer(
                "Я знаю, что когда я вкладываю все свои силы в свою работу, я получаю огромное вознаграждение",
                () {
              setState(() {
                nomerCat = 7;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 4, false, 0, nomerCat);
            }, 13.0, nomerCat == 7 ? true : false),
            _categAffer(
                "У меня есть работа, которая позволяет мне полностью выразить свою индивидуальность и уникальные таланты.",
                () {
              setState(() {
                nomerCat = 8;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 4, false, 0, nomerCat);
            }, 13.0, nomerCat == 8 ? true : false),
            _categAffer("Я мoгy дocтичь вceгo, чтo зaдyмaю.", () {
              setState(() {
                nomerCat = 9;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 4, false, 0, nomerCat);
            }, 13.0, nomerCat == 9 ? true : false),
            _categAffer(
                "Я зapaбaтывaю xopoшиe дeньги, дeлaя тo, чтo мнe нpaвитcя.",
                () {
              setState(() {
                nomerCat = 10;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 4, false, 0, nomerCat);
            }, 13.0, nomerCat == 10 ? true : false),
          ],
        );
      case 5:
        return Column(
          children: [
            _categAffer(
                "Деньги любят меня и приходят в нужном количестве и даже более.",
                () {
              setState(() {
                nomerCat = 0;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 5, false, 0, nomerCat);
            }, 13.0, nomerCat == 0 ? true : false),
            _categAffer("Деньги - мои друзья.", () {
              setState(() {
                nomerCat = 1;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 5, false, 0, nomerCat);
            }, 13.0, nomerCat == 1 ? true : false),
            _categAffer(
                "Я везде вижу возможность заработать деньги! Я легко реализую лучшие из возможностей!",
                () {
              setState(() {
                nomerCat = 2;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 5, false, 0, nomerCat);
            }, 13.0, nomerCat == 2 ? true : false),
            _categAffer("Я легко трачу деньги, и легко получаю деньги.", () {
              setState(() {
                nomerCat = 3;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 5, false, 0, nomerCat);
            }, 13.0, nomerCat == 3 ? true : false),
            _categAffer(
                "Я – магнит для денег! Деньги приходят ко мне разными путями!",
                () {
              setState(() {
                nomerCat = 4;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 5, false, 0, nomerCat);
            }, 13.0, nomerCat == 4 ? true : false),
            _categAffer("Я отдаю и получаю деньги с радостью и благодарностью.",
                () {
              setState(() {
                nomerCat = 5;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 5, false, 0, nomerCat);
            }, 13.0, nomerCat == 5 ? true : false),
            _categAffer("Я с благодарностью принимаю щедрые дары Вселенной.",
                () {
              setState(() {
                nomerCat = 6;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 5, false, 0, nomerCat);
            }, 13.0, nomerCat == 6 ? true : false),
            _categAffer(
                "Вселенская энергия щедро обеспечивает меня благами жизни.",
                () {
              setState(() {
                nomerCat = 7;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 5, false, 0, nomerCat);
            }, 13.0, nomerCat == 7 ? true : false),
            _categAffer(
                "Сделанное мной добро возвращается ко мне в умноженном виде.",
                () {
              setState(() {
                nomerCat = 8;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 5, false, 0, nomerCat);
            }, 13.0, nomerCat == 8 ? true : false),
            _categAffer(
                "Я всегда притягиваю в свою жизнь огромное количество ресурсов и идей.",
                () {
              setState(() {
                nomerCat = 9;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 5, false, 0, nomerCat);
            }, 13.0, nomerCat == 9 ? true : false),
            _categAffer("Деньги - мои друзья.", () {
              setState(() {
                nomerCat = 10;
              });
              Navigator.of(context).pop();
              _showSimpleDialog(context, Column(), 5, false, 0, nomerCat);
            }, 13.0, nomerCat == 10 ? true : false),
          ],
        );
    }
  }
  //=============================================end=====

  @override
  Widget build(BuildContext context) {
    num _numSubCategor;
    num _numDialog = widget._numDialog;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          //Navigator.pop(context);
                          Navigator.pop(context);
                          // _showSimpleDialog(context, Container(),
                          //     widget.nomerCat, false, 0, widget._numSubCategor);
                          // print(' = ${_numDialog}');
                          // setState(() {});
                          // if (widget._numDialog == 1) {
                          //   Navigator.pop(context);
                          //   _showSimpleDialog(
                          //       context, Container(), widget.nomerCat, true, 0);
                          // }
                          // if (widget._numDialog == 0) {
                          //   Navigator.pop(context);
                          // }
                        },
                        child: Text(
                          'назад',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 23,
                              fontFamily: 'rex',
                              fontStyle: FontStyle.normal,
                              color: AppColors.VIOLET),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          //_showSimpleDialog(context,_widgets);

                          print('dialog');
                          print('_numSubCategor ${_numSubCategor}');
                          //print('nomerCat ${_nomerCat}');
                          if (_numDialog == 0) {
                            Navigator.pop(context);
                            _showSimpleDialog(context, Container(),
                                widget.nomerCat, false, 0, _numSubCategor);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingsPage(
                                        widget.nomerCat,
                                        _numSubCategor))); //SettingsPage
                          }

                          //_numGroupWidget(context, 0);
                        },
                        child: Text(
                          'готово',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 23,
                              fontFamily: 'rex',
                              fontStyle: FontStyle.normal,
                              color: AppColors.VIOLET),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //widget.btn,
              widget.MainWidgets
                  ? _OneDialogCat(widget.nomerCat)
                  : _numGroupWidget(
                      context, widget.nomerCat, widget._numSubCategor),
              Container(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    // child: AnimatedButton(, "rex",
                    //     'back_button'.tr(), 18, null, null),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _categAffer extends StatefulWidget {
  String text;
  Function ontap;
  double fontsize;
  bool hover;
  _categAffer(this.text, this.ontap, this.fontsize, [this.hover = false]);
  @override
  __categAfferState createState() => __categAfferState();
}

class __categAfferState extends State<_categAffer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.0,
        height: 35.0,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            color: widget.hover ? AppColors.PINK : AppColors.LIGHT_VIOLET,
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: Container(
          padding: EdgeInsets.only(top: 2),
          child: Center(
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: AppColors.WHITE,
                fontStyle: FontStyle.normal,
                fontFamily: 'rex',
                fontSize: widget.fontsize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum _CategoriAffermationsEnum {
  Yverennost,
  NaZdorovie,
  NaLubovGen,
  NaUspeh,
  NaKariery,
  NaBogatsvo,
}

_chooseCat(catenum) {
  switch (catenum) {
    case _CategoriAffermationsEnum.Yverennost:
      print("_CategoriAffermationsEnum 0");
      return 0;
    case _CategoriAffermationsEnum.NaZdorovie:
      print("_CategoriAffermationsEnum 1");
      return 1;
    case _CategoriAffermationsEnum.NaLubovGen:
      print("_CategoriAffermationsEnum 2");
      return 2;
    case _CategoriAffermationsEnum.NaUspeh:
      print("_CategoriAffermationsEnum 3");
      return 3;
    case _CategoriAffermationsEnum.NaKariery:
      print("_CategoriAffermationsEnum 4");
      return 4;
    case _CategoriAffermationsEnum.NaBogatsvo:
      print("_CategoriAffermationsEnum 5");
      return 5;
  }
}
