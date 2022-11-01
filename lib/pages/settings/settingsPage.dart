import 'dart:async';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/reordering_program/order_item.dart';
import 'package:morningmagic/pages/affirmation/affirmation_dialog/affirmation_controller.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/pages/reminders/reminders_page.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import '../../app_states.dart';
import '../../db/model/affirmation_text/affirmation_text.dart';
import '../../db/model/exercise_time/exercise_time.dart';
import '../../db/model/user/user.dart';
import '../../db/resource.dart';
import '../../resources/colors.dart';
import '../../services/ab_testing_service.dart';
import '../../storage.dart';
import '../../widgets/setting_activity_list.dart';
import '../affirmation/affirmation_dialog/affirmation_dialog.dart';
import 'settings_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

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
  Widget activityList;
  AppStates appStates = Get.put(AppStates());

  SettingsController settingsController;

  // Количество запусков экрана настроек
  int countLaunchesSettingsPage = 0;

  @override
  void initState() {
    AppMetrica.reportEvent('settings_screen');
    Get.put(AffirmationController());
    settingsController = Get.put(SettingsController());
    _init();
    // _initTarifDialog();
    activityList = buildActivityList(true);
    AnalyticService.screenView('settings_page');
    getAndSetCountLaunches();

    super.initState();
  }

  void getAndSetCountLaunches() {
    countLaunchesSettingsPage = MyDB().getBox().get(MyResource.LAUNCH_SETTINGS_PAGE, defaultValue: 0) + 1;
    MyDB().getBox().put(MyResource.LAUNCH_SETTINGS_PAGE, countLaunchesSettingsPage);
    print('countLaunchesSettingsPage: $countLaunchesSettingsPage');
  }

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
  Widget build(BuildContext context) {
    ScrollController _scrollController = PrimaryScrollController.of(context) ?? ScrollController();
    double titleFontSize = Get.width * 0.055;

    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope?.of(context)?.unfocus();
          },
          child: Container(
              padding: const EdgeInsets.only(top: 35),
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/settingspagecolor.jpg'), fit: BoxFit.cover),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Form(
                        child: CustomScrollView(
                          controller: _scrollController,
                          slivers: <Widget>[
                            SliverToBoxAdapter(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () => Get.to(() => const MainMenuPage()),
                                    child: const Icon(
                                      Icons.west,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  buildCountMinutes(),
                                ],
                              ),
                            ),

                            SliverToBoxAdapter(
                              child: Container(
                                padding: const EdgeInsets.only(top: 10, left: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'choose_sequence'.tr,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.w600, fontSize: titleFontSize),
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Container(
                                padding: const EdgeInsets.only(top: 10, left: 10),
                                child: Text(
                                  'choose_title'.tr,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white, fontStyle: FontStyle.normal, fontSize: Get.width * .033),
                                ),
                              ),
                            ),
                            const SliverPadding(padding: EdgeInsets.only(top: 11)),
                            Obx(() {
                              print(settingsController.countAvailableMinutes);
                              return activityList ?? const CircularProgressIndicator();
                            }),
                            // activityList,
                            SliverToBoxAdapter(
                              child: GestureDetector(
                                  onTap: () async {
                                    if (!billingService.isPro()) {
                                      Get.to(() => ABTestingService.getPaywall(true));
                                      return;
                                    }
                                    AppMetrica.reportEvent('settings_practice_add');
                                    for (var i = 0; i < 4; i++) {
                                      if (MyDB().getBox().get("${MyResource.CUSTOM_TIME_KEY}$i") == null) {
                                        await MyDB().getBox().put("${MyResource.CUSTOM_TIME_KEY}$i", ExerciseTime(1));
                                        List<OrderItem> _itemRows = (await OrderUtil().getOrderHolder()).list;
                                        _itemRows.add(OrderItem(_itemRows.length, "${MyResource.CUSTOM_TIME_KEY}$i"));
                                        OrderUtil().addOrderHolder(_itemRows);
                                        setState(() {
                                          activityList = buildActivityList(true);
                                        });
                                        return;
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Container(
                                      height: 67,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(17),
                                        color: AppColors.VIOLET,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          !billingService.isVip.value
                                              ? SvgPicture.asset(
                                                  'assets/images/home_menu/crown.svg',
                                                  color: Colors.white,
                                                )
                                              : const SizedBox(),
                                          !billingService.isVip.value
                                              ? const SizedBox(
                                                  width: 5,
                                                )
                                              : const SizedBox(),
                                          Text(
                                            'Add your'.tr,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  SliverToBoxAdapter btnSetReminders() {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () => Get.to(() => RemindersPage()),
        child: Container(
          padding: const EdgeInsets.only(left: 8, top: 5, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(SvgAssets.notification, width: 40),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('set_reminders'.tr,
                      style: TextStyle(
                        color: AppColors.VIOLET,
                        fontSize: Get.height * 0.028,
                        fontWeight: FontWeight.normal,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCountMinutes() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
      ),
      child: Container(
        width: 220,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
          color: AppColors.VIOLET,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/butimage.png',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 6, 0, 6),
              child: Row(children: [
                Image.asset(
                  'assets/images/setingstimeIcon.png',
                  width: 22.26,
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(left: 50),
              child: RichText(
                  maxLines: 2,
                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                  text: TextSpan(children: [
                    TextSpan(

                      text: '${'duration'.tr} ${'complex'.tr}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                      ),
                    ),
                    WidgetSpan(alignment: PlaceholderAlignment.middle,
                      child: Obx(
                        () => Text(
                          'x_minutes'.trParams({
                            'x': settingsController.countAvailableMinutes.value.toString().length == 1
                                ? '${settingsController.countAvailableMinutes.value}'
                                : settingsController.countAvailableMinutes.value.toString()
                          }),
                          textAlign: TextAlign.start,
                          style: const TextStyle(color: Color(0xffE4C8FC), fontStyle: FontStyle.normal, fontSize: 13),
                        ),
                      ),
                    )
                  ])),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(left: 15.0),
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     children: <Widget>[
            //       Padding(
            //         padding: EdgeInsets.only(
            //           left: MediaQuery.of(context).size.width * 0.08,
            //           right: MediaQuery.of(context).size.width * 0.04,
            //         ),
            //         child: FittedBox(
            //           fit: BoxFit.scaleDown,
            //           child: Text(
            //             'duration'.tr,
            //             textAlign: TextAlign.start,
            //             maxLines: 1,
            //             style: const TextStyle(
            //                 color: Colors.white,
            //                 fontStyle: FontStyle.normal,
            //                 fontSize: 13),
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.only(
            //             left: MediaQuery.of(context).size.width * 0.08),
            //         child: Row(
            //           //    mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               'complex'.tr,
            //               textAlign: TextAlign.start,
            //               style: const TextStyle(
            //                   color: Colors.white,
            //                   fontStyle: FontStyle.normal,
            //                   fontSize: 13),
            //             ),
            //             const SizedBox(
            //               width: 1,
            //             ),
            //             Obx(
            //               () => Text(
            //                 'x_minutes'.trParams({
            //                   'x': settingsController
            //                               .countAvailableMinutes.value
            //                               .toString()
            //                               .length ==
            //                           1
            //                       ? '${settingsController.countAvailableMinutes.value}'
            //                       : settingsController
            //                           .countAvailableMinutes.value
            //                           .toString()
            //                 }),
            //                 textAlign: TextAlign.start,
            //                 style: const TextStyle(
            //                     color: Color(0xffE4C8FC),
            //                     fontStyle: FontStyle.normal,
            //                     fontSize: 13),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget buildActivityList(bool needReInit) => SettingsActivityList(
        meditationTimeController,
        affirmationTimeController,
        fitnessTimeController,
        vocabularyTimeController,
        readingTimeController,
        visualizationTimeController,
      );

  void _init() {
    initTextEditingControllers();
    addListenersToEditText();
  }

  void initTextEditingControllers() {
    affirmationTimeController =
        TextEditingController(text: getInitialValueForTimeField(MyResource.AFFIRMATION_TIME_KEY));
    meditationTimeController = TextEditingController(text: getInitialValueForTimeField(MyResource.MEDITATION_TIME_KEY));
    fitnessTimeController = TextEditingController(text: getInitialValueForTimeField(MyResource.FITNESS_TIME_KEY));
    vocabularyTimeController = TextEditingController(text: getInitialValueForTimeField(MyResource.DIARY_TIME_KEY));
    readingTimeController = TextEditingController(text: getInitialValueForTimeField(MyResource.READING_TIME_KEY));
    visualizationTimeController =
        TextEditingController(text: getInitialValueForTimeField(MyResource.VISUALIZATION_TIME_KEY));
    affirmationTextController = TextEditingController(text: getInitialValueForAffirmationTextField());
    bookController = TextEditingController(text: getInitialValueForBookField());
    nameController = TextEditingController(text: getInitialValueForNameField());
  }

  getInitialValueForTimeField(String key) {
    String result = "3";
    ExerciseTime time = MyDB().getBox().get(key);
    if (time != null) result = time.time.toString();
    return result;
  }

  void addListenersToEditText() {
    affirmationTimeController.addListener(() {
      _mutateTextOnValidationFailed(affirmationTimeController, MyResource.AFFIRMATION_TIME_KEY);
      if (affirmationTimeController.text != null && affirmationTimeController.text.isNotEmpty) {
        int input = int.tryParse(affirmationTimeController.text);
        if (input != null) {
          MyDB().getBox().put(MyResource.AFFIRMATION_TIME_KEY, ExerciseTime(input));
        }
      } else {
        MyDB().getBox().put(MyResource.AFFIRMATION_TIME_KEY, ExerciseTime(0));
      }
    });

    meditationTimeController.addListener(() {
      _mutateTextOnValidationFailed(meditationTimeController, MyResource.MEDITATION_TIME_KEY);
      if (meditationTimeController.text != null && meditationTimeController.text.isNotEmpty) {
        int input = int.tryParse(meditationTimeController.text);
        if (input != null) {
          MyDB().getBox().put(MyResource.MEDITATION_TIME_KEY, ExerciseTime(input));
        }
      } else {
        MyDB().getBox().put(MyResource.MEDITATION_TIME_KEY, ExerciseTime(0));
      }
    });

    fitnessTimeController.addListener(() {
      _mutateTextOnValidationFailed(fitnessTimeController, MyResource.FITNESS_TIME_KEY);
      if (fitnessTimeController.text != null && fitnessTimeController.text.isNotEmpty) {
        int input = int.tryParse(fitnessTimeController.text);
        if (input != null) {
          MyDB().getBox().put(MyResource.FITNESS_TIME_KEY, ExerciseTime(input));
        }
      } else {
        MyDB().getBox().put(MyResource.FITNESS_TIME_KEY, ExerciseTime(0));
      }
    });

    vocabularyTimeController.addListener(() {
      _mutateTextOnValidationFailed(vocabularyTimeController, MyResource.DIARY_TIME_KEY);
      if (vocabularyTimeController.text != null && vocabularyTimeController.text.isNotEmpty) {
        int input = int.tryParse(vocabularyTimeController.text);
        if (input != null) {
          MyDB().getBox().put(MyResource.DIARY_TIME_KEY, ExerciseTime(input));
        }
      } else {
        MyDB().getBox().put(MyResource.DIARY_TIME_KEY, ExerciseTime(0));
      }
    });

    readingTimeController.addListener(() {
      _mutateTextOnValidationFailed(readingTimeController, MyResource.READING_TIME_KEY);
      if (readingTimeController.text != null && readingTimeController.text.isNotEmpty) {
        int input = int.tryParse(readingTimeController.text);
        if (input != null) {
          MyDB().getBox().put(MyResource.READING_TIME_KEY, ExerciseTime(input));
        }
      } else {
        MyDB().getBox().put(MyResource.READING_TIME_KEY, ExerciseTime(0));
      }
    });

    visualizationTimeController.addListener(() {
      _mutateTextOnValidationFailed(visualizationTimeController, MyResource.VISUALIZATION_TIME_KEY);
      if (visualizationTimeController.text != null && visualizationTimeController.text.isNotEmpty) {
        int input = int.tryParse(visualizationTimeController.text);
        if (input != null) {
          MyDB().getBox().put(MyResource.VISUALIZATION_TIME_KEY, ExerciseTime(input));
        }
      } else {
        MyDB().getBox().put(MyResource.VISUALIZATION_TIME_KEY, ExerciseTime(0));
      }
    });

    affirmationTextController.addListener(() {
      if (affirmationTextController.text != null) {
        MyDB().getBox().put(MyResource.AFFIRMATION_TEXT_KEY, AffirmationText(affirmationTextController.text));
      }
      setState(() {});
    });

    bookController.addListener(() {
      if (bookController.text != null && bookController.text.isNotEmpty) {
        MyDB().getBox().put(MyResource.BOOK_KEY, bookController.text);
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

  String getInitialValueForAffirmationTextField() {
    String result = "";
    AffirmationText time = MyDB().getBox().get(MyResource.AFFIRMATION_TEXT_KEY);
    if (time != null) {
      result = time.affirmationText;
    }
    return result;
  }

  String getInitialValueForBookField() {
    return MyDB().getBox().get(MyResource.BOOK_KEY);
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
    AppRouting.navigateToHomeWithClearHistory();
    return false;
  }

  Future<String> _showAffirmationCategoryDialog(BuildContext context) async {
    return await showDialog(context: context, builder: (context) => const AffirmationCategoryDialog());
  }

  _mutateTextOnValidationFailed(TextEditingController controller, String key) {
    if (_isInputTimeNotValid(controller.text)) {
      String _oldValue;

      if (controller.text.length > 1) {
        _oldValue = controller.text.substring(0, controller.text.length - 1);
      } else {
        _oldValue = '';
      }
      controller.clear();
      controller.text = _oldValue;
      controller.selection = TextSelection.collapsed(offset: controller.text.length);
    }
  }

  bool _isInputTimeNotValid(String text) {
    return text.contains(".") || text.contains("-") || text.contains(",") || text.contains(" ") || text.length > 2;
  }
}

class AffirmationTextField extends StatelessWidget {
  const AffirmationTextField({
    Key key,
    @required this.affirmationTextController,
  }) : super(key: key);

  final TextEditingController affirmationTextController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: affirmationTextController,
      textInputAction: TextInputAction.next,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      minLines: 6,
      maxLines: 6,
      cursorColor: AppColors.VIOLET,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.left,
      style: const TextStyle(
          fontSize: 13, fontStyle: FontStyle.normal, color: AppColors.VIOLET, decoration: TextDecoration.none),
      decoration: InputDecoration(
        hintMaxLines: 8,
        hintText: 'affirmation_hint'.tr,
        hintStyle: const TextStyle(
          color: AppColors.VIOLET,
          fontSize: 13,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
