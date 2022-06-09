import 'dart:developer';
import 'dart:io';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart_two/flutter_circular_chart_two.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/adjust_config.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/user/user.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/pages/progress/components/remove_button.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/services/progress.dart';
import 'package:morningmagic/utils/other.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../app_states.dart';
import '../../storage.dart';
import '../../widgets/language_switcher.dart';
import '../paywall_page.dart';
import 'components/menu_button.dart';
import 'diary_progress/diary_progress.dart';
import 'myAffirmationProgress.dart';
import 'myFitnessProgress.dart';
import 'myReadingProgress.dart';
import 'myVisualizationProgress.dart';

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

  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  ProgressController cPg = Get.find();

  bool _Itog = true;
  bool _Mounth = false;
  bool _Year = false;

  String userName;

  TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    AdJust.trackevent(AdJust.installEvent);
    print('onDine complex ${widget.onDone}');
    if (widget.onDone) {
      // Если комплекс был полностью завершен
      cPg.saveJournal(MyResource.FULL_COMPLEX_FINISH, 1);
      AppMetrica.reportEvent('complex_finish');
    }
    cPg.loadJournals();
    setState(() {});
    AnalyticService.screenView('dashboard');
    userName = _getUserName();
    nameController = TextEditingController(text: userName);
  }

  @override
  Widget build(BuildContext context) {
    rateApp(context);
    return Scaffold(
      body: AppGradientContainer(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: PrimaryCircleButton(
                      icon: Icon(Icons.arrow_back, color: AppColors.primary),
                      onPressed: () {
                        return AppRouting.navigateToHomeWithClearHistory();
                      },
                    ),
                  ),
                  Visibility(
                    visible: userName.isNotEmpty,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: InkWell(
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
                          padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 16, bottom: 16),
                          child: Text(
                            userName,
                            style: TextStyle(fontSize: 23, color: AppColors.VIOLET),
                          ),
                        ),
                      ),
                    ),
                  ),
                  buildStatWidget(),
                  SizedBox(height: 15),
                  buildTwoWidget(),
                  SizedBox(height: 15),
                  _menuList(context),
                  SizedBox(height: 15),
                  // menuButton(),
                  // SizedBox(height: 15),
                  removeButton(),
                  SizedBox(height: 20),
                  /*  buildLanguageSwitcher(),
                  SizedBox(height: 20), */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildStatWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPercent(),
          Expanded(child: buildChart()),
        ],
      ),
    );
  }

  Widget buildPercent() {
    double monthPercent = cPg.percentOfAwareness(DateTime.now());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Text(
            'awareness_meter'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: Get.height * 0.023, color: Colors.black45, fontWeight: FontWeight.w500),
          ),
          AnimatedCircularChart(
            key: _chartKey,
            size: Size(Get.width / 3, Get.width / 3),
            initialChartData: <CircularStackEntry>[
              new CircularStackEntry(
                [
                  new CircularSegmentEntry(
                    monthPercent,
                    Color(0xff00b2ff),
                    rankKey: 'completed',
                  ),
                  new CircularSegmentEntry(
                    (100 - monthPercent),
                    Color(0xffb3e8ff),
                    rankKey: 'remaining',
                  ),
                ],
                rankKey: 'progress',
              ),
            ],
            chartType: CircularChartType.Radial,
            percentageValues: true,
            holeLabel: '$monthPercent %',
            edgeStyle: SegmentEdgeStyle.round,
            labelStyle: new TextStyle(
              color: Colors.blueGrey[600],
              fontWeight: FontWeight.bold,
              fontSize: Get.height * 0.027,
            ),
          ),
        ],
      ),
    );
  }

  Column buildChart() {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'for_week'.tr,
              style: TextStyle(
                fontSize: Get.height * 0.023,
                color: Colors.black.withOpacity(.6),
                fontWeight: FontWeight.w800,
              ),
              children: [
                TextSpan(
                  text: 'minutes_per_week'.tr,
                  style: TextStyle(
                    fontSize: Get.height * 0.018,
                    color: Color(0xffaAaAaA),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: Get.width / 1.8,
                height: Get.height * 0.2,
                child: VerticalBarLabelChart.withSampleData(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container buildTwoWidget() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Get.locale == Locale('ru') ? 40 : 40,
              right: Get.locale == Locale('ru') ? 48 : 42,
            ),
            decoration: BoxDecoration(
                color: Color(0xffEBC2BE),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                )),
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
                            color: _Itog ? Colors.white : Colors.black54,
                            fontSize: MediaQuery.of(context).size.width * 0.04, //23,
                          ),
                        ),
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
                          'month'.tr,
                          style: TextStyle(
                            color: _Mounth ? Colors.white : Colors.black54,
                            fontSize: MediaQuery.of(context).size.width * 0.04, //23,
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
                          'year'.tr,
                          style: TextStyle(
                            color: _Year ? Colors.white : Colors.black54,
                            fontSize: MediaQuery.of(context).size.width * 0.04, //23,
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

  Widget practicsCount() {
    var count = cPg.calcStatByPeriod(_Itogi_Mounth_Year_kol_vo(_Itog, _Mounth, _Year))[0];
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            'assets/images/amount_practice.svg',
            width: 23,
          ),
          Text(
            'count_of_sessions'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: MediaQuery.of(context).size.width * 0.03, //
            ),
          ),
          Text(
            count.toString(),
            style: TextStyle(
              color: Color(0xff832f51),
              fontSize: MediaQuery.of(context).size.width * 0.085, //32,
            ),
          ),
        ],
      ),
    );
  }

  Align minutesCount() {
    var count = cPg.calcStatByPeriod(_Itogi_Mounth_Year_kol_vo(_Itog, _Mounth, _Year))[1];
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.timer,
            color: Colors.black54,
          ),
          Text(
            'minutes_of_awareness_with_myself'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: MediaQuery.of(context).size.width * 0.03,
            ),
          ),
          Text(
            double.parse(count.toStringAsFixed(1)).toString(),
            style: TextStyle(
              color: Color(0xff832f51),
              fontSize: MediaQuery.of(context).size.width * 0.085,
            ),
          ),
        ],
      ),
    );
  }

  Align completeComplexCount() {
    var count = cPg.getCountComplex(_Itogi_Mounth_Year_kol_vo(_Itog, _Mounth, _Year));
    return Align(
      alignment: Alignment.topRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.show_chart,
            color: Colors.black54,
          ),
          Text(
            'count_of_completed_sessions'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: MediaQuery.of(context).size.width * 0.03, //
            ),
          ),
          Text(
            count.toString(),
            style: TextStyle(
              color: Color(0xff832f51),
              fontSize: MediaQuery.of(context).size.width * 0.085, //32,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLanguageSwitcher() => Container(width: MediaQuery.of(context).size.width * 0.9, child: LanguageSwitcher());

  Container _menuList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          menuBtn('assets/images/diary.svg', 'my_diary'.tr, () => Get.to(MyDiaryProgress())),
          menuBtn('assets/images/sport.svg', 'my_exercises'.tr, () {
            billingService.isPro()
                ? Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyFitnessProgress()))
                : Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaywallPage()));
          }),
          menuBtn('assets/images/affirmation.svg', 'my_affirmations'.tr, () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => billingService.isPro() ? MyAffirmationProgress() : PaywallPage()));
          }),
          menuBtn('assets/images/books.svg', 'my_books'.tr, () {
            billingService.isPro()
                ? Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyReadingProgress()))
                : Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaywallPage()));
          }),
          menuBtn('assets/images/visualization.svg', 'my_visualization'.tr, () {
            billingService.isPro()
                ? Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyVisualizationProgress()))
                : Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaywallPage()));
          }, showSeparator: false),
        ],
      ),
    );
  }

  Widget menuBtn(String iconPath, String title, Function onTap, {bool showSeparator = true}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(iconPath, width: 23, color: Colors.grey[600]),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.044,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_right_alt,
                  color: Colors.black54,
                  size: MediaQuery.of(context).size.width * 0.064,
                ),
              ],
            ),
          ),
        ),
        if (showSeparator)
          Container(
            height: 1,
            color: Color(0xffEBC2BE),
          ),
      ],
    );
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
    // Кол-во запусков для первого показа
    const int firstCntLaunch = 2;
    // Кол-во запусков для следующих показов
    const int nextCntLaunch = 5;
    int launchForRate = await MyDB().getBox().get(MyResource.LAUNCH_FOR_RATE, defaultValue: 0);
    // Кол-во запусков равно либо больше чем нужно для показа оценки
    bool needLaunch = launchForRate >= firstCntLaunch || launchForRate >= nextCntLaunch;
    // Ранее оценили или нет?
    bool isRated = await MyDB().getBox().get(MyResource.IS_RATED, defaultValue: false);
    bool rateFirstShowed = await MyDB().getBox().get(MyResource.RATE_ALREADY_SHOWED, defaultValue: false);
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
                    style: TextStyle(fontSize: 16),
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
                    'action_remind'.tr,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    appStates.isRating.value = false;
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text(
                    'action_rate'.tr,
                    style: TextStyle(fontSize: 16),
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
          'your_name'.tr,
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
            child: Text('cancellation'.tr),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context, nameController.text);
            },
            child: Text('save'.tr),
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

  factory VerticalBarLabelChart.withSampleData() {
    return new VerticalBarLabelChart(
      _createSampleData(),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      domainAxis: new charts.OrdinalAxisSpec(),
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    ProgressController cPg = Get.find();
    var date = DateTime.now();
    var monday = date.add(-(date.weekday - 1).days);
    monday = DateTime(monday.year, monday.month, monday.day);

    final data = [
      new OrdinalSales('monday_short'.tr, cPg.minutesPerDay(monday)),
      new OrdinalSales('tuesday_short'.tr, cPg.minutesPerDay(monday.add(1.days))),
      new OrdinalSales('wednesday_short'.tr, cPg.minutesPerDay(monday.add(2.days))),
      new OrdinalSales('thursday_short'.tr, cPg.minutesPerDay(monday.add(3.days))),
      new OrdinalSales('friday_short'.tr, cPg.minutesPerDay(monday.add(4.days))),
      new OrdinalSales('saturday_short'.tr, cPg.minutesPerDay(monday.add(5.days))),
      new OrdinalSales('sunday_short'.tr, cPg.minutesPerDay(monday.add(6.days))),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
          id: 'Sales',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: data,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (OrdinalSales sales, _) => '${sales.sales.toString()}')
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
