import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/affirmation_text/affirmation_text.dart';
import 'package:morningmagic/db/model/reordering_program/order_item.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/fitness/data/repositories/fitness_program_repository_impl.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/pages/fitness_program_settings.dart';
import 'package:morningmagic/pages/paywall/new_paywall.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/storage.dart';
import '../pages/affirmation/affirmation_dialog/affirmation_dialog.dart';
import '../pages/settings/settingsPage.dart';

class ExerciseTile extends StatefulWidget {
  final int index;
  final OrderItem orderItem;
  final String title;
  final EdgeInsets edgeInsets;
  final TextEditingController textEditingController;
  final Function onChange;
  final Function onChangeTitle;
  final Function onRemove;

  const ExerciseTile(
      {Key key,
      @required this.index,
      @required this.orderItem,
      @required this.title,
      @required this.edgeInsets,
      @required this.textEditingController,
      this.onChange,
      this.onChangeTitle,
      this.onRemove})
      : super(key: key);

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  TextEditingController affirmationTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<String> _showAffirmationCategoryDialog(BuildContext context) async {
      return await showDialog(
          context: context,
          builder: (context) => const AffirmationCategoryDialog());
    }

    return Container(
      padding: widget.edgeInsets,
      color: Colors.transparent,
      child: Obx(
        () => GestureDetector(
          onTap: () {
            if (!billingService.isVip.value && widget.index >= 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewPaywall(
                          isseting: true,
                        )),
              );
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 70.0,
            decoration: BoxDecoration(
              color: billingService.isVip.value || widget.index < 2
                  ? const Color(0xffECD1EB)
                  : const Color(0xffF4C8E6),
              borderRadius: const BorderRadius.all(Radius.circular(19)),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.menu,
                      color: Color(0xff592F72),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    isproicon(),
                    if (!widget.orderItem.id.contains("custom")) ...[
                      Expanded(
                        child: Text(
                          widget.title ?? "",
                          // textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.VIOLET,
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                    if (widget.orderItem.position == TimerPageId.Fitness) ...[
                      const SizedBox(width: 10),
                      GestureDetector(
                        child: Container(
                          width: 42,
                          height: 42,
                          padding: const EdgeInsets.all(11.7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xffF8EDF7).withOpacity(0.9)),
                          child: Image.asset(
                            'assets/images/seticon.png',
                          ),
                        ),
                        onTap: () {
                          if (!billingService.isVip.value) return;
                          Get.put(FitnessController(
                              repository: FitnessProgramRepositoryImpl()));
                          Get.to(const FitnessProgramSettingsPage());
                        },
                      )
                    ],
                    if (widget.orderItem.position ==
                        TimerPageId.Affirmation) ...[
                      const SizedBox(width: 10),
                      GestureDetector(
                        child: Container(
                          width: 42,
                          height: 42,
                          padding: const EdgeInsets.all(11.7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xffFF8EDF7)),
                          child: Image.asset(
                            'assets/images/seticon.png',
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              insetPadding: null,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaY: 4, sigmaX: 4),
                                      child: Container(
                                          color: Colors.white.withOpacity(.2)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 29),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      height: 460,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: ListView(
                                        // mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 20.0,
                                              ),
                                              const Spacer(),
                                              Text(
                                                'Affirmation Settings'.tr,
                                                style: const TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: AppColors.VIOLET,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              ),
                                              const Spacer(),
                                              GestureDetector(
                                                  onTap: () =>
                                                      Navigator.pop(context),
                                                  child:
                                                      const Icon(Icons.close)),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 10, right: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  color: const Color.fromRGBO(
                                                      89, 47, 114, 0.05)),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: AffirmationTextField(
                                                    affirmationTextController:
                                                        affirmationTextController),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'or'.tr,
                                            style: const TextStyle(
                                              color: Color(0xff5F3777),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Container(
                                              height: 70,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(19),
                                                  color: Colors.white),
                                              child: InkWell(
                                                onTap: () async {
                                                  String _affirmationText =
                                                      await _showAffirmationCategoryDialog(
                                                          context);
                                                  if (_affirmationText !=
                                                      null) {
                                                    setState(() {
                                                      affirmationTextController
                                                              .text =
                                                          _affirmationText;
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8, top: 5),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Center(
                                                    child: Text(
                                                        'choose_ready'.tr,
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xff5F3777),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                myDbBox.put(
                                                    MyResource
                                                        .AFFIRMATION_TEXT_KEY,
                                                    AffirmationText(
                                                        affirmationTextController
                                                            .text));
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: 70,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            19),
                                                    color:
                                                        const Color(0xff592F72),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors
                                                              .grey.shade600,
                                                          spreadRadius: 1,
                                                          blurRadius: 30)
                                                    ]),
                                                child: Center(
                                                    child: Text(
                                                  'Save the Affirmation'.tr,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                    if (widget.orderItem.id.contains("custom")) ...[
                      Expanded(
                        child: TextField(
                          enabled: billingService.isPro(),
                          controller: TextEditingController(
                              text: MyDB()
                                      .getBox()
                                      .get(widget.orderItem.id)
                                      .title ??
                                  ""),
                          onChanged: (value) => widget.onChangeTitle(value),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          cursorColor: AppColors.VIOLET,
                          style: const TextStyle(
                              color: AppColors.VIOLET,
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Montserrat'),
                          //textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width / 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(bottom: 3, top: 3),
                            child: Text(
                              'min'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Get.width * .025,
                                  fontStyle: FontStyle.normal,
                                  color: AppColors.VIOLET,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                          Container(
                            width: 64,
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: _buildMinutesTextInput(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Visibility(
                  visible: widget.orderItem.id.contains("custom"),
                  child: Positioned(
                    right: -3,
                    child: IconButton(
                      onPressed: () => widget.onRemove(),
                      icon: const Icon(Icons.close),
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget isproicon() {
    return !billingService.isVip.value && widget.index >= 2
        ? Row(
            children: [
              SvgPicture.asset(
                'assets/images/home_menu/crown.svg',
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          )
        : Container();
  }

  Widget _buildMinutesTextInput() {
    return Obx(() {
      var isVip = billingService.isVip.value;
      print('isVip from exerciseTile: $isVip');
      return TextField(
        onChanged: (value) => widget.onChange(value),
        controller: widget.textEditingController,
        minLines: 1,
        maxLines: 1,
        cursorColor: AppColors.VIOLET,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.center,
        enabled: isVip || widget.index < 2,
        decoration: InputDecoration(
            filled: true,
            contentPadding: const EdgeInsets.all(6),
            isDense: true,
            fillColor: Colors.white.withOpacity(0.9),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(8)))),
        style: TextStyle(
            fontSize: Get.width * .04,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            color: AppColors.VIOLET,
            decoration: TextDecoration.none),
      );
    });
  }
}
