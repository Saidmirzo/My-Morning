import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:morningmagic/db/model/reordering_program/order_item.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:reorderables/reorderables.dart';

import 'exerciseTile.dart';

class WrapTable extends StatefulWidget {
  final TextEditingController affirmationTimeController;
  final TextEditingController meditationTimeController;
  final TextEditingController fitnessTimeController;
  final TextEditingController vocabularyTimeController;
  final TextEditingController readingTimeController;
  final TextEditingController visualizationTimeController;
  final bool needReinit;
  // Обновили после покупки
  bool hasReinit = false;

  WrapTable(
      this.affirmationTimeController,
      this.meditationTimeController,
      this.fitnessTimeController,
      this.vocabularyTimeController,
      this.readingTimeController,
      this.visualizationTimeController,
      this.needReinit);

  @override
  State createState() => WrapTableState();
}

class WrapTableState extends State<WrapTable> {
  List<ExerciseTile> _itemRows = List();

  @override
  void initState() {
    super.initState();
    initList();
  }

  @override
  Widget build(BuildContext context) {
    print('NeedReinit : ${widget.needReinit}');
    print('HasReinit : ${widget.hasReinit}');
    if (!widget.hasReinit && widget.needReinit) {
      widget.hasReinit = true;
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
    List<ExerciseTile> list = new List<ExerciseTile>();
    bool isPro = billingService.isPro();

    list.add(ExerciseTile(
      key: ValueKey(1),
      id: orderItemsList[0].position,
      trues: true,
      title: OrderUtil().getStringIdByOrderId(orderItemsList[0].position).tr(),
      edgeInsets: EdgeInsets.only(bottom: 15),
      textEditingController: getControllerById(orderItemsList[0].position),
    ));
    list.add(ExerciseTile(
      key: ValueKey(2),
      id: orderItemsList[1].position,
      trues: true,
      title: OrderUtil().getStringIdByOrderId(orderItemsList[1].position).tr(),
      edgeInsets: EdgeInsets.only(bottom: 15),
      textEditingController: getControllerById(orderItemsList[1].position),
    ));
    list.add(ExerciseTile(
      key: ValueKey(3),
      id: orderItemsList[2].position,
      trues: isPro,
      title: OrderUtil().getStringIdByOrderId(orderItemsList[2].position).tr(),
      edgeInsets: EdgeInsets.only(bottom: 15),
      textEditingController: getControllerById(orderItemsList[2].position),
    ));
    list.add(ExerciseTile(
      key: ValueKey(4),
      id: orderItemsList[3].position,
      trues: isPro,
      title: OrderUtil().getStringIdByOrderId(orderItemsList[3].position).tr(),
      edgeInsets: EdgeInsets.only(bottom: 15),
      textEditingController: getControllerById(orderItemsList[3].position),
    ));
    list.add(ExerciseTile(
      key: ValueKey(5),
      id: orderItemsList[4].position,
      trues: isPro,
      title: OrderUtil().getStringIdByOrderId(orderItemsList[4].position).tr(),
      edgeInsets: EdgeInsets.only(bottom: 15),
      textEditingController: getControllerById(orderItemsList[4].position),
    ));
    list.add(ExerciseTile(
      key: ValueKey(6),
      id: orderItemsList[5].position,
      trues: isPro,
      title: OrderUtil().getStringIdByOrderId(orderItemsList[5].position).tr(),
      edgeInsets: EdgeInsets.only(bottom: 15),
      textEditingController: getControllerById(orderItemsList[5].position),
    ));

    return list;
  }

  TextEditingController getControllerById(int id) {
    if (id == 0) {
      return widget.affirmationTimeController;
    } else if (id == 1) {
      return widget.meditationTimeController;
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

  List<OrderItem> reGenerateList(List<ExerciseTile> exerciseList) {
    List<OrderItem> orderItemsList = List<OrderItem>();
    for (int i = 0; i < exerciseList.length; i++) {
      orderItemsList.add(OrderItem(exerciseList[i].id));
    }
    return orderItemsList;
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (billingService.isPro()) {
      setState(() {
        Widget row = _itemRows.removeAt(oldIndex);
        _itemRows.insert(newIndex, row);
      });
      OrderUtil().saveOrderHolder(_itemRows).then((value) {
        print("REORDERING SAVED !!!");
      });
    }
  }
}
