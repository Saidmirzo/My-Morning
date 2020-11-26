import 'dart:collection';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../db/model/progress/affirmation_progress/affirmation_progress.dart';
import '../db/model/progress/day/day.dart';
import '../db/model/progress/fitness_porgress/fitness_progress.dart';
import '../db/model/progress/meditation_progress/meditation_progress.dart';
import '../db/model/progress/progress_object.dart';
import '../db/model/progress/reading_progress/reading_progress.dart';
import '../db/model/progress/visualization_progress/visualization_progress.dart';
import '../db/model/progress/vocabulary_progress/vocabulary_note_progress.dart';
import '../db/model/progress/vocabulary_progress/vocabulary_record_progress.dart';
import '../db/progress.dart';
import '../resources/colors.dart';
import '../widgets/animatedButton.dart';
import '../widgets/progressItem.dart';
import '../widgets/progressItemHeader.dart';
import '../widgets/progressItemRecord.dart';

import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'journalMy.dart';

class AskedQuestionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AskedQuestionsState();
  }
}

class _AskedQuestionsState extends State<AskedQuestionsScreen> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  bool _Itog = true;
  bool _Mounth = false;
  bool _Year = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width, // match parent(all screen)
        height: MediaQuery.of(context).size.height, // match parent(all screen)
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
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                left: 20.0,
                right: 20,
                top: 5,
                bottom: 0,
              ),
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
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
                          'Измеритель осознонности',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.064,
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
                              text: 'За неделю',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.064,
                                color: Color(0xffaAaAaA),
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: ' минуты',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.064,
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
                                    55.0,
                                    Color(0xff00b2ff),
                                    rankKey: 'completed',
                                  ),
                                  new CircularSegmentEntry(
                                    45.0,
                                    Color(0xffb3e8ff),
                                    rankKey: 'remaining',
                                  ),
                                ],
                                rankKey: 'progress',
                              ),
                            ],
                            chartType: CircularChartType.Radial,
                            percentageValues: true,
                            holeLabel: '55 %',
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
                              width: MediaQuery.of(context).size.width / 2 - 40,
                              height: MediaQuery.of(context).size.height *
                                  0.3, //150,
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
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              height: MediaQuery.of(context).size.height * 0.21,
              margin: const EdgeInsets.only(
                left: 20.0,
                right: 20,
                top: 5,
                bottom: 5,
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffEBC2BE),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  'Итого',
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
                                  'Месяц',
                                  style: TextStyle(
                                    color:
                                        _Mounth ? Colors.white : Colors.black54,
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
                                  'Год',
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
                    padding: EdgeInsets.only(top: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.headset,
                              color: Colors.black54,
                            ),
                            Text(
                              'Число\nсеансов',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03, //
                              ),
                            ),
                            Text(
                              _Itogi_Mounth_Year_kol_vo(
                                          _Itog, _Mounth, _Year) ==
                                      1
                                  ? '1'
                                  : (_Itogi_Mounth_Year_kol_vo(
                                              _Itog, _Mounth, _Year) ==
                                          2
                                      ? '4'
                                      : (_Itogi_Mounth_Year_kol_vo(
                                                  _Itog, _Mounth, _Year) ==
                                              3
                                          ? '1'
                                          : '1')),
                              style: TextStyle(
                                color: Color(0xff832f51),
                                fontSize: MediaQuery.of(context).size.width *
                                    0.085, //32,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.timer,
                              color: Colors.black54,
                            ),
                            Text(
                              'Минуты \nединения с\nсобой',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03, //
                              ),
                            ),
                            Text(
                              _Itogi_Mounth_Year_kol_vo(
                                          _Itog, _Mounth, _Year) ==
                                      1
                                  ? '3'
                                  : (_Itogi_Mounth_Year_kol_vo(
                                              _Itog, _Mounth, _Year) ==
                                          2
                                      ? '2'
                                      : (_Itogi_Mounth_Year_kol_vo(
                                                  _Itog, _Mounth, _Year) ==
                                              3
                                          ? '2'
                                          : '3')),
                              style: TextStyle(
                                color: Color(0xff832f51),
                                fontSize: MediaQuery.of(context).size.width *
                                    0.085, //32,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.show_chart,
                              color: Colors.black54,
                            ),
                            Text(
                              'Число \nсеансов',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03, //
                              ),
                            ),
                            Text(
                              _Itogi_Mounth_Year_kol_vo(
                                          _Itog, _Mounth, _Year) ==
                                      1
                                  ? '5'
                                  : (_Itogi_Mounth_Year_kol_vo(
                                              _Itog, _Mounth, _Year) ==
                                          2
                                      ? '1'
                                      : (_Itogi_Mounth_Year_kol_vo(
                                                  _Itog, _Mounth, _Year) ==
                                              3
                                          ? '2'
                                          : '5')),
                              style: TextStyle(
                                color: Color(0xff832f51),
                                fontSize: MediaQuery.of(context).size.width *
                                    0.085, //32,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    //height: MediaQuery.of(context).size.height * 0.2,
                  ),
                ],
              ),
            ),
            Container(
              height:
                  MediaQuery.of(context).size.height * 0.24, //0.249, //0.23,
              margin: const EdgeInsets.only(
                left: 20.0,
                right: 20,
                top: 5,
                bottom: 5,
              ),
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
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
                            Icon(
                              Icons.assignment,
                              color: Colors.black54,
                              size: MediaQuery.of(context).size.width *
                                  0.064, //24,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Мои дневник',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.044, //24,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.arrow_right_alt, color: Colors.black54,
                                size: MediaQuery.of(context).size.width *
                                    0.064, //24,
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
                    onTap: () => print('!!!Мои упражнения!!!'),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.046,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.speaker_notes, color: Colors.black54,
                              size: MediaQuery.of(context).size.width *
                                  0.064, //24,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Мои упражнения',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.044, //24,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.arrow_right_alt, color: Colors.black54,
                                size: MediaQuery.of(context).size.width *
                                    0.064, //24,
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
                    onTap: () => print('!!!Мои аффермации!!!'),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.046,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite, color: Colors.black54,
                              size: MediaQuery.of(context).size.width *
                                  0.064, //24,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Мои аффермации',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.044, //24,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.arrow_right_alt, color: Colors.black54,
                                size: MediaQuery.of(context).size.width *
                                    0.064, //24,
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
                    onTap: () => print('!!!Мои книги!!!'),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.046,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.note_add, color: Colors.black54,
                              size: MediaQuery.of(context).size.width *
                                  0.064, //24,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Мои книги',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.044, //24,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.arrow_right_alt, color: Colors.black54,
                                size: MediaQuery.of(context).size.width *
                                    0.064, //24,
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
                    onTap: () => print('!!!Мои достижения!!!'),
                    child: Container(
                      //height: MediaQuery.of(context).size.height * 0.03,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.stars, color: Colors.black54,
                              size: MediaQuery.of(context).size.width *
                                  0.064, //24,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Мои достижения',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.044, //24,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.arrow_right_alt, color: Colors.black54,
                                size: MediaQuery.of(context).size.width *
                                    0.064, //24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(
            //       top: MediaQuery.of(context).size.height / 15,
            //       bottom: MediaQuery.of(context).size.height / 50),
            //   child: Center(
            //     child: Text(
            //       'progress'.tr(),
            //       style: TextStyle(
            //         fontSize: 32,
            //         fontFamily: "sans-serif-black",
            //         fontStyle: FontStyle.normal,
            //         color: AppColors.WHITE,
            //       ),
            //     ),
            //   ),
            // ),
            Spacer(flex: 1),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              padding: EdgeInsets.only(
                  top: 0,
                  left: MediaQuery.of(context).size.width / 4.5,
                  right: MediaQuery.of(context).size.width / 4.5,
                  bottom: 10),
              child: AnimatedButton(() {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/start', (r) => false); //22 fontSize
              }, 'sans-serif', 'menu'.tr(),
                  MediaQuery.of(context).size.width * 0.06, null, null),
            ),
          ],
        ),
      ),
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
      new OrdinalSales('сб', 2),
      new OrdinalSales('вс', 3),
      new OrdinalSales('пн', 5),
      new OrdinalSales('вт', 4),
      new OrdinalSales('ср', 6),
      new OrdinalSales('чт', 1),
      new OrdinalSales('пт', 7),
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
