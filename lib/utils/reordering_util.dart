import 'package:flutter/material.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/features/fitness/presentation/pages/fitness_main_page.dart';
import 'package:morningmagic/pages/Reclama.dart';
import 'package:morningmagic/storage.dart';

import '../db/model/reordering_program/order_holder.dart';
import '../db/model/reordering_program/order_item.dart';
import '../db/resource.dart';
import '../pages/askedQuestionsScreen.dart';
import '../pages/exerciseStartPage.dart';
import '../pages/screenVizualization.dart';
import '../pages/screenVocabulary.dart';
import '../pages/timerPage.dart';
import '../widgets/exerciseTile.dart';

class OrderUtil {
  Future<OrderHolder> getOrderHolder() async {
    OrderHolder orderHolder;
    orderHolder = await MyDB().getBox().get(MyResource.ORDER_PROGRAM_HOLDER,
        defaultValue: createDefaultHolder());
    return orderHolder;
  }

  Future<void> saveOrderHolder(List<ExerciseTile> exerciseList) async {
    List<OrderItem> orderItemsList = List<OrderItem>();
    for (int i = 0; i < exerciseList.length; i++) {
      orderItemsList.add(OrderItem(exerciseList[i].id));
    }
    OrderHolder orderHolder = OrderHolder(orderItemsList);
    await MyDB().getBox().put(MyResource.ORDER_PROGRAM_HOLDER, orderHolder);
  }

  OrderHolder createDefaultHolder() {
    OrderItem orderAffirmation = new OrderItem(0);
    OrderItem orderMeditation = new OrderItem(1);
    OrderItem orderFitness = new OrderItem(2);
    OrderItem orderDiary = new OrderItem(3);
    OrderItem orderReading = new OrderItem(4);
    OrderItem orderVisualization = new OrderItem(5);

    List<OrderItem> list = new List();
    list.add(orderMeditation);
    list.add(orderAffirmation);
    list.add(orderFitness);
    list.add(orderDiary);
    list.add(orderReading);
    list.add(orderVisualization);

    return new OrderHolder(list);
  }

  String getStringIdByOrderId(int id) {
    if (id == 0) {
      return "affirmation_small";
    } else if (id == 1) {
      return "meditation_small";
    } else if (id == 2) {
      return "fitness_small";
    } else if (id == 3) {
      return "diary_small";
    } else if (id == 4) {
      return "reading_small";
    } else {
      return "visualization_small";
    }
  }

  Future<MaterialPageRoute> getRouteByPositionInList(int position) async {
    OrderHolder orderHolder = await getOrderHolder();

    OrderItem orderItem = orderHolder.list[position];
    int id = orderItem.position;
    print('Open id: $id');

    if (!billingService.isPro() && (id != 0 && id != 1)) {
      print('!isPro && (id!=0 || id!=1)');
      return MaterialPageRoute(builder: (context) => Reclama());
    }

    if (id == 2)
      return MaterialPageRoute(
          builder: (context) => FitnessMainPage(pageId: id));
    if (id == 3)
      return MaterialPageRoute(builder: (context) => VocabularyScreen());
    if (id == 5)
      return MaterialPageRoute(builder: (context) => VisualizationScreen());

    String expName = this.getExpirienceName(id);
    print('Exp name: $expName');
    return MaterialPageRoute(
        builder: (context) => ExerciseStartPage(
            pageId: id,
            title: expName,
            desc: '${expName}_title',
            btnNext: () => MaterialPageRoute(
                builder: (context) => TimerPage(pageId: id))));
  }

  getExpirienceName(int id) {
    switch (id) {
      case 0:
        return 'affirmation';
      case 1:
        return 'meditation';
      case 2:
        return 'fitness';
      case 3:
        return 'diary';
      case 4:
        return 'reading';
      case 5:
        return 'visualization';
      default:
        return 'visualization';
    }
  }

  Future<MaterialPageRoute> getRouteById(int id) async {
    int currentProgramPosition = await getPositionById(id);
    print('currentPage = $currentProgramPosition');
    currentProgramPosition = currentProgramPosition + 1;
    print('nextPage = $currentProgramPosition');
    if (currentProgramPosition == 6) {
      return MaterialPageRoute(builder: (context) => AskedQuestionsScreen());
    } else {
      return getRouteByPositionInList(currentProgramPosition);
    }
  }

  Future<int> getPositionById(int id) async {
    OrderHolder orderHolder = await getOrderHolder();
    int position;
    for (int i = 0; i < orderHolder.list.length; i++) {
      if (orderHolder.list[i].position == id) {
        position = i;
        break;
      }
    }
    return position;
  }
}
