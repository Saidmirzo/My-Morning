import 'dart:ui';

import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';

class LocalizationService extends Translations {
  static const String LOCALIZATION_KEY = 'localization_key';
  static const String RU = 'ru';
  static const String EN = 'en';

  @override
  Map<String, Map<String, String>> get keys => {
        RU: {
          "start": "Начать",
          "progress_item": "Прогресс",
          "settings": "Настройки",
          "pay": "Купить подписку",
          "store_app": "Магазин",
          "user_is_pro": "Подписка оформлена",
          "upsell_screen": "Предворительная покупка",
          "loading_buy": "Загрузка",
          "loading_buy_app_bar": "Загрузка",
          "start_fitness_my_program": "Начать свою программу",
          "awareness_meter": "Измеритель осознанности",
          "month": "Месяц",
          "year": "Год",
          "save_diary": "Сохранить заметку",
          "total": "Всего",
          "for_week": "За неделю\n",
          "minutes_per_week": "минуты",
          "for_confidence": "На уверенность",
          "for_health": "На здоровье",
          "for_love": "На любовь (ж)",
          "for_success": "На успех",
          "for_career": "На карьеру",
          "for_wealth": "На богатство",
          "monday_short": "пн",
          "tuesday_short": "вт",
          "wednesday_short": "ср",
          "thursday_short": "чт",
          "friday_short": "пт",
          "saturday_short": "сб",
          "sunday_short": "вс",
          "count_of_sessions": "Число\nзавершенных\nпрактик",
          "tutorial_asset": "assets/audios/tutorial_rus.mp3",
          "minutes_of_awareness_with_myself": "Минуты\nединения с\nсобой",
          "count_of_completed_sessions": "Число\nзавершенных\nсеансов",
          "my_diary": "Мой дневник",
          "exercises_note": "Упражнения",
          "visualizations_note": "Визуализация",
          "my_exercises": "Мои упражнения",
          "my_affirmations": "Мои аффирмации",
          "my_books": "Мои книги",
          "my_visualization": "Мои визуализации",
          "choose_ready": "Выбрать готовую",
          "add_note": "Добавить заметку",
          "faq": "FAQ",
          "reading": "ЧТЕНИЕ",
          "reading_title":
              "Займите удобное положение\n и приготовьтесь к прочтению",
          "next_button": "Далее",
          "progress": "ПРОГРЕСС",
          "progress_title": "У Вас еще не было ни одного магического утра",
          "back_button": "Назад",
          "timer": "Таймер",
          "exercise": "Упражнение @id",
          "listen_to": "Прослушать",
          "next_exercise": "Следующее упражнение",
          "program_1": "Заряд бодрости",
          "program_1_ex_1_name": "Наклоны головы вперед-назад",
          "program_1_ex_1_desc":
              "1. Постарайтесь вытянуть шею вверх на сколько возможно и согнуть ее осторожно вперед. \n2. При наклоне назад старайтесь не запрокидывать сильно голову. \n3. Повторяйте по 5 раз в каждую сторону",
          "program_1_ex_2_name": "Вращение головой",
          "program_1_ex_2_desc":
              "1. Полукруг головой слева направо. \n2. 5 раз в каждую сторону",
          "program_1_ex_3_name": "Вращение плечами",
          "program_1_ex_3_desc":
              "1. Вращение плечами вперед и назад \n2. по 5 раз в каждую сторону.",
          "program_1_ex_4_name":
              "Наклоны влево/вправо для растяжки боковой поверхности туловища",
          "program_1_ex_4_desc":
              "1. Станьте ровно, ноги на ширине плеч\n2. Руки вытяните вверх (можно руки собрать в замок), на вдохе наклоняйте туловище вправо, на выдохе возвращайтесь в исходное положение, \n3. На вдохе наклоняйте туловище влево и на вдохе возвращайтесь. \n4.  Сделайте 5 повторений в каждую сторону.",
          "program_1_ex_5_name": "Подъем на носки",
          "program_1_ex_5_desc":
              "1. При подъеме на носки важно не разваливать голеностопный сустав и держать равновесие.\n2. Сделайте 5 повторений",
          "program_1_ex_6_name": "Приседания",
          "program_1_ex_6_desc":
              "1. Приседания делаются без отрыва пяток от пола.\n2. Сделайте 5 повторений",
          "program_2": "Здоровая спина",
          "program_2_ex_1_name": "Повороты головы влево-вправо",
          "program_2_ex_1_desc":
              "1. Главное в этих упражнение – никаких резких движений. \n2. Делать нужно плавно, дыхание ровное. \n3. 5 раз в каждую сторону. ",
          "program_2_ex_2_name": "Наклоны головы вперед-назад",
          "program_2_ex_2_desc":
              "1. Постарайтесь вытянуть шею вверх на сколько возможно и согнуть ее осторожно вперед. \n2. При наклоне назад старайтесь не запрокидывать сильно голову. 5 раз в каждую сторону.",
          "program_2_ex_3_name": "Собака-кошка",
          "program_2_ex_3_desc":
              "1.Встаньте на четвереньки. \n2. Прогните спину, \n3. откинув голову слегка назад, будто вы пытаетесь головой дотянуться до ягодиц. Это поза собаки. \n4. Теперь скруглите спину в области поясницы и опустите голову. Это поза кошки. Чередуйте данные позы медленно и плавно 4-5 раз.",
          "program_2_ex_4_name": "Плечевой мост",
          "program_2_ex_4_desc":
              "1.Это упражнение своеобразный массажер для спины. \n2. Исходно положение лежа спиной на полу, ноги согните в коленях, стопы поставьте на пол. \n3. На вдохе поднимаем туловища, слегка напрягая ягодицы, задерживаемся сверху на пару секунд и на выдохе плавно опускаем туловище в исходное положение, прокатывая каждый позвонок по полу. 4. Сделайте 8 подъемов.",
          "program_2_ex_5_name": "Лодочка",
          "program_2_ex_5_desc":
              "1. Это упражнение заставить работать не только нижнюю часть спины, но и бедра. \n2. Исходное положение лежа на животе, руки вытянуты вперед, \n3. Ноги тянутся назад. \n4. На вдохе одновременно поднимайте руки и ноги, грудь и бедра должны слегка отрываться от пола. \n5. На секунду задержитесь вверху и на выдохе опуститесь в исходное положение. Важно помнить, что в таких упражнениях не должно быть резких движений и рывком. \n6. Голову не запрокидывайте назад, взгляд должен стремиться в пол, чтобы не было лишнего напряжения в шее.",
          "program_2_ex_6_name": "Собака мордой вниз",
          "program_2_ex_6_desc":
              "1. Становимся на четвереньки и обе ладони. \n2. Ноги на ширине плеч. \n3. На вдохе поднимаем ягодицы, выпрямляя ноги. \n4. Стопы должны плотно стоять на полу. \n5. Упражнение в конечной точке представляет треугольник, вершиной которого являются ягодицы. Т\n6. Такое положение нужно удерживать примерно минуту, дыхание при этом свободное и размеренное.",
          "program_3": "Комплекс для ног и ягодиц",
          "program_3_ex_1_name": "Приседания",
          "program_3_ex_1_desc":
              "1. Ноги поставьте шире плеч, \n2. Носки разверните в стороны. \n3. Положение рук может быть инвариантно: за головой, на поясе, впереди, на груди. Главное — чтобы выбранная поза позволяла сохранять равновесие в течение всего упражнения. \n4. Выпрямите спину, начинайте приседать, отводя таз назад. \n5. Ваши колени и носки должны находится на одной параллельной линии. \n6. Голову не опускайте, следите за дыханием: вниз — вдох, вверх — выдох. \n7. Сделайте 3 подхода приседаний по 15 раз.",
          "program_3_ex_2_name": "Выпады вперед",
          "program_3_ex_2_desc":
              "1. Руки уберите на пояс, \n2. выпрямите спину, расправьте плечи. \n3. Голову держите прямо (или немного вверх). \n4. Сделайте шаг вперёд и начните приседать на одно колено. Обратите внимание на переднюю ногу: угол в коленном суставе = 90о, колено и стопа должны находиться на одной параллели. \n5. Поднимаем корпус, перенося центр тяжести на заднюю ногу. Не забываем о дыхании: присед — вдох, исходное положение — выдох. Каждый раз меняем ноги. \n6. Подходы на каждую — 3 раза, количество повторов — 12–15.",
          "program_3_ex_3_name": "Ягодичный мостик",
          "program_3_ex_3_desc":
              "1. Лягте на спину, согните ноги и поставьте ступни чуть шире плеч. \n2. Руки уберите вдоль туловища так, чтобы касаться ладонями пола (дивана, коврика). \n3. С упором на всю поверхность ступни, поднимайте таз максимально вверх. Затем плавно опускайте его в исходное положение. Оптимальное 4. число повторений — 15. Между подходами делайте отдых на 20–30 секунд. \n5. Делайте 3-4 подхода.",
          "program_3_ex_4_name": "Ходьба на ягодицах",
          "program_3_ex_4_desc":
              "1. Сядьте на пол, для комфорта используйте гимнастический коврик. Выпрямите ноги и держите их в расслабленном состоянии. \n2. Руки согните в локтях, слегка прижмите к туловищу. \n3. Начните передвигаться сидя на ягодицах, включая в работу исключительно ягодичные мышцы. \n4. Один подход — 5 повторений (небольших дистанций вперёд или в сторону). \n5. Всего выполняйте 3–4 подхода.",
          "program_3_ex_5_name": "Стульчик",
          "program_3_ex_5_desc":
              "1. Встаньте возле стены, \n2. ноги поставьте на ширину плеч. \n3. Лопатками прижмитесь к стене, руки выпрямите вдоль туловища. ВАЖНО! Ладони во время упражнения должны касаться стены, нельзя ставить руки на колени! Медленно опускайтесь на невидимый «стульчик», образуя угол в коленях 90о. \n4. Задержитесь в этой позе на максимально возможное время. \n5. Сделайте три подхода по 15 повторений.",
          "program_4": "Комплекс для гибкости",
          "program_4_ex_1_name": "Боковые наклоны",
          "program_4_ex_1_desc":
              "1. Из положения стоя сомкните над головой руки в замок. \n2. Потянитесь вверх, вправо и влево, вперед и назад. \n3. Совершите круговые движения корпусом тела. \n4 . Выполняйте упражнение 10-15 раз.",
          "program_4_ex_2_name": "Отведение ноги",
          "program_4_ex_2_desc":
              "1. Из положения стоя (при необходимости используйте опору) согните ногу в колене и вытяните противоположную руку в сторону. \n2. Чувствуйте натяжения, отводя в разные сторону противоположные руку и ногу. \n3. На каждую сторону выполните по 5 подходов с удержанием положения по 8 секунд.",
          "program_4_ex_3_name": "Растяжка лопаток и груди",
          "program_4_ex_3_desc":
              "1. Из положения сидя по-турецки сомкните руки в замок и потянитесь слегка назад. \n2. Затем выставите ноги вперед. \n3. Охватите руками под коленями и растяните верхнюю часть спины. Выполните по 5 подходов, удерживая каждое положение по 5 секунд.",
          "program_4_ex_4_name": "Растяжка лопаток и груди",
          "program_4_ex_4_desc":
              "1. Из положения стоя сделайте глубокий выпад вперед. \n2. Руками совершите упор на коврик. \n3. Затем выпрямите спину с поднятыми вверх прямыми руками.\n4. Совершайте наклон и подъем 6 раз, удерживая по 5 секунд каждое положение.",
          "program_4_ex_5_name": "Растяжка передней поверхности бедра",
          "program_4_ex_5_desc":
              "1. Из положения выпада потяните согнутую ногу противоположной рукой. \n2. Держите положение 10 секунд и смените сторону.\n3. Делайте 10-15 раз ",
          "program_4_ex_6_name": "Растяжка спины и боковой поверхности бедра",
          "program_4_ex_6_desc":
              "1. Из положения сидя скрестите ноги, закинув одну на другую, на сколько возможно. \n2. Тянитесь вниз, стараясь выпрямить спину и опуститься. \n3. На каждую сторону удержите положение 10 секунд.\n4. Выполняйте 10-15 раз",
          "program_1_ex_1_audio": "assets/audios/pr1_ex1_ru.mp3",
          "program_1_ex_2_audio": "assets/audios/pr1_ex2_ru.mp3",
          "program_1_ex_3_audio": "assets/audios/pr1_ex3_ru.mp3",
          "program_1_ex_4_audio": "assets/audios/pr1_ex4_ru.mp3",
          "program_1_ex_5_audio": "assets/audios/pr1_ex5_ru.mp3",
          "program_1_ex_6_audio": "assets/audios/pr1_ex6_ru.mp3",
          "program_2_ex_1_audio": "assets/audios/pr2_ex1_ru.mp3",
          "program_2_ex_2_audio": "assets/audios/pr2_ex2_ru.mp3",
          "program_2_ex_3_audio": "assets/audios/pr2_ex3_ru.mp3",
          "program_2_ex_4_audio": "assets/audios/pr2_ex4_ru.mp3",
          "program_2_ex_5_audio": "assets/audios/pr2_ex5_ru.mp3",
          "program_2_ex_6_audio": "assets/audios/pr2_ex6_ru.mp3",
          "program_3_ex_1_audio": "assets/audios/pr3_ex1_ru.mp3",
          "program_3_ex_2_audio": "assets/audios/pr3_ex2_ru.mp3",
          "program_3_ex_3_audio": "assets/audios/pr3_ex3_ru.mp3",
          "program_3_ex_4_audio": "assets/audios/pr3_ex4_ru.mp3",
          "program_3_ex_5_audio": "assets/audios/pr3_ex5_ru.mp3",
          "program_4_ex_1_audio": "assets/audios/pr4_ex1_ru.mp3",
          "program_4_ex_2_audio": "assets/audios/pr4_ex2_ru.mp3",
          "program_4_ex_3_audio": "assets/audios/pr4_ex3_ru.mp3",
          "program_4_ex_4_audio": "assets/audios/pr4_ex4_ru.mp3",
          "program_4_ex_5_audio": "assets/audios/pr4_ex5_ru.mp3",
          "program_4_ex_6_audio": "assets/audios/pr4_ex6_ru.mp3",
          "exercise_1_title": "Потягивания",
          "exercise_1_text":
              "Начинайте с растяжки вверх. \n\n 1. Встаньте ровно, ноги на ширине плеч.\n\n2. Кисти рук сложите в замок, ладони выверните наружу от себя.\n\n3. Медленно поднимите руки выше головы и начинайте тянуться всем телом к потолку.\n\n4. Держите спину и голову ровными, не прогибайтесь.\n\n5. Выполняйте упражнение по 10-15 секунд 3-4 раза.",
          "exercise_2_title": "Шаги на месте",
          "exercise_2_text":
              "1. Стопы человека имеют множество чувствительных точек, которые отвечают за работу разных органов. \n\n2. Чтобы сделать их легкий массаж пошагайте на месте, попеременно делая упор на пятках, носках и боковых частях ступни.\n\n3. Выполняйтеупражнение по 30-50 секунд.",
          "exercise_3_title": "Перекаты с носков на пятки",
          "exercise_3_text":
              "1. Встаньте ровно.\n\n2. Ступни расположите на расстоянии 15 см друг от друга.\n\n3. Вдохните и встаньте на носки, выдыхайте и плавно перекатитесь на пятки.\n\n4. Повторяйте упражнение по 20-25 раз.",
          "exercise_4_title": "Вращения",
          "exercise_4_text":
              "1. Для разминки тела лучше всего выполнять вращательные движения.\n\n2. Начинайте с головы, затем переходите на кисти рук, локти, плечи, ступни, лодыжки и колени.\n\n3. На каждую часть тела выделяйте по 10 повторов в каждую сторону.",
          "exercise_5_title": "Попеременные\nнаклоны и приседания",
          "exercise_5_text":
              "Простое, но эффективное упражнение, которое поможет задействовать много важных мышц. \n\n 1. Встаньте прямо, ноги расположите на ширине плеч, руки – на талии.\n\n2. Медленно наклоняйтесь вперед, затем выпрямите спину и сделайте одно приседание.\n\n3. Спину держите максимально ровно, чтобы избежать травм коленей.\n\n4.Упражнение повторите 10-20 раз",
          "exercise_6_title": "Наклоны в стороны",
          "exercise_6_text":
              "1. Примите вертикальное положение, ноги разместите немного шире плеч.\n\n2. Поднимите правую руку вверх.\n\n3. Плавно, без резких движений сначала наклонитесь влево, затем смените руку и наклонитесь вправо.\n\n4. Держите спину ровно, наклоняйтесь четко в сторону.\n\n5. Повторите упражнение 15 раз в каждую сторону.",
          "exercise_7_title": "Попеременное\nподтягивание ног",
          "exercise_7_text":
              "1. Примите положение лежа.\n\n2. Руки выпрямите вверх.\n\n3. Начните с правой ноги.\n\n4. Согните ее в колене и максимально подтяните к себе, в это же время потяните к колену согнутую левую руку.\n\n5. После смените ногу и руку.\n\n6. Повторяйте упражнение 15 раз для каждой ноги.",
          "exercise_8_title": "«Кошечка»",
          "exercise_8_text":
              "Тянем брюшную мышцу. \n\n 1. Для этого встаньте на коврик  коленями, обопритесь на согнутые кисти.\n\n2. Попеременно сгибайте и разгибайте  мышцы спины.\n\n3. Выполняйте упражнение по 10-15 раз",
          "exercise_9_title": "Отжимания",
          "exercise_9_text":
              "1. Существует обычный и облегченный вариант отжиманий, отличается лишь положением ног.\n\n2. Если вы достаточно хорошо подготовлены, то отжимайтесь с вытянутыми ногами, упираясь на носки, если так тяжело, то опирайтесь на колени.\n\n3. Выполните 15 отжиманий.",
          "exercise_10_title": "Потягивания ",
          "exercise_10_text":
              "1. Встаньте, поднимите руки вверх.\n\n2. На выдохе поднимайтесь на носки и плавно тянитесь как можно выше.\n\n3.На вдохе опускайтесь полностью на стопы и расслабляйте мышцы.\n\n4. Повторите упражнений 5 раз по 10 секунд.",
          "fitness": "ФИТНЕС",
          "fitness_title":
              "Подготовтесь к\n оздоровлению Вашего\n организма, благодаря\n упражнениям  ",
          "good_morning": "Доброе утро,\n",
          "meditation": "МЕДИТАЦИЯ",
          "meditation_title":
              "Примите наиболее удобную\n позу, успокойте ум, \nследите за дыханием.",
          "note": "ЗАМЕТКА",
          "fitness_program": "Готовая программа",
          "fitness_my_program": "Составить свою",
          "visualization": "ВИЗУАЛИЗАЦИЯ",
          "visualization_title":
              "Закройте глаза и представьте желаемое. Трогайте, осязайте свою цель, продумайте путь к её достижению по шагам.",
          "visualization_hint":
              "В поле опишите кратко (в одно предложение), что будете визуализировать",
          "diary": "ДНЕВНИК",
          "voice_record": "Голосовая запись",
          "written_record": "Письменная запись",
          "affirmation": "АФФИРМАЦИИ",
          "affirmation_title":
              "Произносите четко, вслух,\n с полной уверенностью\n и сосредоточением",
          "your_name": "Введите свое имя",
          "google": "Войти с помощью google аккаунта",
          "apple": "Войти с помощью apple аккаунта",
          "restart": "Начать заново",
          "menu": "Главное меню",
          "day": "День",
          "min": "мин",
          "sec": "сек",
          "seconds": "секунд",
          "pull_program":
              "Перетягивайте упражнения\n сверху вниз,\nформируя свою программу",
          "add_exercises": "добавить свои\nупражнения",
          "success": "Успех!",
          "pages": "Сколько страниц ?",
          "pages_note": "страниц",
          "continue": "Продолжить",
          "stop": "Остановить",
          "push_success": "Успешно!",
          "action_completed": "действие завершено!",
          "timer_started": "Таймер\nзапущен",
          "appreciate":
              "Мы ценим Ваш уют и комфорт, и поэтому сделали  приложение платным. Чтобы вы могли не отвлекаться на рекламу.",
          "subscribe_futures":
              "Подписка предоставит возможность выполнять такие упражнения как: Фитнес, Дневник, Чтение и Визуализация. Она продляется каждый месяц автоматически, но отменить ее можете в любое время.",
          "price": "Стоимость",
          "buy_month": "Оплатить подписку",
          "buy_days": "Попробуйте 3 дня бесплатно",
          "buy_free": "ПОПРОБОВАТЬ ПОЛНЫЙ\nКОМПЛЕКС",
          "three_days": "3 дня бесплатно",
          "choose_sequence": "Выберите\nпоследовательность",
          "sure": "Вы уверены ?",
          "sure_delete": "Вы уверены что хотите удалить упражнение ?",
          "cancel": "Отменить",
          "skip": "Пропустить",
          "skip_note": "пропуск",
          "minutes": "минут",
          "choose": "Выбрать",
          "choose_title":
              "Зажмите и удерживайте, чтобы изменить порядок упражнений.\nВыставите удобное для Вас время.\n0 мин – пропуск упражнения.",
          "affirmation_small": "Аффирмации",
          "meditation_small": "Медитация",
          "fitness_small": "Фитнес",
          "diary_small": "Дневник",
          "reading_small": "Чтение",
          "visualization_small": "Визуализация",
          "duration": "Продолжительность",
          "magic_morning": "«Магического утра»",
          "write_affirmation": "Напишите свою\nаффирмацию",
          "affirmation_hint":
              "Фразы должны быть четкими, утвердительными, короткими и происходить в настоящем времени:\"Все решения, которые я принимаю ведут меня к счастливому будущему\"",
          "book_name": "Введите название\nкниги",
          "player_voice": "Голос озвучки",
          "female": "Женский",
          "male": "Мужский",
          "language": "Язык",
          "x_minutes": "@x минут",
          "faq_desc":
              "<b>1. ПРИЛОЖЕНИЕ:</b><br><br>Для людей которые хотят <b>изменить свою жизнь, но не знают с чего начать.</b> <br><br><b>«Магическое утро»</b> зарядит энергией и поможет осознанно подойти к планированию своего дня.<br><br><b>2. «МАГИЧЕСКОЕ УТРО»:</b><br><br>Состоит из <b>6</b> блоков<br><br><b>Медитация</b> – поможет не спеша пробудить разум<br><br><b>Аффирмации</b> – заряжают разум положительными эмоциями<br><br><b>Визуализации</b> – позволяют точно представить желаемый успех<br><br><b>Фитнес</b> – заряжают ваше тело энергией<br><br><b>Чтение</b> – развивайтесь уже с самого утра! (особенно если не хватает времени вечером)<br><br><b>Дневник</b> - запомните что сделали и чему научились, запишите самые важные мысли<br><br><b>3. КАК ПОЛЬЗОВАТЬСЯ:</b><br><br>√ Начните с <b>«настроек»</b> там можно выставить:<br><br>- <b>Время </b>каждого из блоков<br><br>- <b>Последовательность</b> блоков<br><br>- <b>Аффирмацию</b> по умолчанию<br><br>- <b>Книгу</b> которую читаете<br><br> Настройки можно поменять в любое время.<br><br>√ Теперь Вы можете приступить к выполнению своего великолепного утра, нажав кнопку «Начать», всё будет проходить в соответствии с заданными настройками.<br><br><b>√ Прогресс будет показывать:</b><br><br>- <b>Время</b> по каждому дню<br><br>- <b>Количество</b> страниц прочитанных книг<br><br>- <b>Ваши</b> Аффирмации<br><br><b>4. ЕСЛИ ОСТАЛИСЬ ВОПРОСЫ:</b><br><br><a href='mailto:wonderfulmorningnow@gmail.com'>wonderfulmorningnow@gmail.com</a><br><br>с радостью отвечу на все ваши вопросы",
          "add_exercise": "Добавьте упражнение",
          "name": "Пожалуйста, введите Ваше имя",
          "delete_exercise": "Удалите упражнение",
          "delete_hint": "Зажмите и удерживайте\n что бы удалить",
          "your_exercise": "Ваше упражнение",
          "enter_your_exercise": "Введите своё упражнение",
          "add_permission": "Предоставьте разрешение для записи аудио",
          "yes": "Да",
          "no": "Нет",
          "enter_your_name": "Введите ваше имя",
          "remove_progress": "Удалить прогресс",
          "sure_delete_progress":
              "Вы уверены что хотите удалить весь прогресс приложения ?",
          "and": " и ",
          "agreement_start":
              "Нажимая “Далее”, вы подтверждаете, что принимаете ",
          "agreement_title": "Пользовательское соглашение",
          "privacy_title": "Политика конфиденциальности",
          "paragraph1": "Записывайте важные мысли в заметки",
          "paragraph2": "Приводите себя в тонус благодаря фитнесу",
          "paragraph3": "Получайте вдохновение из книг по утрам",
          "paragraph4": "Визуализируйте свой успех",
          "try_vip_desc":
              "Попробуйте в течение 3 дней бесплатно, а затем цена составит @price в месяц. Можете отменить в любое время",
          "vip_price_card": "1 \n месяц \n @price",
          "vip_def_month_price": "75 руб",
          "confidence_text_1":
              "Мне нравится расширять зону комфорта и идти к новому",
          "confidence_text_2": "Я ценю свои способности",
          "confidence_text_3":
              "Я ощущаю спокойную уверенность в любой ситуации",
          "confidence_text_4": "Я ценю свои способности",
          "confidence_text_5":
              "Я имею право жить своей жизнью и исполнять свое  предназначение",
          "confidence_text_6":
              "Я позволяю себе идти своим путем, исполняя свои мечты",
          "confidence_text_7":
              "Я люблю в себе всё. Я люблю каждую частицу своего тела и свою душу",
          "health_text_1":
              "Мое тело делает все возможное для сохранения отменного здоровья!",
          "health_text_2":
              "Я доверяю своей интуиции. Я всегда прислушиваюсь к внутреннему голосу!",
          "health_text_3":
              "Я сплю здоровым, крепким сном. Мое тело ценит мою заботу о нем!",
          "health_text_4":
              "Только я могу контролировать свои пристрастия в еде. Я всегда могу отказаться от чего-либо!",
          "health_text_5":
              "Я нахожусь в гармонии с частью своего «Я», которое знает секреты исцеления!",
          "health_text_6": "С каждым днем я становлюсь здоровее и крепче",
          "health_text_7": "У меня много жизненной силы и энергии",
          "health_text_8":
              "У меня всегда хорошее самочувствие. Так как моему телу хорошо, то в душе появляются только позитивные и добрые чувства",
          "health_text_9": "У меня прекрасное здоровье",
          "health_text_10": "Я позволяю телу исцелиться",
          "health_text_11": "У меня крепкое здоровье",
          "love_text_1": "Я открываю свое сердце для любви",
          "love_text_2": "Я чувствую, что любима",
          "love_text_3": "Я позволяю себе любить. Это безопасно",
          "love_text_4":
              "Я наслаждаюсь своей магической женской притягательностью",
          "love_text_5":
              "Я нахожусь в гармонии с частью своего «Я», которое знает секреты исцеления!",
          "love_text_6": "Я открываю и принимаю свою внутреннюю женщину",
          "love_text_7":
              "Я абсолютно уверена в своей женской привлекательности",
          "love_text_8":
              "Я открыта для любви и гармоничных отношений с любимым и любящим меня человеком",
          "love_text_9":
              "Я выбираю для себя радость и счастье! Я этого достойна",
          "love_text_10":
              "Взаимная любовь приходит ко мне. И я наслаждаюсь прекрасными\nгармоничными отношениями",
          "love_text_11":
              "Я готова к серьезным, гармоничным отношениям. Где я люблю и я\nлюбима! Благодарю",
          "success_text_1": "Мой ум открыт для новых возможностей",
          "success_text_2":
              "Я благодарен за свои навыки и умения, которые помогают мне достичь желаемого",
          "success_text_3":
              "Я хорошо организован и эффективно управляю своим временем",
          "success_text_4":
              "Я устанавливаю высокие стандарты для себя и всегда оправдываю свои ожидания",
          "success_text_5":
              "Я доверяю своей интуиции и всегда принимаю мудрые решения",
          "success_text_6":
              "Я последовательно привлекаю только нужные обстоятельства в нужное время",
          "success_text_7":
              "Каждый день наполняюсь новыми идеями, которые вдохновляют и мотивируют меня",
          "success_text_8":
              "У меня достаточно сил, чтобы процветать и иметь успех во всем, что желаю",
          "success_text_9":
              "Я с удовольствием принимаю сильные и смелые решения",
          "success_text_10":
              "Жизнь всегда готова помочь мне, дав все обходимое",
          "success_text_11": "Я смело и уверенно пользуюсь всеми благами жизни",
          "career_text_1": "Я мотивирован, последователен и целеустремлен",
          "career_text_2": "Я всегда достигаю своих рабочих целей",
          "career_text_3": "Успех на работе это легко",
          "career_text_4": "Со мной хорошо обращаются и уважают на работе",
          "career_text_5": "Идеальная компания наймет меня",
          "career_text_6":
              "Я заслуживаю иметь захватывающую и приятную карьеру, о которой я мечтаю",
          "career_text_7":
              "Я заслуживаю того, чтобы иметь жизнь, которую я хочу, и, в том числе, карьеру, которую я выберу",
          "career_text_8":
              "Я знаю, что когда я вкладываю все свои силы в свою работу, я получаю огромное вознаграждение",
          "career_text_9":
              "У меня есть работа, которая позволяет мне полностью выразить свою индивидуальность и уникальные таланты",
          "career_text_10": "Я мoгy дocтичь вceгo, чтo зaдyмaю",
          "career_text_11":
              "Я зapaбaтывaю xopoшиe дeньги, дeлaя тo, чтo мнe нpaвитcя",
          "wealth_text_1":
              "Деньги любят меня и приходят в нужном количестве и даже более",
          "wealth_text_2": "Деньги - мои друзья",
          "wealth_text_3":
              "Я везде вижу возможность заработать деньги! Я легко реализую лучшие из возможностей!",
          "wealth_text_4": "Я легко трачу деньги, и легко получаю деньги",
          "wealth_text_5":
              "Я – магнит для денег! Деньги приходят ко мне разными путями!",
          "wealth_text_6":
              "Сделанное мной добро возвращается ко мне в умноженном виде",
          "wealth_text_7":
              "Я отдаю и получаю деньги с радостью и благодарностью",
          "wealth_text_8": "Я с благодарностью принимаю щедрые дары Вселенной",
          "wealth_text_9":
              "Вселенская энергия щедро обеспечивает меня благами жизни",
          "wealth_text_10":
              "Я всегда притягиваю в свою жизнь огромное количество ресурсов и идей",
          "start_program": "Начать программу",
          "program_settings": "Настройки программ",
          "restore_default": "Восстановить\nпо умолчанию",
          "create_yours": "Создать\nсвою",
          "restore_default_dialog_title":
              "Вы действительно хотите восстановить программы по умолчанию?\nПользовательские программы будут удалены",
          "restore": "Восстановить",
          "delete": "Удалить",
          "edit": "Редактировать",
          "cancellation": "Отмена",
          "delete_program_alert": "Вы действительно хотите удалить программу?",
          "exercises": "Упражнения",
          "initial_exercises_empty":
              "Стандартные упражнения уже добавлены\nПопробуйте создать свое упражнение",
          "add_yours": "Добавить свое",
          "save": "Сохранить",
          "name_not_be_empty": "Название не может быть пустым",
          "type_exercise_name": "Введите название упражнения",
          "type_program_name": "Введите название программы",
          "type_exercise_description": "Введите описание упражнения",
          "hold_to_move_exercise":
              "Удерживайте упражнение, чтобы перетащить в нужное место",
          "type_name": "Введите название",
          "tutorial_text": "Как легко вставать по утрам?",
          "rate_app_title": "Оцените приложение",
          "rate_app_description": "Ваша оценка поможет нам стать лучше",
          "action_rate": "Оценить",
          "action_remind": "Напомнить позже",
          "rate_subject": "Оценка приложения",
          "my_progress": "МОЙ ПРОГРЕСС",
          "exercise_complete": "Упражнение завершено",
          "affirmation_timer": "Аффирмации",
          "success_target": "Успех",
          "family_target": "Семья",
          "nature_target": "Природа",
          "rest_target": "Отдых",
          "sport_target": "Спорт",
          "target_selection": "Выбор цели",
          "remove_created_target": "Удалить созданную цель?",
          "impression_selection": "Выбор образа",
          "remove_image": "Удалить изображение?",
          "target_title": "название",
          "target_short_desc":
              "в поле опишите кратко (в одно предложение)  что будете визуализировать",
          "music_menu_music": "Музыка",
          "music_menu_sounds": "Звуки",
          "music_menu_favorite": "Избранное",
        },
        EN: {
          "start": "Start",
          "progress_item": "Progress",
          "settings": "Settings",
          "pay": "Buy subscription",
          "store_app": "Store",
          "user_is_pro": "Subscribed",
          "upsell_screen": "Advance purchase",
          "loading_buy": "Loading",
          "loading_buy_app_bar": "Loading...",
          "start_fitness_my_program": "Start your program",
          "awareness_meter": "Awareness meter",
          "month": "Month",
          "year": "Year",
          "total": "Total",
          "for_week": "For week\n",
          "skip_note": "skip",
          "pages_note": "pages",
          "minutes_per_week": "minutes",
          "monday_short": "mn",
          "tuesday_short": "ts",
          "wednesday_short": "wd",
          "thursday_short": "th",
          "tutorial_asset": "assets/audios/tutorial_eng.mp3",
          "friday_short": "fr",
          "saturday_short": "st",
          "sunday_short": "sn",
          "count_of_sessions": "Amount\nof completed\npractice",
          "minutes_of_awareness_with_myself":
              "Minutes\nof awareness\nwith myself",
          "count_of_completed_sessions": "Amount\nof completed\nsessions",
          "my_diary": "My diary",
          "my_exercises": "My exercises",
          "my_affirmations": "My affirmations",
          "my_books": "My books",
          "my_visualization": "My visualizations",
          "choose_ready": "Choose ready",
          "add_note": "Add note",
          "faq": "FAQ",
          "reading": "READING",
          "reading_title":
              "Get into a comfortable\n position and be ready\n for reading.",
          "next_button": "Next",
          "progress": "PROGRESS",
          "progress_title": "You have not had any wonderful morning.",
          "back_button": "Back",
          "timer": "Timer",
          "exercise": "Exercise @id",
          "listen_to": "Listen to it",
          "next_exercise": "Next exercise",
          "program_1": "Energy boost",
          "program_1_ex_1_name": "Backward and forward head bending ",
          "program_1_ex_1_desc":
              "1. Stretch your head up, slowly bend you head forward.\n2. Carefully bend the head backward.\n3. Repeat the exercise 5 times to each direction.",
          "program_1_ex_2_name": "Head circling",
          "program_1_ex_2_desc":
              "1. Circle your head from the left to the right.\n2. Repeat the exercise 5 times to each direction.",
          "program_1_ex_3_name": "Shoulders circling",
          "program_1_ex_3_desc":
              "1. Circle your shoulders forward and backward\n2. Repeat the exercise 5 times to each direction.",
          "program_1_ex_4_name": "Body bending to the right and to the left",
          "program_1_ex_4_desc":
              "1. Stand in straddle.\n2. Lift your arms up, exhale and bend your trunk to the right, inhale, and bend into the starting position.\n3. Exhale and bend your trunk to the left, inhale and bend into the starting position.\n4.Repeat the exercise 5 times to each direction.",
          "program_1_ex_5_name": "Tiptoe Training",
          "program_1_ex_5_desc":
              "1. Hold your ankle-joints and keep straight posture.\n2. Repeat the exercise 5 times.",
          "program_1_ex_6_name": "Squats",
          "program_1_ex_6_desc":
              "1. Hold your heels on the floor.\n2. Repeat the exercise 5 times.",
          "program_2": "Healthy back",
          "program_2_ex_1_name": "Left and right head circling",
          "program_2_ex_1_desc":
              "1. Do not do harsh movements.\n2. Do it slowly, breathe smoothly. \n3. Repeat the exercise 5 times to each side.",
          "program_2_ex_2_name": "Backward and forward head bending ",
          "program_2_ex_2_desc":
              "1. Stretch your head up, slowly bend you head forward.\n2. Carefully bend the head backward.\n3. Repeat the exercise 5 times to each direction.",
          "program_2_ex_3_name": "Cat-Cow",
          "program_2_ex_3_desc":
              "1. Start on all fours with your hands directly under your shoulders and your knees directly under your hips. Your spine and neck should be neutral.\n2. Engaging your core, start the upward phase of the movement: Exhale and push your spine toward the ceiling\n3. Continuing to engage your core, move to the downward phase: Let your stomach fall toward the floor. Alternate the postures smoothly 4-5 times.",
          "program_2_ex_4_name": "Bridge",
          "program_2_ex_4_desc":
              "1. This is an exercise for relaxing your back.\n2. Lie on your back with your hands at your sides, knees bent, and feet flat on the floor under your knees.\n3. Raise your hips to create a straight line from your knees to shoulders. Squeeze your core and pull your belly button back toward your spine.\n4. Complete at least 8 reps.",
          "program_2_ex_5_name": "Superman",
          "program_2_ex_5_desc":
              "1. The exercise strengthens your lower side of the back and your hips.  \n2. Lie face down, with your arms outstretched in front of you. \n3. Hold your legs straight.\n4. Inhale, raise both your arms and legs at the same time, forming a bowl shape with your body.\n5. Hold on for a second, exhale and lie back into the starting position. Keep in mind that you need to prevent sudden movements.\n6. You should feel your lower back, glutes and hamstrings working in the hold position. Keep your neck straight and look at the floor. ",
          "program_2_ex_6_name": "Downward Dog",
          "program_2_ex_6_desc":
              "1. Begin in a kneeling position with hands directly under shoulders, fingers spread wide.\n2. Legs shoulder-width apart.\n3. Tuck your toes under and engage your abdominals as you push your body up off the floor so only your hands and feet are on the floor. \n4. Relax your head and neck and breathe fully hold it for a minute.",
          "program_3": "The complex for glutes and legs ",
          "program_3_ex_1_name": "Squats.",
          "program_3_ex_1_desc":
              "1. Keep your feet about shoulder-width apart.\n2. Turn your feet out anywhere between 5 and 30 degree.\n3. Put your arms straight out in front of you, parallel to the ground. \n4. Keep your chest up and proud, and your spine in a neutral position.\n5. Hold your knees and tiptoes on one parallel line.  \n6. Look at the spot in front of you the entire time you squat, not looking down at the floor or up at the ceiling.\n7. Do 3 sets of 15 repetitions.  ",
          "program_3_ex_2_name": "Forward lunge",
          "program_3_ex_2_desc":
              "1. Stand tall with feet hip-width apart.\n2. Keep your head straight.  \n4. Take a big step forward with right leg. Start to shift your weight forward so heel hits the floor first. Stop when both legs form 90-degree angles.\n5. Press into right heel to drive back up to starting position. Make a step and inhale, move into the starting position and exhale. Change sides every time.  \n6. Perform 3 sets on each leg of 13-15 repetitions. ",
          "program_3_ex_3_name": "Glute Bridge",
          "program_3_ex_3_desc":
              "1. Lie down with knees bent. Feet flat on the floor.\n2. Arms by sides (on a mat)\n3. Engage core, then press into heels and squeeze glutes to raise your hips toward the ceiling. Hold the position for a second before lowering to start. 4.Perform 15 reps\n5. Between sets rest up to 30 seconds.\n6. Do 3-4 sets.",
          "program_3_ex_4_name": "Bum Walk",
          "program_3_ex_4_desc":
              "1. Have your legs out in front of you, sitting upright. You can use a mat for comfortability. \n2. Bend the elbows and bring them close to the body\n3. Inhale and lift one side of the buttocks gently up from the floor by squeezing the gluteal muscles together.\n4. One set — 5 reps.\n5. Do 3-4 sets.",
          "program_3_ex_5_name": "Wall Sit",
          "program_3_ex_5_desc":
              "1. Lean against the wall with your feet shoulder-width apart and firmly planted on the ground.\n2. Engage your core and put your feet forward. Go down as you do so, and keep leaning against the wall. Your feet should be 6 inches apart.\n3. Slowly slide down the wall with your back pressed against it until your legs are bent at a right angle. This angle is very crucial because if your thighs are not parallel to the ground, your muscles will not get a good workout.\n4. Hold this position for as long as possible.\n5. Do 3 sets of 15 reps. ",
          "program_4": "Flexibility complex",
          "program_4_ex_1_name": "Left Side Stretch",
          "program_4_ex_1_desc":
              "1. Stand tall with your feet together and reach both arms overhead with palms together.\n2. Inhale and bend laterally to the left side, then right side, bend forward and than backward.\n3. Make a circle with your trunk.  \n4 . Do 10-15 reps.",
          "program_4_ex_2_name": "Standing Bird Dog",
          "program_4_ex_2_desc":
              "1. Stand with your arms at your sides, right foot raised a few inches behind you\n2. Lean forward while you extend your right leg directly back and your left arm forward\n3. Do 5 sets and hold for 8 seconds on each side.",
          "program_4_ex_3_name": "Seated Forward Bend ",
          "program_4_ex_3_desc":
              "1. Sit with your legs extended straight in front of you.\n2. Bring your arms straight out to the sides and up over your head, reaching toward the ceiling.\n3. As you exhale, begin to come forward, hinging at your hips, hold them for 5 seconds.\n4. Do 5 sets.",
          "program_4_ex_4_name": "The Low Lunge Arch",
          "program_4_ex_4_desc":
              "1. Step your right foot forward into a lunge and lower your left knee onto the floor.\n2. Bring your arms in front of your right leg and hook your thumbs together, palms facing the floor.\n3. Breathe in as you sweep your arms overhead, stretching as far back as is comfortable.\n4. Switch sides. Do 6 sets and hold for 5 seconds. ",
          "program_4_ex_5_name": "Hip Flexor Stretch ",
          "program_4_ex_5_desc":
              "1. Lunge forward with one leg, knee bent.\n2. Hold for 10 seconds on each leg.\n3. Do 10-15 repetitions.",
          "program_4_ex_6_name": "The hurdler hamstring stretch ",
          "program_4_ex_6_desc":
              "1. Sit on the floor with one leg out straight. Bend the other leg at the knee and place its foot near the opposite inner thigh.\n2. Extend your arms overhead and lean forward over the straightened leg. \n3. Hold for 10 seconds. \n4. Repeat on the other leg. 10-15 reps. ",
          "exercise_1_title": "Stretching",
          "exercise_1_text":
              "Start with stretching. \n\n1. Stand straight with your feet open wider than shoulder width.\n\n2. Standing, clasp your hands straight up overhead, palms facing the ceiling.\n\n3. Slowly stretch up feeling a stretch in your body.\n\n4. Keep your head and back straight, don’t bend.\n\n5. Hold for 10 to 15 seconds, repeating three to four times.",
          "exercise_2_title": "March in Place",
          "exercise_2_text":
              "1. Human feet have plenty of sensitive points, which are responsible for the work of organs. \n\n2. Stand with feet shoulder length apart, and keep spine straight with hips facing forward. Bring your knee up so that your thigh is parallel to floor then place it down and bring the other leg up in an alternating fashion.\n\n3. Repeat up to fifty seconds.",
          "exercise_3_title": "Heel and Toe Raises",
          "exercise_3_text":
              "1. Stand up straight.\n\n2. Place your feet in 15 inches from each other.\n\n3. Inhale and roll the heels to toes, exhale and gently unroll back to the heels\n\n4. Repeat it from 20 to 25 times.",
          "exercise_4_title": "Rotations",
          "exercise_4_text":
              "1. The best way to warm up is rotational exercises.\n\n2. Begin with your head then to wrists, elbows, shoulders, feet, ankles and knees.\n\n3. Repeat it on every part of your body at least 10 tries to each side.",
          "exercise_5_title": "Alternating bend and squats",
          "exercise_5_text":
              "Simple, but effective exercise helps to improve many important muscles. \n\n1. Stand straight with your feet open wider than shoulder width,  hold hands on the waist.\n\n2. Gently bend down keeping your back flat and do one squat.\n\n3. Pay attention to your posture to prevent injuries of knees.\n\n4. Do 10-20 tries.",
          "exercise_6_title": "Standing Side Bend",
          "exercise_6_text":
              "1. Stand with your feet a little wider than hip distance apart.\n\n2. Raise your right hand.\n\n3. Lower your right arm down the right side of your body and exhale as you lengthen the left arm over the head, bending body gently to the right.\n\n4. Inhale to return arms overhead to center and exhale as you repeat on the left side.\n\n5. Repeat it at least 15 times to each side",
          "exercise_7_title": "Bicycle Crunch",
          "exercise_7_text":
              "1. Lay with the back on the floor.\n\n2. Your feet should be on the floor and your hands are behind your head.\n\n3. With your hands gently holding your head, pull your shoulder blades back and slowly raise your knees to about a 90-degree angle, lifting your feet from the floor.\n\n4. Rotate your torso so you can touch your elbow to the opposite knee as it comes up.\n\n5. Aim for 15 repetitions for each leg.",
          "exercise_8_title": "Cat and Dog",
          "exercise_8_text":
              "This exercise improves flexion\n and extension of the spine. \n\n1. Put your hands and knees on the ground.\n\n2. In one fluid movement, arch your back, suck in your stomach, and bring your hips forward.\n\n3. Now look up rather than into your legs or at the floor.\n\n4. Repeat it at least 15 times to each side",
          "exercise_9_title": "Press Up",
          "exercise_9_text":
              "1. There are toe press ups and knee press ups. The second is considred easier.\n\n2. Keeping your body in a straight line and your elbows close to your body, bend and straighten your arms to complete a press-up.\n\n3. If the first option is difficult, bend your knee and do the same as in the first exercise.\n\n4. Do 15 press-ups",
          "exercise_10_title": "Hand stretching",
          "exercise_10_text":
              "1. Extend your arms with your palms facing up toward the ceiling.\n\n2. Exhale as you extend your arms toward the ceiling.\n\n3. Inhale as you stand on the heel and relax.\n\n4. Repeat up to 5 times, each time extend your hands for 10 seconds.",
          "program_1_ex_1_audio": "assets/audios/pr1_ex1_en.mp3",
          "program_1_ex_2_audio": "assets/audios/pr1_ex2_en.mp3",
          "program_1_ex_3_audio": "assets/audios/pr1_ex3_en.mp3",
          "program_1_ex_4_audio": "assets/audios/pr1_ex4_en.mp3",
          "program_1_ex_5_audio": "assets/audios/pr1_ex5_en.mp3",
          "program_1_ex_6_audio": "assets/audios/pr1_ex6_en.mp3",
          "program_2_ex_1_audio": "assets/audios/pr2_ex1_en.mp3",
          "program_2_ex_2_audio": "assets/audios/pr2_ex2_en.mp3",
          "program_2_ex_3_audio": "assets/audios/pr2_ex3_en.mp3",
          "program_2_ex_4_audio": "assets/audios/pr2_ex4_en.mp3",
          "program_2_ex_5_audio": "assets/audios/pr2_ex5_en.mp3",
          "program_2_ex_6_audio": "assets/audios/pr2_ex6_en.mp3",
          "program_3_ex_1_audio": "assets/audios/pr3_ex1_en.mp3",
          "program_3_ex_2_audio": "assets/audios/pr3_ex2_en.mp3",
          "program_3_ex_3_audio": "assets/audios/pr3_ex3_en.mp3",
          "program_3_ex_4_audio": "assets/audios/pr3_ex4_en.mp3",
          "program_3_ex_5_audio": "assets/audios/pr3_ex5_en.mp3",
          "program_4_ex_1_audio": "assets/audios/pr4_ex1_en.mp3",
          "program_4_ex_2_audio": "assets/audios/pr4_ex2_en.mp3",
          "program_4_ex_3_audio": "assets/audios/pr4_ex3_en.mp3",
          "program_4_ex_4_audio": "assets/audios/pr4_ex4_en.mp3",
          "program_4_ex_5_audio": "assets/audios/pr4_ex5_en.mp3",
          "program_4_ex_6_audio": "assets/audios/pr4_ex6_en.mp3",
          "fitness": "FITNESS",
          "fitness_title":
              "Prepare for exercises which\n will restore your physical\n health",
          "good_morning": "Good morning,\n",
          "meditation": "MEDITATION",
          "meditation_title":
              "Sit in a comfortable position,\n calm down, pay attention\n to your breath.",
          "note": "NOTE",
          "fitness_program": "Pre-made program",
          "fitness_my_program": "Make my program",
          "visualization": "VISUALIZATION",
          "visualization_title":
              "Close your eyes, imagine your desire, touch it, feel it, picture your way to it step by step ",
          "visualization_hint": "Type your visualization, briefly describe it",
          "diary": "DIARY",
          "voice_record": "A voice record",
          "written_record": "A written record",
          "affirmation": "AFFIRMATION",
          "affirmation_title":
              "Pronounce clearly, out loud,\n with full confidence and\nconcentration",
          "your_name": "Your name",
          "google": "Sign in with Google",
          "apple": "Sign in with Apple",
          "restart": "Restart",
          "menu": "Menu",
          "day": "Day",
          "min": "min",
          "sec": "sec",
          "pull_program":
              "To set up your program pull\n down exercises from above",
          "add_exercises": "Add\nexercises",
          "success": "Success!",
          "pages": "How many pages ?",
          "continue": "Continue",
          "stop": "Stop",
          "push_success": "Successfully!",
          "action_completed": "action completed!",
          "timer_started": "Timer\nstarted",
          "appreciate":
              "We appreciate your coziness and comfort, and therefore made the application paid. So that you can not be distracted by advertising.",
          "subscribe_futures":
              "Subscription will provide the opportunity to perform exercises such as: Fitness, Diary, Reading and Visualization. It renews automatically every month, but you can cancel it at any time.",
          "price": "Price",
          "buy_month": "Pay for subscription",
          "buy_free": "TRY THE FULL COMPLEX",
          "three_days": "3 days free",
          "buy_days": "Try 3 days for free",
          "sure": "Are you sure ?",
          "sure_delete": "Are you sure you want to delete the exercise?",
          "cancel": "Cancel",
          "skip": "Skip",
          "minutes": "minutes",
          "choose_sequence": "Choose\nsequence",
          "choose": "Choose",
          "choose_title":
              "Drag and drop to change sequence of exercises and set time on them.\n0 min - skip exercise.",
          "exercises_note": "Exercises",
          "visualizations_note": "Visualization",
          "seconds": "seconds",
          "affirmation_small": "Affirmations",
          "meditation_small": "Meditation",
          "fitness_small": "Fitness",
          "diary_small": "Diary",
          "reading_small": "Reading",
          "visualization_small": "Visualization",
          "duration": "Duration of",
          "magic_morning": "“Wonderful Morning”",
          "write_affirmation": "Write your\naffirmation",
          "affirmation_hint":
              "1. Start with the words “I am.”\n2. Use the present tense.\n3. State it in the positive. Affirm what you want, not what you don’t want.\n4. Keep it brief.\n5. Include an action word ending with –ing.\n\nYou can use the following simple formula: “I am so happy and grateful that I am now …” and then fill in the blank.",
          "book_name": "Write name\nof book",
          "player_voice": "Voice",
          "female": "Female",
          "male": "Male",
          "language": "Language",
          "x_minutes": "@x minutes",
          "faq_desc":
              "<b>1. APPENDIX: </b><br> <br> For people who want to <b> change their lives, but don't know where to start. </b><br><br><b>«Magic Morning» </b> will energize and help you to consciously plan your day. <br> <br> <b>2. «MAGIC MORNING»: </b><br> <br> Consists of <b> 6 </b> blocks <br> <br> <b>Meditation </b> - will help to slowly awaken the mind <br> <br> <b>Affirmations </b> - charge the mind with positive emotions <br> <br> <b>Visualizations</b> - allow you to accurately represent the desired success <br> <br> <b>Fitness</b> - charge your body with energy <br> <br> <b>Reading</b> - develop from the very morning! (especially if there is not enough time in the evening) <br> <br> <b>Diary </b> - remember what you did and what you learned, write down the most important thoughts <br> <br> <b>3. HOW TO USE:</b> <br> <br>√ Start with <b> «settings»</b> there you can set: <br> <br>- <b>Time </b> of each block <br> <br>- <b>Sequence </b> blocks <br> <br> - <b> Default Affirmation </b> <br> <br> - <b>The book</b> you are reading <br> <br> Settings can be changed at any time. <br> <br> √ Now you can start making your great morning by clicking the <b> «Start» </b> button, everything will go according to the specified settings. <br> <br> <b>√ Progress will show:</b> <br> <br> - <b>Time</b> for each day <br> <br> - <b>Number</b> of pages of books read <br> <br> - <b>Yours</b>Affirmations <br> <br> <b>4. IF YOU HAVE ANY QUESTIONS:</b> <br> <br> <a href='mailto:wonderfulmorningnow@gmail.com'>wonderfulmorningnow@gmail.com</a> <br><br>I will gladly answer all your questions",
          "add_exercise": "Add exercise",
          "name": "Please enter your name",
          "delete_exercise": "Delete exercise",
          "delete_hint": "Clamp and hold\n to delete",
          "your_exercise": "Your exercise",
          "enter_your_exercise": "Enter your exercise",
          "add_permission": "Grant permission to record audio",
          "yes": "Yes",
          "no": "No",
          "save_diary": "Save note",
          "enter_your_name": "Enter your name",
          "remove_progress": "Remove progress",
          "sure_delete_progress":
              "Are you sure you want to delete all the application progress ?",
          "and": " and ",
          "agreement_start": "By clicking “Next”, you confirm that you accept",
          "agreement_title": "Terms of use",
          "privacy_title": "Privacy policy",
          "paragraph1": "Write important thoughts in notes",
          "paragraph2": "Tone yourself up with fitness",
          "paragraph3": "Get inspiration from books in the morning",
          "paragraph4": "Visualize your success",
          "try_vip_desc":
              "Try it for 3 days for free and then the price will be @price per month. You can cancel at any time",
          "vip_price_card": "1 \n month \n @price",
          "vip_def_month_price": "0.99 \$",
          "for_confidence": "For confidence",
          "for_health": "For health",
          "for_love": "For love (Female)",
          "for_success": "For success",
          "for_career": "For career",
          "for_wealth": "For wealth",
          "confidence_text_1":
              "Challenges are opportunities to grow and improve",
          "confidence_text_2": "I believe in my abilities",
          "confidence_text_3": "There are no blocks I cannot overcome",
          "confidence_text_4":
              "I am worthy of living my life and having what I want",
          "confidence_text_5":
              "I allow myself to choose my own way, fulfilling my dreams",
          "confidence_text_6": "I love who I am inside and out",
          "health_text_1":
              "My body knows how to heal itself. I allow the intelligence of my body to move my health forward",
          "health_text_2":
              "I believe in my intuition. I always listen to my inner voice",
          "health_text_3":
              "I fall asleep easily. My body, mind, and soul are worthy of their rest",
          "health_text_4":
              "I am in harmony with my inner part, which knows secrets of healing",
          "health_text_5": "I become healthier and stronger everyday",
          "health_text_6": "I have much energy and vital power",
          "health_text_7":
              "I am in control of the mental atmosphere I create. Thoughts can be changed and the positive thoughts I choose are helping me heal",
          "health_text_8": "I am healthy, happy and radiant",
          "health_text_9": "I am worthy of good health",
          "health_text_10": "I radiate good health",
          "love_text_1":
              "I give my heart, ready to receive the heart of another",
          "love_text_2": "I feel I am loved",
          "love_text_3": "I deserve love and affection",
          "love_text_4": "I am terrifically charismatic",
          "love_text_5":
              "I give permission to my inner goddess to work her magic",
          "love_text_6": "I embrace being a woman",
          "love_text_7": "I am confident in my sexuality",
          "love_text_8":
              "I am open to a healthy, loving relationship that is right for me",
          "love_text_9":
              "I am worthy of accomplishment, success, and abundance",
          "love_text_10": "I am worthy of a healthy, loving relationship",
          "love_text_11":
              "I am in a wonderful relationship with someone who treats me right!",
          "success_text_1":
              "I am open-minded and always eager to explore new avenues to success",
          "success_text_2":
              "I have the power to create all the success and prosperity I desire",
          "success_text_3": "I am organised and manage my time well",
          "success_text_4": "I fly high and I always match my expectations",
          "success_text_5":
              "I trust my intuition and I always make wise decisions",
          "success_text_6":
              "I successively attract needed circumstances at the right time",
          "success_text_7":
              "Every day I am filled with new ideas which motivate and insipre me",
          "success_text_8":
              "I have unlimited power to achieve everything I want",
          "success_text_9": "I make smart decisions with joy",
          "success_text_10":
              "The Universe wants to help me, giving everything I need",
          "success_text_11": "I have the courage to use all the prizes of life",
          "career_text_1": "I am motivated, goal-oriented and self-consistent",
          "career_text_2": "I always achieve my career goals",
          "career_text_3": "Success at work is easy",
          "career_text_4": "I am respected and well treated",
          "career_text_5":
              "Right this moment, my resume is being seen by all the right people",
          "career_text_6":
              "I deserve a job that fulfills me and now I am ready to find it!",
          "career_text_7":
              "As I align my career with my true talents, the money and the happiness flows to me!",
          "career_text_8":
              "I work hard! I work smart! I deserve the accolades I earn!",
          "career_text_9":
              "Today and every day, I use my talents in satisfying ways!",
          "career_text_10": "I mold my career to my goals!",
          "career_text_11": "I am financially secure, doing what I want",
          "wealth_text_1": "I naturally attract good fortune",
          "wealth_text_2": "Money is my friends",
          "wealth_text_3": "I easily spend and get money!",
          "wealth_text_4": "I am a money magnet! Money flows freely to me",
          "wealth_text_5":
              "I have a positive relationship to money and know how to spend it wisely",
          "wealth_text_6":
              "I see the opportunities to attract money! I convert the best opportunities!",
          "wealth_text_7": "I am connected to the universal supply of money",
          "wealth_text_8": "The Universe showers me with gifts",
          "wealth_text_9": "Every good deed comes back to me multiplied",
          "wealth_text_10": "I always attract lots of resources and ideas",
          "start_program": "Start program",
          "program_settings": "Program settings",
          "restore_default": "Restore\ndefaults",
          "create_yours": "Create\nyour",
          "restore": "Restore",
          "delete": "Delete",
          "edit": "Edit",
          "cancellation": "Cancel",
          "exercises": "Exercises",
          "add_yours": "Create yours",
          "save": "Save",
          "delete_program_alert": "Are you sure you want to delete a program?",
          "initial_exercises_empty":
              "Default exercises are already added\n Try to make your own exercise",
          "restore_default_dialog_title":
              " Are you sure you want to restore default exercises?\nUser programs/exercises will be deleted",
          "name_not_be_empty": "A name can not be empty",
          "type_exercise_name": "Type an exercise name",
          "type_program_name": "Type a program name",
          "type_exercise_description": "Type an exercise description",
          "hold_to_move_exercise": "Hold to move an exercise",
          "type_name": "Type a name",
          "tutorial_text": "How easy is it to get up in the morning?",
          "rate_app_title": "Rate app",
          "rate_app_description": "Your rating will help us become better",
          "action_rate": " Rate",
          "action_remind": "Remind me later",
          "rate_subject": "App rating",
          "my_progress": "MY PROGRESS",
          "exercise_complete": "Exercise complete",
          "affirmation_timer": "Affirmations",
          "audio_loading": "Audio is loading...",
          "success_target": "Success",
          "family_target": "Family",
          "nature_target": "Nature",
          "rest_target": "Rest",
          "sport_target": "Sport",
          "target_selection": "Select target",
          "remove_created_target": "Remove created target?",
          "impression_selection": "Select impression",
          "remove_image": "Remove image?",
          "target_title": "title",
          "target_short_desc":
              "in the field describe briefly (in one sentence) what you will visualize",
          "music_menu_music": "Music",
          "music_menu_sounds": "Sounds",
          "music_menu_favorite": "Favorite",
        }
      };

  static Future<Locale> getInitialLocale() async {
    String _langCode = await MyDB()
        .getBox()
        .get(LOCALIZATION_KEY, defaultValue: Get.deviceLocale.languageCode);
    return Locale(_langCode);
  }

  static void switchLocale() {
    final _currentLocale = Get.locale;

    if (_currentLocale.languageCode == RU) {
      final _newLocale = Locale(EN);
      Get.updateLocale(_newLocale);
      MyDB().getBox().put(LOCALIZATION_KEY, _newLocale.languageCode);
    } else if (_currentLocale.languageCode == EN) {
      final _newLocale = Locale(RU);
      Get.updateLocale(_newLocale);
      MyDB().getBox().put(LOCALIZATION_KEY, _newLocale.languageCode);
    }
  }
}
