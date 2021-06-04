import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/features/fitness/presentation/pages/fitness_main_page.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_main_page.dart';
import 'package:morningmagic/pages/affirmation/affirmation_page.dart';
import 'package:morningmagic/pages/diary/diary_page.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/pages/meditation/meditation_page.dart';
import 'package:morningmagic/pages/paywall_page.dart';
import 'package:morningmagic/pages/progress/progress_page.dart';
import 'package:morningmagic/pages/reading/reading_page.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/storage.dart';

import '../db/model/reordering_program/order_holder.dart';
import '../db/model/reordering_program/order_item.dart';
import '../db/resource.dart';
import '../widgets/exerciseTile.dart';

class OrderUtil {
  Future<OrderHolder> getOrderHolder() async {
    OrderHolder orderHolder;
    orderHolder = await MyDB().getBox().get(MyResource.ORDER_PROGRAM_HOLDER,
        defaultValue: createDefaultHolder());
    return orderHolder;
  }

  Future<void> saveOrderHolder(List<ExerciseTile> exerciseList) async {
    List<OrderItem> orderItemsList = [];
    for (int i = 0; i < exerciseList.length; i++) {
      orderItemsList.add(OrderItem(exerciseList[i].orderItemList[i].position));
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

    List<OrderItem> list = [
      orderMeditation,
      orderAffirmation,
      orderFitness,
      orderVisualization,
      orderReading,
      orderDiary
    ];

    return new OrderHolder(list);
  }

  String getStringIdByOrderId(int id) {
    if (id == TimerPageId.Affirmation) {
      return "affirmation_small";
    } else if (id == TimerPageId.Meditation) {
      return "meditation_small";
    } else if (id == TimerPageId.Fitness) {
      return "fitness_small";
    } else if (id == TimerPageId.Diary) {
      return "diary_small";
    } else if (id == TimerPageId.Reading) {
      return "reading_small";
    } else {
      return "visualization_small";
    }
  }

  Future<dynamic> getRouteByPositionInList(int position) async {
    OrderHolder orderHolder = await getOrderHolder();

    OrderItem orderItem = orderHolder.list[position];
    int id = orderItem.position;
    print('Open id: $id');

    if (!billingService.isPro() && ![0, 1].contains(id)) {
      print('!isPro && ![0,1].contains(id)');
      return Get.to(PaywallPage());
    }
    if (id == TimerPageId.Affirmation) return AffirmationPage();
    if (id == TimerPageId.Meditation) return MeditationPage();
    if (id == TimerPageId.Fitness) return FitnessMainPage(pageId: id);
    if (id == TimerPageId.Diary) return DiaryPage();
    if (id == TimerPageId.Reading) return ReadingPage();
    if (id == TimerPageId.Visualization) return VisualizationMainPage();
  }

  Future<dynamic> getPreviousRouteById(int id) async {
    int currentProgramPosition = await getPositionById(id);
    print('currentPage = $currentProgramPosition');
    currentProgramPosition = currentProgramPosition - 1;
    print('nextPage = $currentProgramPosition');
    if (currentProgramPosition < 0) {
      return MainMenuPage();
    } else {
      return getRouteByPositionInList(currentProgramPosition);
    }
  }

  Future<dynamic> getRouteById(int id) async {
    int currentProgramPosition = await getPositionById(id);
    print('currentPage = $currentProgramPosition');
    currentProgramPosition = currentProgramPosition + 1;
    print('nextPage = $currentProgramPosition');
    if (currentProgramPosition == 6) {
      return ProgressPage();
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
