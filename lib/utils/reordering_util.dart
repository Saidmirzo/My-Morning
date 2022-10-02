import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/features/fitness/presentation/pages/fitness_main_page.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_main_page.dart';
import 'package:morningmagic/pages/affirmation/affirmation_page.dart';
import 'package:morningmagic/pages/custom_methodic/custom_methodic_start_page.dart';
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
    print(orderHolder);
    return orderHolder;
  }

  Future<void> saveOrderHolder(List<ExerciseTile> exerciseList) async {
    List<OrderItem> orderItemsList = [];
    for (int i = 0; i < exerciseList.length; i++) {
      orderItemsList.add(OrderItem(
          exerciseList[i].orderItem.position, exerciseList[i].orderItem.id));
      print('save: ${exerciseList[i].title}');
    }
    OrderHolder orderHolder = OrderHolder(orderItemsList);
    await MyDB().getBox().put(MyResource.ORDER_PROGRAM_HOLDER, orderHolder);
  }

  Future<void> addOrderHolder(List<OrderItem> items) async {
    OrderHolder orderHolder = OrderHolder(items);
    await MyDB().getBox().put(MyResource.ORDER_PROGRAM_HOLDER, orderHolder);
  }

  Future<void> removeOrderHolder(List<OrderItem> items) async {
    OrderHolder orderHolder = OrderHolder(items);
    await MyDB().getBox().put(MyResource.ORDER_PROGRAM_HOLDER, orderHolder);
  }

  OrderHolder createDefaultHolder() {
    OrderItem orderAffirmation = OrderItem(0, getStringIdByOrderId(0));
    OrderItem orderMeditation = OrderItem(1, getStringIdByOrderId(1));
    OrderItem orderFitness = OrderItem(2, getStringIdByOrderId(2));
    OrderItem orderDiary = OrderItem(3, getStringIdByOrderId(3));
    OrderItem orderReading = OrderItem(4, getStringIdByOrderId(4));
    OrderItem orderVisualization = OrderItem(5, getStringIdByOrderId(5));

    List<OrderItem> list = [
      orderMeditation,
      orderAffirmation,
      orderFitness,
      orderVisualization,
      orderReading,
      orderDiary
    ];

    return OrderHolder(list);
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
    } else if (id == TimerPageId.Visualization) {
      return "visualization_small";
    }
  }

  getBoxTimeKey(int pageId) {
    print('getBoxTimeKey: $pageId');
    switch (pageId) {
      case TimerPageId.Affirmation:
        return MyResource.AFFIRMATION_TIME_KEY;
        break;
      case TimerPageId.Meditation:
        return MyResource.MEDITATION_TIME_KEY;
        break;
      case TimerPageId.Fitness:
        return MyResource.FITNESS_TIME_KEY;
        break;
      case TimerPageId.Diary:
        return MyResource.DIARY_TIME_KEY;
        break;
      case TimerPageId.Reading:
        return MyResource.READING_TIME_KEY;
        break;
      case TimerPageId.Visualization:
        return MyResource.VISUALIZATION_TIME_KEY;
        break;
      default:
        return MyResource.VISUALIZATION_TIME_KEY;
    }
  }

  void endComplex(String id) {
    if (id.contains("custom")) {
      AppMetrica.reportEvent('complex_userpractice_end');
    }
    if (id == "affirmation_small") {
      AppMetrica.reportEvent('complex_affirmations_end');
    }
    if (id == "meditation_small") {
      AppMetrica.reportEvent('complex_meditation_end');
    }
    if (id == "fitness_small") {
      AppMetrica.reportEvent('complex_fitness_end');
    }
    if (id == "diary_small") {
      AppMetrica.reportEvent('complex_diary_end');
    }
    if (id == "reading_small") {
      AppMetrica.reportEvent('complex_reading_end');
    }
    if (id == "visualization_small") {
      AppMetrica.reportEvent('complex_visualization_end');
    }
  }

  Future<dynamic> getRouteByPositionInList(int position) async {
    OrderHolder orderHolder = await getOrderHolder();
    if (position > orderHolder.list.length) return const ProgressPage();

    OrderItem orderItem = orderHolder.list[position];
    String id = orderItem.id;
    print('Open id: $id');

    endComplex(orderHolder.list[position].id);

    if (!billingService.isPro() && ![0, 1].contains(orderItem.position)) {
      print('!isPro && ![0,1].contains(id)');
      return Get.to(() => PaywallPage());
    }
    if (id.contains("custom")) {
      AppMetrica.reportEvent('complex_userpractice');
      return CustomMethodicStartPage(id: id, pageId: orderItem.position);
    }
    if (id == "affirmation_small") {
      AppMetrica.reportEvent('complex_affirmations');
      return const AffirmationPage();
    }
    if (id == "meditation_small") {
      AppMetrica.reportEvent('complex_meditation');
      return const MeditationPage();
    }
    if (id == "fitness_small") {
      AppMetrica.reportEvent('complex_fitness');
      return FitnessMainPage(pageId: orderItem.position);
    }
    if (id == "diary_small") {
      AppMetrica.reportEvent('complex_diary');
      return const DiaryPage();
    }
    if (id == "reading_small") {
      AppMetrica.reportEvent('complex_reading');
      return const ReadingPage();
    }
    if (id == "visualization_small") {
      AppMetrica.reportEvent('complex_visualization');
      return const VisualizationMainPage();
    }
  }

  Future<dynamic> getPreviousRouteById(int id) async {
    print('getPreviousRouteById');
    int pos = await getPositionById(id);
    pos--;
    pos = await getPreviousPos(pos);
    if (pos < 0) {
      return const MainMenuPage();
    } else {
      return getRouteByPositionInList(pos);
    }
  }

  Future<dynamic> getRouteById(int id) async {
    if (id == 10 || id == 11 || id == 12) {
      return const ProgressPage();
    }

    OrderHolder orderHolder = await getOrderHolder();
    int pos = await getPositionById(id);
    pos++;
    pos = await getNextPos(pos);
    // var next;
    // if (orderHolder.list[pos].id.contains("custom")) {
    //   next = MyDB().getBox().get(orderHolder.list[pos].id).time;
    // } else {
    //   next = MyDB().getBox().get(getBoxTimeKey(orderHolder.list[pos].position)).time;
    // }
    // print('next time: $next');

    if (pos == orderHolder.list.length) {
      return const ProgressPage(onDone: true);
    } else {
      return getRouteByPositionInList(pos);
    }
  }

  Future<int> getNextPos(int _pos) async {
    OrderHolder orderHolder = await getOrderHolder();
    var pos = _pos;
    if (pos == orderHolder.list.length) return pos;

    for (var i = pos; i <= orderHolder.list.length; i++) {
      print(getBoxTimeKey(orderHolder.list[i].position));
      var time;
      if (orderHolder.list[i].id.contains("custom")) {
        time = MyDB().getBox().get(orderHolder.list[i].id).time;
      } else {
        time = MyDB()
            .getBox()
            .get(getBoxTimeKey(orderHolder.list[i].position))
            .time;
      }
      if (time > 0) {
        pos = i;
        break;
      }
      pos = orderHolder.list.length;
    }
    return pos;
  }

  Future<int> getPreviousPos(int _pos) async {
    OrderHolder orderHolder = await getOrderHolder();
    var pos = _pos;
    for (var i = pos; i >= 0; i--) {
      var time =
          MyDB().getBox().get(getBoxTimeKey(orderHolder.list[i].position)).time;
      print(getBoxTimeKey(orderHolder.list[i].position));
      print(time);
      if (time > 0) {
        pos = i;
        break;
      }
      pos = -1;
    }
    return pos;
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
