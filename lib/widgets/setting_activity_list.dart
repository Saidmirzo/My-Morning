import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/model/reordering_program/order_item.dart';
import 'package:morningmagic/pages/settings/settings_controller.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:reorderables/reorderables.dart';

import 'exerciseTile.dart';

class SettingsActivityList extends StatefulWidget {
  final TextEditingController affirmationTimeController;
  final TextEditingController meditationTimeController;
  final TextEditingController fitnessTimeController;
  final TextEditingController vocabularyTimeController;
  final TextEditingController readingTimeController;
  final TextEditingController visualizationTimeController;
  final bool needReInit;

  SettingsActivityList(
      this.affirmationTimeController,
      this.meditationTimeController,
      this.fitnessTimeController,
      this.vocabularyTimeController,
      this.readingTimeController,
      this.visualizationTimeController,
      this.needReInit);

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
    initList();
  }

  @override
  Widget build(BuildContext context) {
    print('NeedReinit : ${widget.needReInit}');
    print('HasReinit : ${hasReInit}');
    if (!hasReInit && widget.needReInit) {
      hasReInit = true;
      initList();
    }
    print('Build wrapTable');
    return ReorderableSliverList(
      delegate: ReorderableSliverChildListDelegate(_itemRows),
      onReorder: _onReorder,
    );
  }

  initList() {
    OrderUtil().getOrderHolder().then((value) {
      setState(() {
        _itemRows = createListOfWidgets(value.list);
        print('Init wrap list');
      });
    });
  }

  List<ExerciseTile> createListOfWidgets(List<OrderItem> orderItemsList) {
    List<ExerciseTile> list = [];

    calculateNewTime();

    list = List.generate(
      6,
      (index) => ExerciseTile(
        key: ValueKey(index),
        index: index,
        orderItemList: orderItemsList,
        title:
            OrderUtil().getStringIdByOrderId(orderItemsList[index].position).tr,
        edgeInsets: EdgeInsets.only(bottom: 15),
        textEditingController:
            getControllerById(orderItemsList[index].position),
      ),
    );

    return list;
  }

  TextEditingController getControllerById(int id) {
    if (id == 0) {
      return widget.meditationTimeController;
    } else if (id == 1) {
      return widget.affirmationTimeController;
    } else if (id == 2) {
      return widget.fitnessTimeController;
    } else if (id == 3) {
      return widget.vocabularyTimeController;
    } else if (id == 4) {
      return widget.readingTimeController;
    } else {
      return widget.visualizationTimeController;
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (billingService.isPro() ||
        (oldIndex == 0 && newIndex == 1) ||
        (oldIndex == 1 && newIndex == 0)) {
      setState(() {
        Widget row = _itemRows.removeAt(oldIndex);
        _itemRows.insert(newIndex, row);
      });
      OrderUtil().saveOrderHolder(_itemRows).then((value) {
        print("REORDERING SAVED !!!");
      });
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

  // String getAndCalculateTime() {
  //   ExerciseTime affirmation = MyDB()
  //       .getBox()
  //       .get(MyResource.AFFIRMATION_TIME_KEY, defaultValue: ExerciseTime(3));
  //   int affirmation_time = affirmation.time;

  //   ExerciseTime meditation = MyDB()
  //       .getBox()
  //       .get(MyResource.MEDITATION_TIME_KEY, defaultValue: ExerciseTime(3));
  //   int meditation_time = meditation.time;

  //   ExerciseTime fitness = MyDB()
  //       .getBox()
  //       .get(MyResource.FITNESS_TIME_KEY, defaultValue: ExerciseTime(3));
  //   int fitness_time = fitness.time;

  //   ExerciseTime vocabulary = MyDB()
  //       .getBox()
  //       .get(MyResource.VOCABULARY_TIME_KEY, defaultValue: ExerciseTime(3));
  //   int vocabulary_time = vocabulary.time;

  //   ExerciseTime reading = MyDB()
  //       .getBox()
  //       .get(MyResource.READING_TIME_KEY, defaultValue: ExerciseTime(3));
  //   int reading_time = reading.time;

  //   ExerciseTime visualization = MyDB()
  //       .getBox()
  //       .get(MyResource.VISUALIZATION_TIME_KEY, defaultValue: ExerciseTime(3));
  //   int visualization_time = visualization.time;

  //   int sum = affirmation_time +
  //       meditation_time +
  //       fitness_time +
  //       vocabulary_time +
  //       reading_time +
  //       visualization_time;

  //   return 'x_minutes'.trParams({'x': sum.toString()});
  // }
}
