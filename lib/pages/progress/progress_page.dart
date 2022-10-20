// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart_two/flutter_circular_chart_two.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/services/progress.dart';
import 'package:morningmagic/utils/other.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../app_states.dart';
import '../../dialog/deleteProgressDialog.dart';
import '../../services/analitics/all.dart';

class ProgressPage extends StatefulWidget {
  final bool onDone;

  const ProgressPage({Key key, this.onDone = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProgressPageState();
  }
}

class _ProgressPageState extends State<ProgressPage> {
  AppStates appStates = Get.put(AppStates());
  int appRating = 5;

  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();

  ProgressController cPg = Get.find();

  bool _Itog = true;
  bool _Mounth = false;
  bool _Year = false;

  // String userName;

  // TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    print('onDine complex ${widget.onDone}');
    if (widget.onDone) {
      // Если комплекс был полностью завершен
      cPg.saveJournal(MyResource.FULL_COMPLEX_FINISH, 1);
      AppMetrica.reportEvent('complex_finish');
    }
    cPg.loadJournals();
    setState(() {});
    AnalyticService.screenView('dashboard');
    // userName = _getUserName();
    // nameController = TextEditingController(text: userName);
  }

  @override
  Widget build(BuildContext context) {
    rateApp(context);
    return Scaffold(
      body: AppGradientContainer(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    child: const Padding(
                      padding: EdgeInsets.only(left: 31, top: 30, bottom: 15),
                      child: Icon(
                        Icons.west,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    onTap: () {
                      return AppRouting.navigateToHomeWithClearHistory();
                    },
                  ),
                ),
                buildTwoWidget(),
                const SizedBox(
                  height: 20,
                ),
                buildStatWidget(),
                const SizedBox(height: 15),
                buildStatWidgettwo(),
                const SizedBox(
                  height: 45,
                ),
                GestureDetector(
                    onTap: () {
                      Get.dialog(DeleteProgressDialog(
                        () async {
                          await MyDB().clearWithoutUserName();
                          AppRouting.navigateToHomeWithClearHistory();
                        },
                      ));
                      appAnalitics.logEvent('first_dellprogress');
                    },
                    child: Column(
                      children: [
                        Text(
                          'remove_progress'.tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          height: 2,
                          width: 170,
                          color: Colors.white,
                        )
                      ],
                    )),
                const SizedBox(height: 20),
                /*  buildLanguageSwitcher(),
                SizedBox(height: 20), */
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildStatWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 31),
      padding: const EdgeInsets.all(17.34),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: buildPercent(),
    );
  }

  Container buildStatWidgettwo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 31),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: buildChart(),
    );
  }

  Widget buildPercent() {
    double monthPercent = cPg.percentOfAwareness(DateTime.now());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: Get.height / 6.962327134,
            lineWidth: 14,
            animation: false,
            percent: monthPercent / 100,
            center: Text(
              '$monthPercent %',
              style: const TextStyle(
                  color: Color(0xff592F72),
                  fontWeight: FontWeight.w600,
                  fontSize: 17.2,
                  fontFamily: 'Montserrat'),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            linearGradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xff592F72),
                Color(0xffEEA6C8),
              ],
            ),
            backgroundColor: const Color(0xffEEA6C8).withOpacity(.21),
          ),
          const SizedBox(
            width: 15.42,
          ),
          Text(
            'awareness_meter'.tr,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xff592F72),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChart() {
    return Column(
      children: [
        Text(
          'Mindful minutes per week'.tr,
          style: TextStyle(
            fontSize: Get.height * 0.015,
            color: const Color(0xff592F72),
            fontWeight: FontWeight.w600,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: Get.width / 1.13,
              height: Get.height * 0.23,
              child: VerticalBarLabelChart.withSampleData(),
            ),
          ],
        ),
      ],
    );
  }

  Container buildTwoWidget() {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 31),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 14.1,
              bottom: 14.1,
              left: Get.locale == const Locale('ru') ? 40 : 40,
              right: Get.locale == const Locale('ru') ? 48 : 42,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffE7A1C9).withOpacity(.19),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Row(
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
                          'total'.tr,
                          style: TextStyle(
                            color: _Itog
                                ? const Color(0xff592F72)
                                : Colors.black54,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.04, //23,
                          ),
                        ),
                        _Itog
                            ? const Icon(
                                Icons.arrow_drop_down,
                                color: Color(0xff592F72),
                              )
                            : const Icon(
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
                          'month'.tr,
                          style: TextStyle(
                            color: _Mounth
                                ? const Color(0xff592F72)
                                : Colors.black54,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                        _Mounth
                            ? const Icon(
                                Icons.arrow_drop_down,
                                color: Color(0xff592F72),
                              )
                            : const Icon(
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
                          'year'.tr,
                          style: TextStyle(
                            color: _Year
                                ? const Color(0xff592F72)
                                : Colors.black54,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.04, //23,
                          ),
                        ),
                        _Year
                            ? const Icon(Icons.arrow_drop_down,
                                color: Color(0xff592F72))
                            : const Icon(
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
            padding: const EdgeInsets.only(
              top: 5,
              left: 25,
              right: 25,
              bottom: 10,
            ),
            ////////////////////////////////////////////////////////////////////////////////////
            child: Stack(
              children: [
                practicsCount(),
                minutesCount(),
                completeComplexCount(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget getTopStatisticBlock() {
  //   return Container(
  //     width: double.maxFinite,
  //     margin: EdgeInsets.symmetric(horizontal: 31),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(19),
  //       color: Colors.white,
  //     ),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Container(
  //           width: double.maxFinite,
  //           height: 52,
  //           alignment: Alignment.center,
  //           decoration: BoxDecoration(
  //             color: Color(0xffE7A1C9).withOpacity(.19),
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(19),
  //               topRight: Radius.circular(19),
  //             ),
  //           ),
  //           child: Row(
  //             children: [],
  //           ),
  //         ),
  //       ],
  //     ),
  //     // padding: EdgeInsets,
  //   );
  // }

  Widget practicsCount() {
    var count = cPg
        .calcStatByPeriod(_Itogi_Mounth_Year_kol_vo(_Itog, _Mounth, _Year))[0];
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 14,
          ),
          Image.asset(
            'assets/images/myicone1st.png',
            width: 12.7,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'count_of_sessions'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: MediaQuery.of(context).size.width * 0.03, //
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            count.toString(),
            style: const TextStyle(
              color: Color(0xff592F72),
              fontSize: 24, //32,
            ),
          ),
        ],
      ),
    );
  }

  Align minutesCount() {
    var count = cPg
        .calcStatByPeriod(_Itogi_Mounth_Year_kol_vo(_Itog, _Mounth, _Year))[1];
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 14),
          Image.asset(
            'assets/images/myicone2st.png',
            width: 18.5,
          ),
          const SizedBox(height: 10),
          Text(
            'minutes_of_awareness_with_myself'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: MediaQuery.of(context).size.width * 0.03,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            double.parse(count.toStringAsFixed(1)).toString(),
            style: const TextStyle(
              color: Color(0xff592F72),
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }

  Align completeComplexCount() {
    var count =
        cPg.getCountComplex(_Itogi_Mounth_Year_kol_vo(_Itog, _Mounth, _Year));
    return Align(
      alignment: Alignment.topRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 14),
          Image.asset(
            'assets/images/myicone3st.png',
            width: 18.5,
          ),
          const SizedBox(height: 10),
          Text(
            'count_of_completed_sessions'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: MediaQuery.of(context).size.width * 0.03, //
            ),
          ),
          const SizedBox(height: 15),
          Text(
            count.toString(),
            style: const TextStyle(
              color: Color(0xff592F72),
              fontSize: 24, //32,
            ),
          ),
        ],
      ),
    );
  }

  // Widget buildLanguageSwitcher() => SizedBox(
  //     width: MediaQuery.of(context).size.width * 0.9,
  //     child: const LanguageSwitcher());

  // Container _menuList(BuildContext context) {
  //   return Container(
  //     decoration: const BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.all(Radius.circular(20))),
  //     child: Column(
  //       children: [
  //         menuBtn('assets/images/diary.svg', 'my_diary'.tr,
  //             () => Get.to(MyDiaryProgress())),
  //         menuBtn('assets/images/sport.svg', 'my_exercises'.tr, () {
  //           billingService.isPro()
  //               ? Navigator.of(context).push(MaterialPageRoute(
  //                   builder: (context) => MyFitnessProgress()))
  //               : Navigator.of(context).push(
  //                   MaterialPageRoute(builder: (context) => PaywallPage()));
  //         }),
  //         menuBtn('assets/images/affirmation.svg', 'my_affirmations'.tr, () {
  //           Navigator.of(context).push(MaterialPageRoute(
  //               builder: (context) => billingService.isPro()
  //                   ? MyAffirmationProgress()
  //                   : PaywallPage()));
  //         }),
  //         menuBtn('assets/images/books.svg', 'my_books'.tr, () {
  //           billingService.isPro()
  //               ? Navigator.of(context).push(MaterialPageRoute(
  //                   builder: (context) => MyReadingProgress()))
  //               : Navigator.of(context).push(
  //                   MaterialPageRoute(builder: (context) => PaywallPage()));
  //         }),
  //         menuBtn('assets/images/visualization.svg', 'my_visualization'.tr, () {
  //           billingService.isPro()
  //               ? Navigator.of(context).push(MaterialPageRoute(
  //                   builder: (context) => MyVisualizationProgress()))
  //               : Navigator.of(context).push(
  //                   MaterialPageRoute(builder: (context) => PaywallPage()));
  //         }, showSeparator: false),
  //       ],
  //     ),
  //   );
  // }

  // Widget menuBtn(String iconPath, String title, Function onTap,
  //     {bool showSeparator = true}) {
  //   return Column(
  //     children: [
  //       InkWell(
  //         onTap: onTap,
  //         child: Container(
  //           padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               SvgPicture.asset(iconPath, width: 23, color: Colors.grey[600]),
  //               const SizedBox(width: 10),
  //               Text(
  //                 title,
  //                 style: TextStyle(
  //                   fontSize: MediaQuery.of(context).size.width * 0.044,
  //                   color: Colors.black54,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               const Spacer(),
  //               Icon(
  //                 Icons.arrow_right_alt,
  //                 color: Colors.black54,
  //                 size: MediaQuery.of(context).size.width * 0.064,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       if (showSeparator)
  //         Container(
  //           height: 1,
  //           color: const Color(0xffEBC2BE),
  //         ),
  //     ],
  //   );
  // }

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
    // Кол-во запусков для первого показа
    const int firstCntLaunch = 2;
    // Кол-во запусков для следующих показов
    const int nextCntLaunch = 5;
    int launchForRate =
        await MyDB().getBox().get(MyResource.LAUNCH_FOR_RATE, defaultValue: 0);
    // Кол-во запусков равно либо больше чем нужно для показа оценки
    bool needLaunch =
        launchForRate >= firstCntLaunch || launchForRate >= nextCntLaunch;
    // Ранее оценили или нет?
    bool isRated =
        await MyDB().getBox().get(MyResource.IS_RATED, defaultValue: false);
    bool rateFirstShowed = await MyDB()
        .getBox()
        .get(MyResource.RATE_ALREADY_SHOWED, defaultValue: false);
    // Если раньше уже показали, ждем минимум 5 запусков после последнего показа
    if (launchForRate < nextCntLaunch && rateFirstShowed) {
      // print(
      //     'rateApp   уже показывали, ждем еще минимум ${nextCntLaunch - launchForRate} запусков');
      return;
    }
    if (!needLaunch || isRated || !appStates.isRating.value) return;
    // Обнуляем счетчик, чтобы через N запусков показать снова, если нужно
    MyDB().getBox().put(MyResource.LAUNCH_FOR_RATE, 0);
    // Запоминаем, что раньше уже показывали
    MyDB().getBox().put(MyResource.RATE_ALREADY_SHOWED, true);
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
              title: Text('rate_app_title'.tr),
              content: Column(
                children: [
                  Text('rate_app_description'.tr),
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
                    'action_remind'.tr,
                  ),
                  isDestructiveAction: true,
                  onPressed: () {
                    appStates.isRating.value = false;
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text(
                    'action_rate'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    if (appRating < 5) {
                      MyDB().getBox().put(MyResource.IS_RATED, true);
                      openEmail('morning@good-apps.org', 'rate_subject'.tr);
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
              title: Text('rate_app_title'.tr),
              content: Column(
                children: [
                  Text('rate_app_description'.tr),
                  const SizedBox(
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
                TextButton(
                  child: Text(
                    'action_remind'.tr,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    appStates.isRating.value = false;
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text(
                    'action_rate'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    if (appRating < 5) {
                      MyDB().getBox().put(MyResource.IS_RATED, true);
                      openEmail('morning@good-apps.org', 'rate_subject'.tr);
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

  // String _getUserName() {
  //   String userName = "";
  //   User user = MyDB().getBox().get(MyResource.USER_KEY);
  //   if (user != null) {
  //     userName = user.name;
  //   }
  //   return userName;
  // }

  // Future<String> _editUserNameDialog() {
  //   return showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text(
  //         'your_name'.tr,
  //       ),
  //       content: TextField(
  //         autofocus: true,
  //         controller: nameController,
  //         maxLines: 1,
  //         keyboardType: TextInputType.text,
  //         style: const TextStyle(
  //           fontSize: 23,
  //           color: AppColors.VIOLET,
  //         ),
  //       ),
  //       actions: [
  //         FlatButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: Text('cancellation'.tr),
  //         ),
  //         FlatButton(
  //           onPressed: () {
  //             Navigator.pop(context, nameController.text);
  //           },
  //           child: Text('save'.tr),
  //         )
  //       ],
  //     ),
  //   );
  // }
}

class VerticalBarLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  const VerticalBarLabelChart(this.seriesList, {this.animate});

  factory VerticalBarLabelChart.withSampleData() {
    return VerticalBarLabelChart(
      _createSampleData(),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      domainAxis: const charts.OrdinalAxisSpec(),
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    ProgressController cPg = Get.find();
    var date = DateTime.now();
    var monday = date.add(-(date.weekday - 1).days);
    monday = DateTime(monday.year, monday.month, monday.day);

    final data = [
      OrdinalSales('monday_short'.tr, cPg.minutesPerDay(monday)),
      OrdinalSales('tuesday_short'.tr, cPg.minutesPerDay(monday.add(1.days))),
      OrdinalSales('wednesday_short'.tr, cPg.minutesPerDay(monday.add(2.days))),
      OrdinalSales('thursday_short'.tr, cPg.minutesPerDay(monday.add(3.days))),
      OrdinalSales('friday_short'.tr, cPg.minutesPerDay(monday.add(4.days))),
      OrdinalSales('saturday_short'.tr, cPg.minutesPerDay(monday.add(5.days))),
      OrdinalSales('sunday_short'.tr, cPg.minutesPerDay(monday.add(6.days))),
    ];

    return [
      charts.Series<OrdinalSales, String>(
          id: 'Sales',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: data,

          // seriesColor: Colors.accents,
          // seriesColor: Colors.green,
          // seriesColor: Color(0xffac72a2),
          // outsideLabelStyleAccessorFn: ,
          fillColorFn: (x, y) => charts.MaterialPalette.purple.shadeDefault,
          // Set a label accessor to control the text of the bar label.
          // outsideLabelStyleAccessorFn: (OrdinalSales sales, int num) =>  const charts.TextStyleSpec(color: Colors.green),
          labelAccessorFn: (OrdinalSales sales, _) => sales.sales.toString()),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

int _Itogi_Mounth_Year_kol_vo(Itogi, Mounth, Year) {
  if (Itogi) return 1;
  if (Mounth) return 2;
  if (Year) return 3;
  return 1;
}
