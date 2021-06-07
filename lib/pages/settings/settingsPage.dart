import 'dart:async';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/pages/affirmation/affirmation_dialog/affirmation_controller.dart';
import 'package:morningmagic/pages/reminders/reminders_page.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/services/admob.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/services/analitics/analyticService.dart';
import 'package:morningmagic/widgets/primary_button.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../app_states.dart';
import '../../db/model/affirmation_text/affirmation_text.dart';
import '../../db/model/book/book.dart';
import '../../db/model/exercise_time/exercise_time.dart';
import '../../db/model/user/user.dart';
import '../../db/resource.dart';
import '../../dialog/paymentDialog.dart';
import '../../resources/colors.dart';
import '../../storage.dart';
import '../../widgets/setting_activity_list.dart';
import '../../widgets/subscribe_1_month_button.dart';
import '../affirmation/affirmation_dialog/affirmation_dialog.dart';
import '../paywall_page.dart';
import 'settings_controller.dart';

class SettingsPage extends StatefulWidget {
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
  var cntAllMinutes = 0.obs;
  SettingsController settingsController;

  GlobalKey scaffoldKey = GlobalKey();

  @override
  void initState() {
    Get.put(AffirmationController());
    settingsController = Get.put(SettingsController());
    admobService.initInterstitial();
    _init();
    _initOpenDialog();
    initPurchaseListener();
    activityList = buildActivityList(true);
    AnalyticService.screenView('settings_page');

    if (GetPlatform.isIOS) {
      // Show tracking authorization dialog and ask for permission
      Future.delayed(2.seconds, () async {
        await AppTrackingTransparency.requestTrackingAuthorization();
      });
    }
    super.initState();
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
    ScrollController _scrollController =
        PrimaryScrollController.of(context) ?? ScrollController();

    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        key: scaffoldKey,
        body: GestureDetector(
          onTap: () {
            FocusScope?.of(context)?.unfocus();
          },
          child: Container(
              padding: EdgeInsets.only(top: 35),
              width: Get.width,
              decoration:
                  BoxDecoration(gradient: AppColors.gradient_settings_page),
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
                                'choose_sequence'.tr,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: AppColors.VIOLET,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24),
                              ),
                            )),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.only(top: 5, left: 10),
                          child: Text(
                            'choose_title'.tr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: AppColors.VIOLET,
                                fontStyle: FontStyle.normal,
                                fontSize: 14),
                          ),
                        ),
                      ),
                      SliverPadding(padding: EdgeInsets.only(top: 15)),
                      Obx(() {
                        print(
                            'rebuild list when isVip: ${billingService.isVip}');
                        return activityList;
                      }),
                      SliverPadding(padding: EdgeInsets.only(top: 5)),
                      buildCountMinutes(),
                      SliverToBoxAdapter(
                        child: Container(
                            padding: EdgeInsets.only(top: 15, left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'write_affirmation'.tr,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: AppColors.VIOLET,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 26),
                              ),
                            )),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                String _affirmationText =
                                    await _showAffirmationCategoryDialog(
                                        context);
                                if (_affirmationText != null) {
                                  setState(() {
                                    affirmationTextController.text =
                                        _affirmationText;
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 8, top: 5),
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_circle_outline,
                                      size: 40,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text('choose_ready'.tr,
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
                                    child: AffirmationTextField(
                                        affirmationTextController:
                                            affirmationTextController),
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
                              'book_name'.tr,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: AppColors.VIOLET,
                                  fontWeight: FontWeight.w600,
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
                                  color: billingService.isPro()
                                      ? AppColors.TRANSPARENT_WHITE
                                      : AppColors.TRANSPARENTS),
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 11, bottom: 11, right: 20, left: 20),
                                child: TextField(
                                  enabled:
                                      billingService.isPro() ? true : false,
                                  controller: bookController,
                                  minLines: 1,
                                  maxLines: 1,
                                  cursorColor: AppColors.VIOLET,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontStyle: FontStyle.normal,
                                      color: AppColors.VIOLET,
                                      decoration: TextDecoration.none),
                                  decoration: null,
                                ),
                              )),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 20)),
                      btnSetReminders(),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: PrimaryButton(
                            onPressed: () {
                              appAnalitics.logEvent('first_menu');
                              AppRouting.navigateToHomeWithClearHistory();
                            },
                            text: 'continue'.tr,
                          ),
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
      ),
    );
  }

  SliverToBoxAdapter btnSetReminders() {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () => Get.to(RemindersPage()),
        child: Container(
          padding: EdgeInsets.only(left: 8, top: 5, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(SvgAssets.notification, width: 40),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
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
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 16, bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                child: Text(
              'duration'.tr,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: AppColors.VIOLET,
                  fontStyle: FontStyle.normal,
                  fontSize: 14),
            )),
            Obx(
              () => Text(
                'x_minutes'.trParams({
                  'x': settingsController.countAvailableMinutes.value.toString()
                }),
                style: TextStyle(
                    color: AppColors.VIOLET,
                    fontStyle: FontStyle.normal,
                    fontSize: 21),
              ),
            )
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
      needReInit);

  void _init() {
    initTextEditingControllers();
    addListenersToEditText();
  }

  initPurchaseListener() {
    Purchases.addPurchaserInfoUpdateListener((_purchaserInfo) {
      print('Purchaser Info Listener');
      if (billingService.purchaserInfo != _purchaserInfo)
        setState(() {
          billingService.purchaserInfo = _purchaserInfo;
          print('Purchase state updated');
          activityList = buildActivityList(true);
        });
    });
  }

  void _initOpenDialog() async {
    await Future.delayed(Duration(seconds: 3));
    _openDialog();
  }

  void _openDialog() async {
    if (!billingService.isPro()) {
      Get.dialog(PaymentDialog());
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

  void addListenersToEditText() {
    affirmationTimeController.addListener(() {
      _mutateTextOnValidationFailed(
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
    });

    meditationTimeController.addListener(() {
      _mutateTextOnValidationFailed(
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
    });

    fitnessTimeController.addListener(() {
      _mutateTextOnValidationFailed(
          fitnessTimeController, MyResource.FITNESS_TIME_KEY);
      if (fitnessTimeController.text != null &&
          fitnessTimeController.text.isNotEmpty) {
        int input = int.tryParse(fitnessTimeController.text);
        if (input != null) {
          MyDB().getBox().put(MyResource.FITNESS_TIME_KEY, ExerciseTime(input));
        }
      } else {
        MyDB().getBox().put(MyResource.FITNESS_TIME_KEY, ExerciseTime(0));
      }
    });

    vocabularyTimeController.addListener(() {
      _mutateTextOnValidationFailed(
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
    });

    readingTimeController.addListener(() {
      _mutateTextOnValidationFailed(
          readingTimeController, MyResource.READING_TIME_KEY);
      if (readingTimeController.text != null &&
          readingTimeController.text.isNotEmpty) {
        int input = int.tryParse(readingTimeController.text);
        if (input != null) {
          MyDB().getBox().put(MyResource.READING_TIME_KEY, ExerciseTime(input));
        }
      } else {
        MyDB().getBox().put(MyResource.READING_TIME_KEY, ExerciseTime(0));
      }
    });

    visualizationTimeController.addListener(() {
      _mutateTextOnValidationFailed(
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
    AppRouting.navigateToHomeWithClearHistory();
    return false;
  }

  Future<String> _showAffirmationCategoryDialog(BuildContext context) async {
    return await showDialog(
        context: context, builder: (context) => AffirmationCategoryDialog());
  }

  _mutateTextOnValidationFailed(TextEditingController controller, String key) {
    if (_isInputTimeNotValid(controller.text)) {
      String _oldValue;

      if (controller.text.length > 1) {
        _oldValue = controller.text.substring(0, controller.text.length - 1);
      } else
        _oldValue = '';
      controller.clear();
      controller.text = _oldValue;
      controller.selection =
          TextSelection.collapsed(offset: controller.text.length);
    }
  }

  bool _isInputTimeNotValid(String text) {
    return text.contains(".") ||
        text.contains("-") ||
        text.contains(",") ||
        text.contains(" ") ||
        text.length > 2;
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
      style: TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.normal,
          color: AppColors.VIOLET,
          decoration: TextDecoration.none),
      decoration: InputDecoration(
        hintMaxLines: 8,
        hintText: 'affirmation_hint'.tr,
        hintStyle: TextStyle(
          color: AppColors.LIGHT_GRAY,
          fontSize: 16,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
