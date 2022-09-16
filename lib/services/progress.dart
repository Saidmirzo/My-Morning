import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/progress/fitness_porgress/fitness_progress.dart';
import 'package:morningmagic/db/resource.dart';

class ProgressController extends GetxController {
  static final DateFormat dtFormat = DateFormat('d.M.y');
  static const int minPassedSec = 15;

  Map<String, dynamic> diary = {};
  Map<String, List<dynamic>> affirmation = {};
  Map<String, List<dynamic>> meditation = {};
  Map<String, List<dynamic>> fittness = {};
  Map<String, List<dynamic>> reading = {};
  Map<String, List<dynamic>> visualizations = {};
  Map<String, List<dynamic>> fullComplex = {};

  void saveJournal(String journal, dynamic pgModel) {
    print('ProgressController saveJournal $journal');
    // Получаем старые данные
    var _map = MyDB().getJournalProgress(journal);
    // Текущая дата и время в нужном формате
    final _now = dtFormat.format(DateTime.now());
    if (_map[_now] == null) _map[_now] = [];
    // Добавляем в запись в журнал
    _map[_now].add(pgModel);
    // Сохраняем
    myDbBox.put(journal, _map);
  }

  // Дневник сохраняем в другом формате
  // У каждого DateTime свой объект
  void saveDiaryJournal(dynamic pgModel) {
    print('ProgressController saveDiaryJournal');
    // Получаем старые данные
    var _map = MyDB().getDiaryProgress();
    // Текущая дата и время в нужном формате
    final _now = DateTime.now().toString();
    // Добавляем в запись в журнал
    _map[_now] = pgModel;
    // Сохраняем
    myDbBox.put(MyResource.DIARY_JOURNAL, _map);
  }

  void loadJournals() {
    diary = MyDB().getDiaryProgress();
    affirmation = MyDB().getJournalProgress(MyResource.AFFIRMATION_JOURNAL);
    meditation = MyDB().getJournalProgress(MyResource.MEDITATION_JOURNAL);
    fittness = MyDB().getJournalProgress(MyResource.FITNESS_JOURNAL);
    reading = MyDB().getJournalProgress(MyResource.READING_JOURNAL);
    visualizations =
        MyDB().getJournalProgress(MyResource.VISUALISATION_JOURNAL);
    fullComplex = MyDB().getJournalProgress(MyResource.FULL_COMPLEX_FINISH);
  }

  // Количество минут за конкретный день
  int minutesPerDay(DateTime _date) {
    double sec = 0;
    diary.forEach((key, value) {
      var date = DateTime.parse(key);
      var dt = DateTime(date.year, date.month, date.day);
      if (dt == _date) sec += diary[key].sec;
    });
    sec += calculateMinPerDay(affirmation, _date);
    sec += calculateMinPerDay(meditation, _date);
    sec += calculateMinPerDay(fittness, _date);
    sec += calculateMinPerDay(reading, _date);
    sec += calculateMinPerDay(visualizations, _date);
    return (sec / 60).round();
  }

  // Все журналы, кроме дневника, повторяются по структуре,
  // по этому вынес в эту функцию, она используется в minutesPerDay()
  int calculateMinPerDay(Map<String, List<dynamic>> _map, DateTime _date) {
    int sec = 0;
    _map.forEach((key, value) {
      var dt = DateFormat('d.M.yyyy').format(_date);
      if (dt == key) {
        for (var element in value) {
          sec = sec + element.sec;
        }
      }
    });
    return sec;
  }

  // Измеритель осознанности за месяц
  double percentOfAwareness(DateTime _date) {
    var arr = [affirmation, meditation, fittness, reading, visualizations];
    var _start = DateTime(_date.year, _date.month);
    var _end = DateTime(_date.year, _date.month + 1);
    return statPerPeriod(_start, _end, arr)[2];
  }

  /*
   * 
   * 
   * Кол-во завершенных практик и минут за период
   * 
   * 
   * */

  List<dynamic> calcStatByPeriod(int itogiType) {
    var stat = [];
    var _now = DateTime.now();
    var arr = [affirmation, meditation, fittness, reading, visualizations];
    switch (itogiType) {
      case 1:
        // Стартовую дату берем 99 лет назад
        var x = DateTime.now().add(const Duration(days: -(365 * 99)));
        var _start = DateTime(x.year, x.month, x.day - 1);
        var _end = DateTime(_now.year, _now.month, _now.day + 1);
        stat = statPerPeriod(_start, _end, arr);
        break;
      case 2:
        var _start = DateTime(_now.year, _now.month);
        var _end = DateTime(_now.year, _now.month + 1);
        stat = statPerPeriod(_start, _end, arr);
        break;
      case 3:
        var _start = DateTime(_now.year);
        var _end = DateTime(_now.year + 1);
        stat = statPerPeriod(_start, _end, arr);
        break;
    }
    return stat;
  }

  // Число парктик за период ч выбранном журнале
  // Если упражнение не пропущено, значит оно завершено)))
  List<dynamic> statPerPeriod(
      DateTime start, DateTime end, List<Map<String, List<dynamic>>> _list) {
    int count = 0;
    double sec = 0;
    double percent = 0.0;
    for (var element in _list) {
      element.forEach((key, value) {
        var dtKey = DateFormat('d.M.yyyy').parse(key);
        if ((dtKey.isAfter(start) && dtKey.isBefore(end)) ||
            (dtKey == start || dtKey == end)) {
          String oldPracticId;
          for (var element in value) {
            if (element is FitnessProgress) {
              try {
                // Для фитнеса группируем по названию программы
                print('fittnesProgram !isSkip ${!element.isSkip}');
                // if (element.practicId == null) continue;
                if (oldPracticId == null ||
                    !element.practicId.contains(oldPracticId)) {
                  oldPracticId = element.practicId;
                  if (!element.isSkip) {
                    count++;
                  }
                }
              } catch (e) {}
            } else {
              // Для остальных считаем все завершенные
              if (!element.isSkip ?? false) count++;
            }
            sec += element.sec;
            if (!element.isSkip ?? false) {
              percent += 0.5;
            }
          }
        }
      });
    }
    diary.forEach((key, value) {
      var dtKey = DateTime.parse(key);
      if ((dtKey.isAfter(start) && dtKey.isBefore(end)) ||
          (dtKey == start || dtKey == end)) {
        if (!value.isSkip ?? false) count++;
        sec += value.sec;
      }
    });
    return [3, sec / 60, percent];
  }

  /*
   * 
   * 
   * Кол-во полных комплексов
   * 
   * 
   * */

  // И передавать в нее период с какого по какое считаем данные
  int getCountComplex(int itogiType) {
    int count = 0;
    switch (itogiType) {
      case 1:
        fullComplex.forEach((key, value) {
          for (var element in value) {
            count += element;
          }
        });
        break;
      case 2:
        fullComplex.forEach((key, value) {
          var dt = DateFormat.yM().format(DateTime.now());
          var dtKey = DateFormat.yM().format(DateFormat('d.M.yyyy').parse(key));
          if (dt == dtKey) {
            for (var element in value) {
              count += element;
            }
          }
        });
        break;
      case 3:
        fullComplex.forEach((key, value) {
          var dt = DateFormat.y().format(DateTime.now());
          var dtKey = DateFormat.y().format(DateFormat('d.M.yyyy').parse(key));
          if (dt == dtKey) {
            for (var element in value) {
              count += element;
            }
          }
        });
        break;
    }
    return count;
  }
}
