import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
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

  int getLastPushId() {
    return MyDB().getBox().get(MyResource.Last_Push_Id, defaultValue: 1);
  }

  void saveLastPushId(int _id) {
    MyDB().getBox().put(MyResource.Last_Push_Id, _id);
  }

  void addReminder(
      {Function onAction,
      bool activeAllDaysByDefault = false,
      TimeOfDay timeOfDay}) async {
    activeDays.value.clear();
    if (activeAllDaysByDefault) {
      for (var i = 1; i <= 7; i++) {
        activeDays.value.add(i);
      }
    }
    // Выбор дней недели и времени
    await Get.dialog(AddTimeDialog(initTime: timeOfDay));
    // Если время не выбрал пропустим
    if (selectedTime == null) return;

    // String _text = await Get.dialog(AddTextReminder());

    // Последний ид который был использован
    int lastPushId = getLastPushId() + 1;
    List<int> _ll = [];
    // Перед добавлением переносим в обычный список,
    // иначе Rx заменит и предыдущие данные
    _ll.addAll(activeDays.value);
    // Теперь можно добавить
    reminders.value.add(
      ReminderModel(
        id: lastPushId,
        date: getStartDate(time: selectedTime),
        text: 'reminders'.tr,
        activeDays: _ll,
      ),
    );

    addAllPush(reminders.value.last);

    save();
    if (onAction != null) onAction();
  }

  List<DateTime> getStartDates(DateTime _date, List<int> _activeDays) {
    // Ищем следующий ближайший день в качестве стартовой даты
    // (под каждый выбранный день недели)
    List<DateTime> _startDates = [];
    int _weekday = DateTime.now().weekday;
    for (var element in _activeDays) {
      int _days = 0;
      if (element < _weekday) {
        _days = _weekday + element + 1;
      } else {
        _days = element - _weekday;
      }
      _startDates.add(_date.add(_days.days));
    }
    return _startDates;
  }

  DateTime getStartDate({DateTime startDate, TimeOfDay time}) {
    DateTime _selectedDate = startDate ?? DateTime.now();
    var newDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      time.hour,
      time.minute,
      0,
      0,
      0,
    );
    print('newDate: $newDateTime');
    return newDateTime;
  }

  void addAllPush(ReminderModel _reminder) {
    var _dates = getStartDates(
      getStartDate(
          startDate: _reminder.date,
          time: TimeOfDay(
              hour: _reminder.date.hour, minute: _reminder.date.minute)),
      _reminder.activeDays,
    );
    for (var i = 0; i < _dates.length; i++) {
      pushNotifications.sendWeekleRepeat(
        'reminders'.tr,
        _reminder.text,
        _dates[i],
        id: _reminder.id + i,
      );
    }
    saveLastPushId(_reminder.id + _dates.length);
  }

  void removeReminder(ReminderModel _reminder) {
    reminders.value.remove(_reminder);
    disablePush(_reminder);
    save();
  }

  void setActive(ReminderModel _reminder, bool value) {
    _reminder.isActive = value;
    reminders.refresh();
    value ? addAllPush(_reminder) : disablePush(_reminder);
    save();
  }

  void disablePush(ReminderModel _reminder) {
    for (var i = 0; i < _reminder.activeDays.length; i++) {
      pushNotifications.deleteNotification(_reminder.id + i);
    }
  }

  void save() async {
    await MyDB().getBox().put(MyResource.My_Reminders, reminders.value);
  }
}
