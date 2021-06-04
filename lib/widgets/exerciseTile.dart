import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:morningmagic/db/model/reordering_program/order_item.dart';
import 'package:morningmagic/features/fitness/data/repositories/fitness_program_repository_impl.dart';
import 'package:morningmagic/features/fitness/presentation/controller/fitness_controller.dart';
import 'package:morningmagic/features/fitness/presentation/pages/fitness_program_settings.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/storage.dart';

class ExerciseTile extends StatelessWidget {
  final int index;
  final List<OrderItem> orderItemList;
  final String title;
  final EdgeInsets edgeInsets;
  final TextEditingController textEditingController;

  const ExerciseTile(
      {Key key,
      @required this.index,
      @required this.orderItemList,
      @required this.title,
      @required this.edgeInsets,
      @required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgeInsets,
      child: Obx(
        () => Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: billingService.isVip.value || index < 2
                ? AppColors.TRANSPARENT_WHITE
                : AppColors.TRANSPARENTS,
            borderRadius: BorderRadius.all(Radius.circular(45)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const SizedBox(width: 20),
              orderItemList[index].position == TimerPageId.Fitness
                  ? GestureDetector(
                      child: Icon(
                        Icons.settings,
                        color: !billingService.isVip.value
                            ? Colors.black45
                            : Colors.black,
                      ),
                      onTap: () {
                        if (!billingService.isVip.value) return;
                        Get.put(FitnessController(
                            repository: FitnessProgramRepositoryImpl()));
                        Get.to(FitnessProgramSettingsPage());
                      },
                    )
                  : const SizedBox(width: 20),
              Expanded(
                  child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.VIOLET,
                    fontSize: 20,
                    fontStyle: FontStyle.normal),
              )),
              Container(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width / 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 3, top: 3),
                      child: Text(
                        'min'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 11,
                            fontStyle: FontStyle.normal,
                            color: AppColors.VIOLET,
                            decoration: TextDecoration.none),
                      ),
                    ),
                    Container(
                      width: 64,
                      padding: EdgeInsets.only(bottom: 8),
                      child: _buildMinutesTextInput(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMinutesTextInput() {
    return Obx(() {
      var isVip = billingService.isVip.value;
      print('isVip from exerciseTile: $isVip');
      return TextField(
        controller: textEditingController,
        minLines: 1,
        maxLines: 1,
        cursorColor: AppColors.VIOLET,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.center,
        enabled: isVip || index < 2,
        decoration: InputDecoration(
            filled: true,
            contentPadding: EdgeInsets.all(6),
            isDense: true,
            fillColor:
                isVip ? AppColors.TRANSPARENT_WHITE : AppColors.TRANSPARENTS,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.VIOLET),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.CREAM),
                borderRadius: BorderRadius.all(Radius.circular(8)))),
        style: TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.normal,
            color: AppColors.VIOLET,
            decoration: TextDecoration.none),
      );
    });
  }
}
