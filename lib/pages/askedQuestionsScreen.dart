import 'dart:developer';
import 'dart:io';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:morningmagic/analyticService.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/user/user.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/pages/myFitnessProgress.dart';
import 'package:morningmagic/pages/myVisualizationProgress.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/other.dart';
import 'package:morningmagic/widgets/remove_progress.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../app_states.dart';
import '../db/model/progress/affirmation_progress/affirmation_progress.dart';
import '../db/model/progress/day/day.dart';
import '../db/model/progress/fitness_porgress/fitness_progress.dart';
import '../db/model/progress/meditation_progress/meditation_progress.dart';
import '../db/model/progress/reading_progress/reading_progress.dart';
import '../db/model/progress/visualization_progress/visualization_progress.dart';
import '../db/model/progress/vocabulary_progress/vocabulary_note_progress.dart';
import '../db/model/progress/vocabulary_progress/vocabulary_record_progress.dart';
import '../storage.dart';
import '../widgets/animatedButton.dart';
import '../widgets/progressItem.dart';
import '../widgets/progressItemRecord.dart';
import 'Reclama.dart';
import 'journalMy.dart';
import 'myAffirmationProgress.dart';
import 'myReadingProgress.dart';

class AskedQuestionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AskedQuestionsState();
  }
}

class _AskedQuestionsState extends State<AskedQuestionsScreen> {
  AppStates appStates = Get.put(AppStates());
  int appRating = 5;

  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  bool _Itog = true;
  bool _Mounth = false;
  bool _Year = false;
  String userName;

  TextEditingController nameController;

  @override
  void initState() {
    super.initState();

    AnalyticService.screenView('dashboard');
    userName = _getUserName();
    nameController = TextEditingController(text: userName);
    print('Open _AskedQuestionsState');
  }

  @override
  Widget build(BuildContext context) {
    log('Build askedQuestionScreen');
    rateApp(context);
    return Scaffold(
      body: AppGradientContainer(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  nameController.text = userName;
                  final _newName = await _editUserNameDialog();
                  if (_newName != null) {
                    setState(() {
                      userName = _newName;
                    });
                    MyDB().getBox().put(MyResource.USER_KEY, User(userName));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 25.0, right: 25.0, top: 16, bottom: 16),
                  child: Text(
                    userName,
                    style: TextStyle(fontSize: 23, color: AppColors.VIOLET),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                  right: 20,
                  bottom: 0,
                ),
                padding: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.only(
                            top: 15,
                            left: 15,
                          ),
                          child: Text(
                            'awareness_meter'.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.064,
                              color: Color(0xffaAaAaA),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 50,
                          padding: EdgeInsets.only(
                            top: 15,
                          ),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: 'for_week'.tr(),
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.064,
                                  color: Color(0xffaAaAaA),
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'minutes_per_week'.tr(),
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.055,
                                      color: Color(0xffaAaAaA),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AnimatedCircularChart(
                              //holeRadius: HoleRa,
                              key: _chartKey,
                              size: Size(MediaQuery.of(context).size.width / 2,
                                  MediaQuery.of(context).size.width / 2),
                              initialChartData: <CircularStackEntry>[
                                new CircularStackEntry(
                                  <CircularSegmentEntry>[
                                    new CircularSegmentEntry(
                                      MyDB().getBox().get(
                                                MyResource.PERCENT_OF_AWARENESS,
                                              ) ??
                                          0,
                                      Color(0xff00b2ff),
                                      rankKey: 'completed',
                                    ),
                                    new CircularSegmentEntry(
                                      MyDB().getBox().get(
                                                    MyResource
                                                        .PERCENT_OF_AWARENESS,
                                                  ) !=
                                              null
                                          ? 100 -
                                              MyDB().getBox().get(MyResource
                                                  .PERCENT_OF_AWARENESS)
                                          : 100,
                                      Color(0xffb3e8ff),
                                      rankKey: 'remaining',
                                    ),
                                  ],
                                  rankKey: 'progress',
                                ),
                              ],
                              chartType: CircularChartType.Radial,
                              percentageValues: true,
                              holeLabel:
                                  '${MyDB().getBox().get(MyResource.PERCENT_OF_AWARENESS) ?? 0} %',
                              edgeStyle: SegmentEdgeStyle.round,
                              labelStyle: new TextStyle(
                                color: Colors.blueGrey[600],
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.064,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 40,
                                height: MediaQuery.of(context).size.height *
                                    0.25, //150,
                                child: VerticalBarLabelChart.withSampleData(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: MediaQuery.of(context).size.height < 668
                    ? MediaQuery.of(context).size.height * 0.255
                    : MediaQuery.of(context).size.height * 0.215,
                margin: const EdgeInsets.only(
                  left: 20.0,
                  right: 20,
                  top: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: context.locale == Locale('ru') ? 40 : 40,
                        right: context.locale == Locale('ru') ? 48 : 42,
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xffEBC2BE),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          )),
                      height: MediaQuery.of(context).size.height < 668
                          ? MediaQuery.of(context).size.height * 0.08
                          : MediaQuery.of(context).size.height * 0.06,
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _Itog = true;
                                _Mounth = false;
                                _Year = false;
                              });
                            },
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'total'.tr(),
                                    style: TextStyle(
                                      color:
                                          _Itog ? Colors.white : Colors.black54,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04, //23,
                                    ),
                                  ),
                                  //bool _Itog = true;
                                  // bool _Mounth = false;
                                  // bool _Year = false;
                                  _Itog
                                      ? Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.arrow_drop_up,
                                          color: Colors.black54,
                                        ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _Itog = false;
                                _Mounth = true;
                                _Year = false;
                              });
                            },
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'month'.tr(),
                                    style: TextStyle(
                                      color: _Mounth
                                          ? Colors.white
                                          : Colors.black54,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04, //23,
                                    ),
                                  ),
                                  _Mounth
                                      ? Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.arrow_drop_up,
                                          color: Colors.black54,
                                        ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _Itog = false;
                                _Mounth = false;
                                _Year = true;
                              });
                            },
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'year'.tr(),
                                    style: TextStyle(
                                      color:
                                          _Year ? Colors.white : Colors.black54,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04, //23,
                                    ),
                                  ),
                                  _Year
                                      ? Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.arrow_drop_up,
                                          color: Colors.black54,
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 5,
                        left: 25,
                        right: 25,
                        bottom: 10,
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/amount_practice.svg',
                                  width: 23,
                                ),
                                Text(
                                  'count_of_sessions'.tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03, //
                                  ),
                                ),
                                Text(
                                  _Itogi_Mounth_Year_kol_vo(_Itog, _Mounth, _Year) ==
                                          1
                                      ? MyDB().getBox().get(MyResource
                                                  .TOTAL_COUNT_OF_SESSIONS) !=
                                              null
                                          ? MyDB()
                                              .getBox()
                                              .get(MyResource
                                                  .TOTAL_COUNT_OF_SESSIONS)
                                              .toString()
                                          : '0'
                                      : (_Itogi_Mounth_Year_kol_vo(
                                                  _Itog, _Mounth, _Year) ==
                                              2
                                          ? MyDB().getBox().get(MyResource
                                                      .TOTAL_COUNT_OF_SESSIONS) !=
                                                  null
                                              ? MyDB()
                                                  .getBox()
                                                  .get(MyResource
                                                      .TOTAL_COUNT_OF_SESSIONS)
                                                  .toString()
                                              : '0'
                                          : (_Itogi_Mounth_Year_kol_vo(
                                                      _Itog, _Mounth, _Year) ==
                                                  3
                                              ? MyDB().getBox().get(MyResource
                                                          .YEAR_COUNT_OF_SESSIONS) !=
                                                      null
                                                  ? MyDB()
                                                      .getBox()
                                                      .get(MyResource.YEAR_COUNT_OF_SESSIONS)
                                                      .toString()
                                                  : '0'
                                              : '3')),
                                  style: TextStyle(
                                    color: Color(0xff832f51),
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.085, //32,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: Colors.black54,
                                ),
                                Text(
                                  'minutes_of_awareness_with_myself'.tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03, //
                                  ),
                                ),
                                Text(
                                  _Itogi_Mounth_Year_kol_vo(_Itog, _Mounth, _Year) ==
                                          1
                                      ? MyDB().getBox().get(MyResource
                                                  .TOTAL_MINUTES_OF_AWARENESS) !=
                                              null
                                          ? MyDB()
                                              .getBox()
                                              .get(MyResource
                                                  .TOTAL_MINUTES_OF_AWARENESS)
                                              .toString()
                                          : '0'
                                      : (_Itogi_Mounth_Year_kol_vo(
                                                  _Itog, _Mounth, _Year) ==
                                              2
                                          ? MyDB().getBox().get(MyResource
                                                      .TOTAL_MINUTES_OF_AWARENESS) !=
                                                  null
                                              ? MyDB()
                                                  .getBox()
                                                  .get(MyResource
                                                      .TOTAL_MINUTES_OF_AWARENESS)
                                                  .toString()
                                              : '0'
                                          : (_Itogi_Mounth_Year_kol_vo(
                                                      _Itog, _Mounth, _Year) ==
                                                  3
                                              ? MyDB().getBox().get(MyResource
                                                          .YEAR_MINUTES_OF_AWARENESS) !=
                                                      null
                                                  ? MyDB()
                                                      .getBox()
                                                      .get(MyResource
                                                          .YEAR_MINUTES_OF_AWARENESS)
                                                      .toString()
                                                  : '0'
                                              : '3')),
                                  style: TextStyle(
                                    color: Color(0xff832f51),
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.085, //32,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.show_chart,
                                  color: Colors.black54,
                                ),
                                Text(
                                  'count_of_completed_sessions'.tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03, //
                                  ),
                                ),
                                Text(
                                  _Itogi_Mounth_Year_kol_vo(_Itog, _Mounth,
                                              _Year) ==
                                          1
                                      ? MyDB().getBox().get(MyResource
                                                  .TOTAL_COUNT_OF_COMPLETED_SESSIONS) !=
                                              null
                                          ? MyDB()
                                              .getBox()
                                              .get(MyResource
                                                  .TOTAL_COUNT_OF_COMPLETED_SESSIONS)
                                              .toString()
                                          : '0'
                                      : (_Itogi_Mounth_Year_kol_vo(_Itog,
                                                  _Mounth, _Year) ==
                                              2
                                          ? MyDB().getBox().get(MyResource
                                                      .TOTAL_COUNT_OF_COMPLETED_SESSIONS) !=
                                                  null
                                              ? MyDB()
                                                  .getBox()
                                                  .get(MyResource
                                                      .TOTAL_COUNT_OF_COMPLETED_SESSIONS)
                                                  .toString()
                                              : '0'
                                          : (_Itogi_Mounth_Year_kol_vo(
                                                      _Itog, _Mounth, _Year) ==
                                                  3
                                              ? MyDB().getBox().get(MyResource
                                                          .YEAR_COUNT_OF_COMPLETED_SESSIONS) !=
                                                      null
                                                  ? MyDB()
                                                      .getBox()
                                                      .get(MyResource
                                                          .YEAR_COUNT_OF_COMPLETED_SESSIONS)
                                                      .toString()
                                                  : '0'
                                              : '3')),
                                  style: TextStyle(
                                    color: Color(0xff832f51),
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.085, //32,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  ],
                ),
              ),
              _menuList(context),
              SizedBox(
                height: 8,
              ),
              _menuButton(context),
              SizedBox(height: 5),
              RemoveProgress(),
            ],
          ),
        ),
      ),
    );
  }

  Container _menuList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.24,
      //0.249, //0.23,
      margin: const EdgeInsets.only(
        left: 20.0,
        right: 20,
        top: 12,
        bottom: 5,
      ),
      padding: const EdgeInsets.only(bottom: 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          InkWell(
            //onTap: () => print('!!!Мои дневник!!!'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => journalMy()));
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.046,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/diary.svg',
                      width: 23,
                      color: Colors.grey[600],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'my_diary'.tr(),
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width * 0.044, //24,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_right_alt,
                        color: Colors.black54,
                        size: MediaQuery.of(context).size.width * 0.064, //24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            color: Color(0xffEBC2BE),
          ),
          InkWell(
            onTap: () {
              billingService.isPro()
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyFitnessProgress()))
                  : Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Reclama()));
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.046,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/sport.svg',
                      width: 23,
                      color: Colors.grey[600],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'my_exercises'.tr(),
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width * 0.044, //24,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_right_alt,
                        color: Colors.black54,
                        size: MediaQuery.of(context).size.width * 0.064, //24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            color: Color(0xffEBC2BE),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => billingService.isPro()
                      ? MyAffirmationProgress()
                      : Reclama()));
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.046,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/affirmation.svg',
                      width: 23,
                      color: Colors.grey[600],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'my_affirmations'.tr(),
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width * 0.044, //24,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_right_alt,
                        color: Colors.black54,
                        size: MediaQuery.of(context).size.width * 0.064, //24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            color: Color(0xffEBC2BE),
          ),
          InkWell(
            onTap: () {
              billingService.isPro()
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyReadingProgress()))
                  : Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Reclama()));
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.046,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/books.svg',
                      width: 23,
                      color: Colors.grey[600],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'my_books'.tr(),
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width * 0.044, //24,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_right_alt,
                        color: Colors.black54,
                        size: MediaQuery.of(context).size.width * 0.064, //24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            color: Color(0xffEBC2BE),
          ),
          InkWell(
            onTap: () {
              billingService.isPro()
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyVisualizationProgress()))
                  : Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Reclama()));
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.046,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/visualization.svg',
                      width: 23,
                      color: Colors.grey[600],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'my_visualization'.tr(),
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width * 0.044, //24,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_right_alt,
                        color: Colors.black54,
                        size: MediaQuery.of(context).size.width * 0.064, //24,
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

  Container _menuButton(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      padding: EdgeInsets.only(
          top: 0,
          left: MediaQuery.of(context).size.width / 4.5,
          right: MediaQuery.of(context).size.width / 4.5,
          bottom: 0),
      child: AnimatedButton(() {
        Navigator.pushNamedAndRemoveUntil(
            context, '/start', (r) => false); //22 fontSize
      }, 'sans-serif-black', 'menu'.tr(),
          MediaQuery.of(context).size.width * 0.06, null, null),
    );
  }

  Widget getProgressBodyWidget(List<Day> days) {
    print(days.length.toString() + " length");
    return Column(
      children: createRowsByDays(days),
    );
  }

  List<Widget> createRowsByDays(List<Day> days) {
    List<Widget> list = new List();
    for (int i = 0; i < days.length; i++) {
      list.add(createRow(days[i]));
    }
    return list;
  }

  Widget createRow(Day day) {
    AffirmationProgress affirmationProgress = day.affirmationProgress;
    MeditationProgress meditationProgress = day.meditationProgress;
    FitnessProgress fitnessProgress = day.fitnessProgress;
    ReadingProgress readingProgress = day.readingProgress;
    VocabularyNoteProgress vocabularyNoteProgress = day.vocabularyNoteProgress;
    VocabularyRecordProgress vocabularyRecordProgress =
        day.vocabularyRecordProgress;
    VisualizationProgress visualizationProgress = day.visualizationProgress;
    String value;

    if (affirmationProgress != null) {
      value = createMinutesStringFromSeconds(affirmationProgress.seconds);
      value = value + ", " + affirmationProgress.text;
      return ProgressPair('affirmation_small'.tr(), value);
    } else if (meditationProgress != null) {
      value = createMinutesStringFromSeconds(meditationProgress.seconds);
      return ProgressPair('meditation_small'.tr(), value);
    } else if (visualizationProgress != null) {
      value = createMinutesStringFromSeconds(visualizationProgress.seconds);
      value = value + ", " + visualizationProgress.text;
      return ProgressPair('visualization_small'.tr(), value);
    } else if (fitnessProgress != null) {
      value = createMinutesStringFromSeconds(fitnessProgress.seconds);
      value = value + ", " + fitnessProgress.exercise;
      return ProgressPair('fitness_small'.tr(), value);
    } else if (readingProgress != null) {
      value = readingProgress.book;
      value = value + ", " + readingProgress.pages.toString();
      return ProgressPair('reading_small'.tr(), value);
    } else if (vocabularyNoteProgress != null) {
      value = vocabularyNoteProgress.note;
      return ProgressPair('diary_small'.tr(), value);
    } else if (vocabularyRecordProgress != null) {
      return ProgressPairRecord(
          'diary_small'.tr(), vocabularyRecordProgress.path);
    }
  }

  String createMinutesStringFromSeconds(int sec) {
    String result = "";

    int minutes = sec ~/ 60;
    int seconds = sec % 60;

    if (minutes > 0) {
      result = minutes.toString() +
          " " +
          'min'.tr() +
          " " +
          seconds.toString() +
          " " +
          'sec'.tr();
    } else {
      result = sec.toString() + " " + 'sec'.tr();
    }

    return result;
  }

  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0,
    minLaunches: 0,
    remindDays: 0,
    remindLaunches: 0,
    googlePlayIdentifier: 'com.wonderfullmoning.morningmagic',
    appStoreIdentifier: '1536435176',
  );

  void rateApp(BuildContext widgetContext) async {
    int launchForRate =
        await MyDB().getBox().get(MyResource.LAUNCH_FOR_RATE, defaultValue: 0);
    // Кол-во запусков равно либо больше чем нужно для показа оценки
    bool needLaunch = launchForRate == 0 || launchForRate >= 5;
    // Ранее оценили или нет?
    bool isRated =
        await MyDB().getBox().get(MyResource.IS_RATED, defaultValue: false);
    print(
        'needLaunch ${!needLaunch} && !isRated ${!isRated} && !appStates.isRating.value ${!appStates.isRating.value}');
    if (!needLaunch || isRated || !appStates.isRating.value) return;
    // Обнуляем счетчик, чтобы через N запусков показать снова, если нужно
    if (launchForRate > 0) MyDB().getBox().put(MyResource.LAUNCH_FOR_RATE, 0);
    print('Запускаем функцию rateApp');
    rateMyApp.init();
    if (Platform.isIOS) {
      print('rateApp - Platform.isIOS');
      appStates.isRating.value = false;
      try {
        showCupertinoDialog(
          barrierDismissible: false,
          context: widgetContext,
          builder: (_context) {
            return CupertinoAlertDialog(
              title: Text('rate_app_title'.tr()),
              content: Column(
                children: [
                  Text('rate_app_description'.tr()),
                  SmoothStarRating(
                    allowHalfRating: false,
                    onRated: (rating) {
                      appRating = rating.toInt();
                    },
                    starCount: 5,
                    rating: 5,
                    size: 45.0,
                    color: Colors.yellow,
                    borderColor: Colors.yellow,
                    spacing: 0.0,
                  )
                ],
              ),
              actions: [
                CupertinoDialogAction(
                  child: Text(
                    'action_remind'.tr(),
                    style: TextStyle(fontFamily: 'sans-serif'),
                  ),
                  isDestructiveAction: true,
                  onPressed: () {
                    appStates.isRating.value = false;
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text(
                    'action_rate'.tr(),
                    style:
                        TextStyle(fontFamily: 'sans-serif-black', fontSize: 16),
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    if (appRating < 5) {
                      MyDB().getBox().put(MyResource.IS_RATED, true);
                      openEmail(
                          'wonderfulmorningnow@gmail.com', 'rate_subject'.tr());
                    } else {
                      MyDB().getBox().put(MyResource.IS_RATED, true);
                      rateMyApp.launchStore();
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      } catch (e) {
        log(e.toString());
      }
    } else if (Platform.isAndroid) {
      print('rateApp - Platform.isAndroid');
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              scrollable: true,
              title: Text('rate_app_title'.tr()),
              content: Column(
                children: [
                  Text('rate_app_description'.tr()),
                  SizedBox(
                    height: 30,
                  ),
                  SmoothStarRating(
                    allowHalfRating: false,
                    onRated: (rating) {
                      appRating = rating.toInt();
                    },
                    starCount: 5,
                    rating: 5,
                    size: 45.0,
                    color: Colors.yellow,
                    borderColor: Colors.yellow,
                    spacing: 0.0,
                  )
                ],
              ),
              actions: [
                FlatButton(
                  child: Text(
                    'action_remind'.tr(),
                    style:
                        TextStyle(color: Colors.red, fontFamily: 'sans-serif'),
                  ),
                  onPressed: () {
                    appStates.isRating.value = false;
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text(
                    'action_rate'.tr(),
                    style:
                        TextStyle(fontFamily: 'sans-serif-black', fontSize: 16),
                  ),
                  onPressed: () {
                    if (appRating < 5) {
                      MyDB().getBox().put(MyResource.IS_RATED, true);
                      openEmail(
                          'wonderfulmorningnow@gmail.com', 'rate_subject'.tr());
                    } else {
                      MyDB().getBox().put(MyResource.IS_RATED, true);
                      rateMyApp.launchStore();
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }
  }

  String _getUserName() {
    String userName = "";
    User user = MyDB().getBox().get(MyResource.USER_KEY);
    if (user != null) {
      userName = user.name;
    }
    return userName;
  }

  Future<String> _editUserNameDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'your_name'.tr(),
        ),
        content: TextField(
          autofocus: true,
          controller: nameController,
          maxLines: 1,
          keyboardType: TextInputType.text,
          style: TextStyle(
            fontSize: 23,
            color: AppColors.VIOLET,
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancellation'.tr()),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context, nameController.text);
            },
            child: Text('save'.tr()),
          )
        ],
      ),
    );
  }
}

class VerticalBarLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  VerticalBarLabelChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory VerticalBarLabelChart.withSampleData() {
    return new VerticalBarLabelChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  // [BarLabelDecorator] will automatically position the label
  // inside the bar if the label will fit. If the label will not fit,
  // it will draw outside of the bar.
  // Labels can always display inside or outside using [LabelPosition].
  //
  // Text style for inside / outside can be controlled independently by setting
  // [insideLabelStyleSpec] and [outsideLabelStyleSpec].
  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      // Set a bar label decorator.
      // Example configuring different styles for inside/outside:
      //       barRendererDecorator: new charts.BarLabelDecorator(
      //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
      //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      domainAxis: new charts.OrdinalAxisSpec(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales(
          'monday_short'.tr(), MyDB().getBox().get(MyResource.MONDAY)),
      new OrdinalSales(
          'tuesday_short'.tr(), MyDB().getBox().get(MyResource.TUESDAY)),
      new OrdinalSales(
          'wednesday_short'.tr(), MyDB().getBox().get(MyResource.WEDNESDAY)),
      new OrdinalSales(
          'thursday_short'.tr(), MyDB().getBox().get(MyResource.THUSDAY)),
      new OrdinalSales(
          'friday_short'.tr(), MyDB().getBox().get(MyResource.FRIDAY)),
      new OrdinalSales(
          'saturday_short'.tr(), MyDB().getBox().get(MyResource.SATURDAY)),
      new OrdinalSales(
          'sunday_short'.tr(), MyDB().getBox().get(MyResource.SUNDAY)),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
          id: 'Sales',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: data,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (OrdinalSales sales, _) =>
              '${sales.sales.toString()}')
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

int _Itogi_Mounth_Year_kol_vo(_Itogi, _Mounth, _Year) {
  if (_Itogi) return 1;
  if (_Mounth) return 2;
  if (_Year) return 3;
  return 1;
}
