import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/reordering_program/order_holder.dart';
import 'package:morningmagic/db/model/reordering_program/order_item.dart';
import 'package:morningmagic/pages/settings/settings_controller.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:reorderables/reorderables.dart';
import '../pages/paywall/new_paywall.dart';
import 'exerciseTile.dart';

class SettingsActivityList extends StatefulWidget {
  final TextEditingController affirmationTimeController;
  final TextEditingController meditationTimeController;
  final TextEditingController fitnessTimeController;
  final TextEditingController vocabularyTimeController;
  final TextEditingController readingTimeController;
  final TextEditingController visualizationTimeController;

  const SettingsActivityList(
      this.affirmationTimeController,
      this.meditationTimeController,
      this.fitnessTimeController,
      this.vocabularyTimeController,
      this.readingTimeController,
      this.visualizationTimeController);

  @override
  State createState() => SettingsActivityListState();
}

class SettingsActivityListState extends State<SettingsActivityList> {
  List<ExerciseTile> _itemRows = [];
  bool hasReInit = false;
  SettingsController settingsController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Build wrapTable');
    return FutureBuilder(
      future: OrderUtil().getOrderHolder(),
      builder: (context, AsyncSnapshot<OrderHolder> snapshot) {
        if (!snapshot.hasData) return const SliverToBoxAdapter();
        _itemRows = createListOfWidgets(snapshot.data.list);
        return ReorderableSliverList(
          delegate: ReorderableSliverChildListDelegate(_itemRows),
          onReorder: _onReorder,
          buildDraggableFeedback: (ctx, cons, child) {
            return Material(
              color: Colors.transparent,
              child: Container(
                constraints: cons,
                height: 90,
                color: Colors.transparent,
                child: child,
              ),
            );
          },
        );
      },
    );
  }

  List<ExerciseTile> createListOfWidgets(List<OrderItem> orderItemsList) {
    List<ExerciseTile> list = [];

    calculateNewTime();

    var test = MyDB().getBox().get("custom_time1");

    list = List.generate(
      orderItemsList.length,
      (index) {
        print(orderItemsList[index].id);
        return ExerciseTile(
          onChange: (value) async {
            if (orderItemsList[index].id.contains("custom")) {
              await MyDB().getBox().put(
                  orderItemsList[index].id,
                  ExerciseTime(int.parse(value),
                      title:
                          MyDB().getBox().get(orderItemsList[index].id).title ??
                              ""));
              return;
            }
            calculateNewTime();
          },
          onChangeTitle: (value) async {
            if (value.isEmpty) return;
            await MyDB().getBox().put(
                orderItemsList[index].id,
                ExerciseTime(MyDB().getBox().get(orderItemsList[index].id).time,
                    title: value));
          },
          onRemove: () async {
            await MyDB().getBox().delete(orderItemsList[index].id);
            orderItemsList.removeAt(index);
            await OrderUtil().removeOrderHolder(orderItemsList);
            setState(() {});
          },
          key: ValueKey(index + 1),
          index: index,
          orderItem: orderItemsList[index],
          title: OrderUtil()
              .getStringIdByOrderId(orderItemsList[index].position)
              .tr,
          edgeInsets: const EdgeInsets.only(bottom: 15),
          textEditingController: orderItemsList[index].id.contains("custom")
              ? TextEditingController(
                  text: MyDB()
                      .getBox()
                      .get(orderItemsList[index].id)
                      .time
                      .toString())
              : getControllerById(orderItemsList[index].position),
        );
      },
    );

    return list;
  }

  TextEditingController getControllerById(int id) {
    switch (id) {
      case 0:
        return widget.meditationTimeController;
      case 1:
        return widget.affirmationTimeController;
      case 2:
        return widget.fitnessTimeController;
      case 3:
        return widget.vocabularyTimeController;
      case 4:
        return widget.readingTimeController;
      default:
        return widget.visualizationTimeController;
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (billingService.isVip.value ||
        (oldIndex == 0 && newIndex == 1) ||
        (oldIndex == 1 && newIndex == 0)) {
      AppMetrica.reportEvent('settings_practice_change');
      ExerciseTile row = _itemRows.removeAt(oldIndex);
      _itemRows.insert(newIndex, row);
      print('ЗАПИСЬ УПРАЖНЕНИЙ');
      for (var element in _itemRows) {
        print(element.title);
      }
      OrderUtil().saveOrderHolder(_itemRows).then((value) {
        print("REORDERING SAVED !!!");
        setState(() {});
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewPaywall(
                  isseting: true,
                )),
      );
    }
    calculateNewTime();
  }

  void calculateNewTime() {
    OrderUtil().getOrderHolder().then((value) {
      int time = 0;
      for (var i = 0; i < value.list.length; i++) {
        var val =
            int.tryParse(getControllerById(value.list[i].position).text) ?? 0;
        if (billingService.isPro() || i < 2) time += val;
      }
      settingsController.countAvailableMinutes.value = time;
    });
  }
}
