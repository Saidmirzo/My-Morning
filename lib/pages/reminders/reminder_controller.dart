import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/reminders/components/add_text.dart';
import 'package:morningmagic/pages/reminders/models/reminder.dart';
import 'package:morningmagic/services/notifications.dart';

import 'components/add_time.dart';

class ReminderController extends GetxController {
  // Список сохраненных напоминания
  var reminders = RxList<ReminderModel>().obs;
  // Выбранное время
  TimeOfDay selectedTime;
  // Дни недели (обнулить после добавления)
  var activeDays = RxList<int>().obs;

  @override
  void onInit() {
    readRemindersFromDb();
    super.onInit();
  }

  readRemindersFromDb() async {
    print('Подгружаем список уведомлений');
    var ll =
        await MyDB().getBox().get(MyResource.My_Reminders, defaultValue: []);
    for (var item in ll) {
      reminders.value.add(item);
    }
  }

  void addReminder() async {
    activeDays.value.clear();
    // Выбор дней недели и времени
    await Get.dialog(AddTimeDialog());
    // Если время не выбрал пропустим
    if (selectedTime == null) return;

    String _text = await Get.dialog(AddTextReminder());

    List<int> _ll = [];
    // Перед добавлением переносим в обычный список,
    // иначе Rx заменит и предыдущие данные
    _ll.addAll(activeDays.value);
    // Теперь можно добавить
    reminders.value.add(
      ReminderModel(
        id: (reminders.value.length > 0 ? reminders.value.last.id : 0) + 1,
        date: getStartDate(),
        text: _text ?? 'reminders'.tr,
        activeDays: _ll,
      ),
    );

    addAllPush(reminders.value.last);

    save();
  }

  List<DateTime> getStartDates(DateTime _date) {
    // Ищем следующий ближайший день в качестве стартовой даты
    // (под каждый выбранный день недели)
    List<DateTime> _startDates = [];
    int _weekday = DateTime.now().weekday;
    activeDays.value.forEach((element) {
      int _days = 0;
      if (element < _weekday)
        _days = _weekday + element + 1;
      else
        _days = element - _weekday;
      _startDates.add(_date.add(_days.days));
    });
    return _startDates;
  }

  DateTime getStartDate({DateTime startDate}) {
    DateTime _selectedDate = startDate ?? DateTime.now();
    var newDateTime = new DateTime(_selectedDate.year, _selectedDate.month,
        _selectedDate.day, selectedTime.hour, selectedTime.minute, 0, 0, 0);
    print('newDate: $newDateTime');
    return newDateTime;
  }

  void addAllPush(ReminderModel _reminder) {
    var _dates = getStartDates(getStartDate(startDate: _reminder.date));
    _dates.forEach((element) {
      pushNotifications.sendWeekleRepeat(
          'reminders'.tr, _reminder.text, element);
    });
  }

  void removeReminder(ReminderModel _reminder) {
    reminders.value.remove(_reminder);
    pushNotifications.deleteNotification(_reminder.id);
    save();
  }

  void setActive(ReminderModel _reminder, bool value) {
    _reminder.isActive = value;
    value
        ? addAllPush(_reminder)
        : pushNotifications.deleteNotification(_reminder.id);
    reminders.refresh();
    save();
  }

  void save() async {
    await MyDB().getBox().put(MyResource.My_Reminders, reminders.value);
  }
}
