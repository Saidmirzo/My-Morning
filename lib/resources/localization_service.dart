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
          "start_input": "Начните писать...",
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
          "awareness_meter": "Измеритель\nосознанности",
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
          "program_1": "Йога.«Приветствие солнцу – Сурья намаскар»",
          "program_1_ex_1_name": "Хаста Уттанасана",
          "program_1_ex_1_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%A5%D0%B0%D1%81%D1%82%D0%B0%20%D0%A3%D1%82%D1%82%D0%B0%D0%BD%D0%B0%D1%81%D0%B0%D0%BD%D0%B0.mp3',
          "program_1_ex_1_desc":
              "1. Встаньте ровно, подтяните живот, \n2. ягодицы и коленные чашечки. \n2. На вдохе поднимите руки вверх, делая 3. небольшой прогиб назад. \n3. Вернитесь в исходное положение",
          "program_1_ex_2_name": "Уттанасана",
          "program_1_ex_2_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%A3%D1%82%D1%82%D0%B0%D0%BD%D0%B0%D1%81%D0%B0%D0%BD%D0%B0.mp3',
          "program_1_ex_2_desc":
              "1. Стойте ровно и сделайте вдох. \n2. На выдохе тянитесь руками вниз, сгибаясь в тазобедренных. \n3. Следите за тем, чтобы спина была прямая, шея расслаблена и руки все время тянулись вниз.",
          "program_1_ex_3_name": "Ашва Санчаланасана",
          "program_1_ex_3_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%90%D1%88%D0%B2%D0%B0%20%D0%A1%D0%B0%D0%BD%D1%87%D0%B0%D0%BB%D0%B0%D0%BD%D0%B0%D1%81%D0%B0%D0%BD%D0%B0.mp3',
          "program_1_ex_3_desc":
              "1. Встаньте на четвереньки, колени под тазом, руки выпрямлены и находятся под плечами. \n2. На вдохе сделайте выпад правой ногой вперед. Нога должна быть строго 90 градусов. \n3. Потянитесь, вернитесь в исходное положение и повторите с другой ноги.",
          "program_1_ex_4_name": "Адхо Мукха Шванасана",
          "program_1_ex_4_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%90%D0%B4%D1%85%D0%BE%20%D0%9C%D1%83%D0%BA%D1%85%D0%B0%20%D0%A8%D0%B2%D0%B0%D0%BD%D0%B0%D1%81%D0%B0%D0%BD%D0%B0.mp3',
          "program_1_ex_4_desc":
              "1. Встаньте на четвереньки, колени под тазом, руки выпрямлены и находятся под плечами. \n2. Сделайте вдох. На выдохе примите позу «собаки мордой вниз», выпрямляя руки и ноги. Колени могут быть согнуты \n3. Вернитесь в исходное положение.",
          "program_1_ex_5_name": "Бхуджангасана",
          "program_1_ex_5_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%91%D1%85%D1%83%D0%B4%D0%B6%D0%B0%D0%BD%D0%B3%D0%B0%D1%81%D0%B0%D0%BD%D0%B0.mp3',
          "program_1_ex_5_desc":
              "1. Лягте на пол животом вниз. \n2. Поставьте руки немного сбоку от груди с обеих сторон. \n3. На вдохе вытягивайте руки, поднимая корпус. Ягодицы и ноги должны быть подтянуты.",
          "program_1_ex_6_name": "Гомукхасана",
          "program_1_ex_6_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%93%D0%BE%D0%BC%D1%83%D0%BA%D1%85%D0%B0%D1%81%D0%B0%D0%BD%D0%B0.mp3',
          "program_1_ex_6_desc":
              "1. Сядьте на пол, ноги и спина выпрямлены. \n2. Скрестите ноги либо постарайтесь положить одну ногу сверху, как показано на рисунке. \n3. Поднимите руки вверх, сделайте вдох. На выдохе скрестите руки сзади за спиной, одна сверху, другая снизу. \n4. Вернитесь в исходное положение и повторите все с другой ноги и руки.",
          "program_2": "Программа «Бодрость»",
          "program_2_ex_1_name": "Наклоны",
          "program_2_ex_1_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%9D%D0%B0%D0%BA%D0%BB%D0%BE%D0%BD%D1%8B.mp3',
          "program_2_ex_1_desc":
              "1. Встаньте прямо, ноги шире плеч.\n2. Выполняйте поочередные наклоны в разные стороны. Правая рука наверху, левая согнута на боку, наклон вправо. И наоборот.",
          "program_2_ex_2_name": "Шаги на месте",
          "program_2_ex_2_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%A8%D0%B0%D0%B3%D0%B8%20%D0%BD%D0%B0%20%D0%BC%D0%B5%D1%81%D1%82%D0%B5.mp3',
          "program_2_ex_2_desc":
              "1. Встаньте прямо, руки по швам.\n2. Начинайте поочередно поднимать ноги, шагая на месте, следите за дыханием.",
          "program_2_ex_3_name": "Приседания с поворотом туловища",
          "program_2_ex_3_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%9F%D1%80%D0%B8%D1%81%D0%B5%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%20%D1%81%20%D0%BF%D0%BE%D0%B2%D0%BE%D1%80%D0%BE%D1%82%D0%BE%D0%BC%20%D1%82%D1%83%D0%BB%D0%BE%D0%B2%D0%B8%D1%89%D0%B0.mp3',
          "program_2_ex_3_desc":
              "1. Встаньте прямо, ноги на ширине плеч. \n2. Выполните приседание. Ваши колени не должны выходить вперед уровня стоп. \n3. Из этого положения выпрямитесь с поворотом направо, руки вверх. Вес на правой передней ноге, левая нога сзади на носке. \n4. Вернитесь в присед и выпрямитесь в другую сторону.",
          "program_2_ex_4_name": "Баланс",
          "program_2_ex_4_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%91%D0%B0%D0%BB%D0%B0%D0%BD%D1%81.mp3',
          "program_2_ex_4_desc":
              "1. Встаньте ровно, руки по швам. Поднимите правую ногу, согнув колено.\n2. Оставаясь на левой ноге, одновременно вытягивайте прямые руки вперед, а правую ногу назад.\n3. Задержитесь в этой позиции на какое-то время и вернитесь в исходное положение.\n4. Повторите с другой ноги.",
          "program_2_ex_5_name": "Поднятие таза из упора лежа на спине",
          "program_2_ex_5_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%9F%D0%BE%D0%B4%D0%BD%D1%8F%D1%82%D0%B8%D0%B5_%D1%82%D0%B0%D0%B7%D0%B0_%D0%B8%D0%B7_%D1%83%D0%BF%D0%BE%D1%80%D0%B0_%D0%BB%D0%B5%D0%B6%D0%B0_%D0%BD%D0%B0_%D1%81%D0%BF%D0%B8%D0%BD%D0%B5.mp3',
          "program_2_ex_5_desc":
              "1. Лягте на спину, ноги согнуты в коленях, стопы стоят на полу.\n2. Начинайте поднимать корпус, напрягая мышцы ягодиц и ног.\n3. Повторите 20 раз.",
          "program_3": "Свернуть горы",
          "program_3_ex_1_name": "Наклоны",
          "program_3_ex_1_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%9D%D0%B0%D0%BA%D0%BB%D0%BE%D0%BD%D1%8B.mp3',
          "program_3_ex_1_desc":
              "1. Встаньте прямо, ноги шире плеч. \n2. Выполняйте поочередные наклоны в разные стороны. Правая сторона рука, левая согнута на боку, наклон вправо. И наоборот.",
          "program_3_ex_2_name": "Прыжки",
          "program_3_ex_2_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%9F%D1%80%D1%8B%D0%B6%D0%BA%D0%B8.mp3',
          "program_3_ex_2_desc":
              "1. Встаньте прямо, ноги шире плеч, стопы развернуты в стороны. \n2. Выполните приседание с ровной спиной, руки вниз. \n3. Из этого положения выпрыгните вверх, руки на груди. \n4. Повторите несколько раз.",
          "program_3_ex_3_name": "Отжимания от пола",
          "program_3_ex_3_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%9E%D1%82%D0%B6%D0%B8%D0%BC%D0%B0%D0%BD%D0%B8%D1%8F%20%D0%BE%D1%82%20%D0%BF%D0%BE%D0%BB%D0%B0.mp3',
          "program_3_ex_3_desc":
              "1. Встаньте в планку с выпрямленными руками и ногами. \n2. Сгибая руки, выполните отжимание от пола. \n3. Повторите несколько раз. \n4. Если делать отжимания \nслишком тяжело, опустите колени на пол.",
          "program_3_ex_4_name": "Планка с поворотом туловища",
          "program_3_ex_4_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%9F%D0%BB%D0%B0%D0%BD%D0%BA%D0%B0%20%D1%81%20%D0%BF%D0%BE%D0%B2%D0%BE%D1%80%D0%BE%D1%82%D0%BE%D0%BC%20%D1%82%D1%83%D0%BB%D0%BE%D0%B2%D0%B8%D1%89%D0%B0.mp3',
          "program_3_ex_4_desc":
              "1. Встаньте в планку с выпрямленными руками и ногами. \n2. Поверните туловище вправо, вес на левой руке и ногах, правая рука вверх. \n3. Вернитесь в исходное положение и повторите в другую сторону.",
          "program_3_ex_5_name": "Кошечка",
          "program_3_ex_5_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%9A%D0%BE%D1%88%D0%B5%D1%87%D0%BA%D0%B0.mp3',
          "program_3_ex_5_desc":
              "1. Встаньте на четвереньки, колени под тазом, руки выпрямлены и находятся под плечами, спина прямая. \n2. На вдохе прогните спину, поднимая голову вверх. \n3. На выдохе округлите спину, раздвигая лопатки, подбородок к груди. \n4. Повторите несколько раз.",
          "program_4": "Здоровая шея",
          "program_4_ex_1_name": "Наклоны к плечам",
          "program_4_ex_1_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%9D%D0%B0%D0%BA%D0%BB%D0%BE%D0%BD%D1%8B%20%D0%BA%20%D0%BF%D0%BB%D0%B5%D1%87%D0%B0%D0%BC.mp3',
          "program_4_ex_1_desc":
              "1. Исходное положение голова прямо. \n2. Положите правую руку на левое ухо и позвольте голове тянуться к правому плечу, без лишнего дискомфорта. \n3. Повторите в другую сторону другой рукой.",
          "program_4_ex_2_name": "Наклоны вперед-назад",
          "program_4_ex_2_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%9D%D0%B0%D0%BA%D0%BB%D0%BE%D0%BD%D1%8B%20%D0%B2%D0%BF%D0%B5%D1%80%D0%B5%D0%B4-%D0%BD%D0%B0%D0%B7%D0%B0%D0%B4.mp3',
          "program_4_ex_2_desc":
              "1. Исходное положение голова прямо. \n2. Опустите голову на грудь и вернитесь в исходное положение. \n3. Опустите голову назад и верните в исходное положение. \n4. Повторите несколько раз.",
          "program_4_ex_3_name": "Поворот головы влево-вправо",
          "program_4_ex_3_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%9D%D0%B0%D0%BA%D0%BB%D0%BE%D0%BD%D1%8B%20%D0%B3%D0%BE%D0%BB%D0%BE%D0%B2%D1%8B%20%D0%B2%D0%BB%D0%B5%D0%B2%D0%BE-%D0%B2%D0%BF%D1%80%D0%B0%D0%B2%D0%BE.mp3',
          "program_4_ex_3_desc":
              "1. Исходное положение голова прямо. \n2. Начинайте поочередные плавные повороты головы вправо-влево.",
          "program_4_ex_4_name":
              "Полное вращение головой в одну и другую сторону",
          "program_4_ex_4_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%9F%D0%BE%D0%BB%D0%BD%D0%BE%D0%B5_%D0%B2%D1%80%D0%B0%D1%89%D0%B5%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BE%D0%BB%D0%BE%D0%B2%D0%BE%D0%B9_%D0%B2_%D0%BE%D0%B4%D0%BD%D1%83_%D0%B8_%D0%B4%D1%80%D1%83%D0%B3%D1%83%D1%8E_%D1%81%D1%82%D0%BE%D1%80%D0%BE%D0%BD%D1%83.mp3',
          "program_4_ex_4_desc":
              "1. Исходное положение голова прямо. \n2. Начинайте круговые вращения головой 3 раза в одну сторону, 3 раза в другую.",
          "program_4_ex_5_name": "Движение плечами вверх-вниз",
          "program_4_ex_5_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%94%D0%B2%D0%B8%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5%20%D0%BF%D0%BB%D0%B5%D1%87%D0%B0%D0%BC%D0%B8%20%D0%B2%D0%B2%D0%B5%D1%80%D1%85-%D0%B2%D0%BD%D0%B8%D0%B7.mp3',
          "program_4_ex_5_desc":
              "1. Встаньте в исходное положение: голова прямо, плечи расслаблены. \n2. Плавно поднимайте плечи к ушам и возвращайтесь в исходное положение.",
          "program_4_ex_6_name": "Скрещивание рук за спиной",
          "program_4_ex_6_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness_ru/%D0%A1%D0%BA%D1%80%D0%B5%D1%89%D0%B8%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5%20%D1%80%D1%83%D0%BA%20%D0%B7%D0%B0%20%D1%81%D0%BF%D0%B8%D0%BD%D0%BE%D0%B9.mp3',
          "program_4_ex_6_desc":
              "1. Встаньте в исходное положение: голова прямо, плечи расслаблены. \n2. Сомкните руки за спиной таким образом, чтобы одна была сверху, а вторая снизу. Почувствуйте вытяжение. \n3. Поменяйте руки и повторите еще раз.",
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
          "good_afternoon": "Добрый день,\n",
          "good_evening": "Добрый вечер,\n",
          "good_night": "Добрый ночи,\n",
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
          "reminders_page": "Напоминания",
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
          "buy_days": "Попробуйте @days дня бесплатно",
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
          "input_cat_name": "Введите название категории",
          "input_desc": "Введите описание",
          "player_voice": "Голос озвучки",
          "female": "Женский",
          "male": "Мужский",
          "language": "Язык",
          "x_minutes": "@x минут",
          "faq_desc":
              "<b>1. ПРИЛОЖЕНИЕ:</b><br><br>Для людей которые хотят <b>изменить свою жизнь, но не знают с чего начать.</b> <br><br><b>«Магическое утро»</b> зарядит энергией и поможет осознанно подойти к планированию своего дня.<br><br><b>2. «МАГИЧЕСКОЕ УТРО»:</b><br><br>Состоит из <b>6</b> блоков<br><br><b>Медитация</b> – поможет не спеша пробудить разум<br><br><b>Аффирмации</b> – заряжают разум положительными эмоциями<br><br><b>Визуализации</b> – позволяют точно представить желаемый успех<br><br><b>Фитнес</b> – заряжают ваше тело энергией<br><br><b>Чтение</b> – развивайтесь уже с самого утра! (особенно если не хватает времени вечером)<br><br><b>Дневник</b> - запомните что сделали и чему научились, запишите самые важные мысли<br><br><b>3. КАК ПОЛЬЗОВАТЬСЯ:</b><br><br>√ Начните с <b>«настроек»</b> там можно выставить:<br><br>- <b>Время </b>каждого из блоков<br><br>- <b>Последовательность</b> блоков<br><br>- <b>Аффирмацию</b> по умолчанию<br><br>- <b>Книгу</b> которую читаете<br><br> Настройки можно поменять в любое время.<br><br>√ Теперь Вы можете приступить к выполнению своего великолепного утра, нажав кнопку «Начать», всё будет проходить в соответствии с заданными настройками.<br><br><b>√ Прогресс будет показывать:</b><br><br>- <b>Время</b> по каждому дню<br><br>- <b>Количество</b> страниц прочитанных книг<br><br>- <b>Ваши</b> Аффирмации<br><br><b>4. ЕСЛИ ОСТАЛИСЬ ВОПРОСЫ:</b><br><br><a href='mailto:wonderfulmorningnow@gmail.com'>wonderfulmorningnow@gmail.com</a><br><br>с радостью отвечу на все ваши вопросы",
          "add_exercise": "Добавьте упражнение",
          "name": "Имя",
          "please_input_name": "Пожалуйста, введите Ваше имя",
          "delete_exercise": "Удалите упражнение",
          "delete_hint": "Зажмите и удерживайте\n что бы удалить",
          "your_exercise": "Ваше упражнение",
          "enter_your_exercise": "Введите своё упражнение",
          "add_permission": "Предоставьте разрешение для записи аудио",
          "yes": "Да",
          "no": "Нет",
          "other": "Другое",
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
              "Попробуйте в течение @days дней бесплатно, а затем цена составит @price в месяц. \n\nПодписку можно отменить в любой момент",
          "vip_price_card": "1 месяц",
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
          "purchase_page_title": "Открой для себя утро по новому",
          "purchase_page_desc": "@days дня бесплатно",
          "go_start_record": "Нажмите, чтобы начать запись",
          "go_stop_record": "Идёт запись, нажмите чтобы остановить",
          "empty_favorite_list": "У вас нет сохраненной музыки",
          "please_fill_all_fields": "Пожалуйста, заполните все поля",
          "question_1":
              "Давайте познакомимся. Расскажите немного о себе: возраст, пол, страну (по желанию)",
          "question_2": "Вам тяжело просыпаться по утрам?",
          "question_2_subquestion_1": "Если да, то почему?",
          "question_3":
              "Пользуетесь ли Вы приложениями для улучшения своего ментального и физического состояния?",
          "question_3_subquestion_1": "Если да, то какие?",
          "question_4":
              "Нравятся ли Вам наши бесплатные функции (медитации, аффирмации)?",
          "question_5": "Почему Вы выбрали именно наш продукт?",
          "question_6": "Что Вам было нужно, когда искали наш продукт?",
          "question_7": "Нашли то, что искали?",
          "question_8": "Какую пользу вы получаете от нашего приложения?",
          "question_9": "Какие функции Вам нужны?",
          "question_10":
              "Что бы Вы добавили? Что бы Вы убрали? Что бы Вы поменяли?",
          "question_11": "Стоит ли вводить дневные практики?",
          "question_11_subquestion_1":
              "Если да, то какие? (дыхание, дневной фитнес, дневные медитации)",
          "question_12": "Стоит ли вводить ночные практики?",
          "question_12_subquestion_1":
              "Если да, то какие? (звуки для сна, подготовка ко сну, чтение)",
          "question_13":
              "Приглашаем принять участие в интервью, оставьте, пожалуйста, свою электронную почту для дальнейшей связи ( по желанию укажите дополнительный канал связи)",
          "interview_dialog_text":
              "Привет! Хочешь 14 дней бесплатного пользования? \n\n Тогда пройди опрос и помоги нам сделать это приложение лучше!",
          "interview_dialog_text_vip":
              "Привет!  Спасибо, что используете полную версию приложения, Мы хотим сделать её лучше, поэтому будем благодарны за пройденный опрос.",
          "more_not_show": "Больше не показывать",
          "help_us": "Помочь нам",
          "thanks_to_interview":
              "Большое спасибо, мы обязательно к Вам прислушаемся!",
        },
        EN: {
          "thanks_to_interview":
              "Thank you very much, we will definitely listen to you!",
          "help_us": "Help us",
          "more_not_show": "Do not show again",
          "interview_dialog_text":
              "Hey! Do you want 14 days of free trial? \n\n Then take the survey and help us make this app better!",
          "interview_dialog_text_vip":
              "Hey! Thank you for using the full version of the application, We want to make it better, so we will be grateful for the survey we took.",
          "question_1":
              "Let's get acquainted. Tell me about yourself: age, gender, country (optional)",
          "question_2": "Is it hard for you to wake up in the morning?",
          "question_2_subquestion_1": "If so, why?",
          "question_3":
              "Do you use apps to improve your mental and physical health?",
          "question_3_subquestion_1": "If so, what?",
          "question_4": "Do you like our free features?",
          "question_5": "Why did you choose our product?",
          "question_6":
              "What did you need when you were looking for our product?",
          "question_7": "Did you find what you were looking for?",
          "question_8": "What benefits do you get from our app?",
          "question_9": "What functions do you need?",
          "question_10":
              "What would you add? What would you remove? What would you change?",
          "question_11":
              "In your opinion, is it good idea to introduce day practices?",
          "question_11_subquestion_1":
              "If so, what? (breathing, daytime fitness)",
          "question_12":
              "In your opinion, is it good idea to introduce night practices",
          "question_12_subquestion_1":
              "If so, what? (sleep sounds, sleep preparation)",
          "question_13":
              "If you would like to participate in an interview with us, please leave your e-mail for further communication",
          "please_fill_all_fields": "Please fill in all fields",
          "start_input": "Start writing ...",
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
          "awareness_meter": "Awareness\nmeter",
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
          "program_1": "Yoga. “Sun Salutation - Surya Namaskar”",
          "program_1_ex_1_name": "Hasta Uttanasana",
          "program_1_ex_1_desc":
              "•	Stand erect and raise both the hands above the head. Let there be shoulders length between the two arms.\n•	Raising the arms and bending the trunk backwards is done at the same time. Breathe in deeply while raising the arms. \n•	Stand back to the starting position.",
          "program_1_ex_1_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Hasta%20Uttanasana.mp3',
          "program_1_ex_2_name": "Uttanasana",
          "program_1_ex_2_desc":
              "•	Stand up tall and take a deep breath\n•	On an exhalation, extend your torso down.\n•	Stay long throughout your neck without rounding your back.",
          "program_1_ex_2_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Uttanasana.mp3',
          "program_1_ex_3_name": "Ashwa Sanchalanasana",
          "program_1_ex_3_desc":
              "•	Get in the downward face dog pose.\n•	Exhale and bring your right knee toward your nose. Keep your right knee bent at a 90-degree angle\n•	Raise your arms towards the sky, lower your left knee down and slide the right knee back into the Table position, or alternatively step the right foot back into Downward Facing Dog.  ",
          "program_1_ex_3_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Ashwa%20Sanchalanasana.mp3',
          "program_1_ex_4_name": "Adho Mukha Svanasana",
          "program_1_ex_4_desc":
              "•	Set up on all fours with your hands about 3 inches ahead of your shoulders and shoulder-width apart.\n•	Inhale. Exhale and get in the downward-facing dog pose. Press down firmly with your fingertips to pull your forearms toward the front of the room. You can bend your knees.\n•	Go back in the starting position.​",
          "program_1_ex_4_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Adho%20Mukha%20Svanasana.mp3',
          "program_1_ex_5_name": "Bhujangasana",
          "program_1_ex_5_desc":
              "1. Lie down flat on your stomach.\n2. Place your palms flat on the ground directly under your shoulders\n3. Inhale to lift your chest off the floor. Keep your buttocks and legs stretched.",
          "program_1_ex_5_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Bhujangasana.mp3',
          "program_1_ex_6_name": "Gomukhasana",
          "program_1_ex_6_desc":
              "Begin in a seated cross-legged position as it is in the picture\n•	Inhale and bring your arms straight up toward the ceiling. Exhale and clasp hands behind your back.\n•	Get back in the starting position and alternate your legs and arms. ",
          "program_1_ex_6_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Gomukhasana.mp3',
          "program_2": "Good spirits",
          "program_2_ex_1_name": "Walk-in-Place",
          "program_2_ex_1_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Walk-in-Place.mp3',
          "program_2_ex_1_desc":
              "•	Stand upright, arms at side \n•	Lift right leg, lower right leg; lift left leg, lower left leg",
          "program_2_ex_2_name": "Standing Side Bend",
          "program_2_ex_2_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Standing%20Side%20Bend.mp3',
          "program_2_ex_2_desc":
              "	•	Stand tall with feet and legs shoulder width apart.\n•	Lower your right arm down the right side of your body and exhale as you lengthen the left arm over the head, bending body gently to the right. Exhale as you repeat on the left side.",
          "program_2_ex_3_name": "Squats with body-rotation",
          "program_2_ex_3_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Squats%20with%20body-rotation.mp3',
          "program_2_ex_3_desc":
              "•	Stand straight with feet shoulder width apart. \n•	Do a squat. \n•	Then, drive through heels to stand up, lifting arms overhead to the right. Transfer the weight to the right feet, left feet on raised toes. \n•	Bend knees into a squat, stand up to a different side.​",
          "program_2_ex_4_name": "Balance",
          "program_2_ex_4_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Balance.mp3',
          "program_2_ex_4_desc":
              "	•	Stand upright, arms at side. Take the right leg up and bend it.​ \n•	Stand on the left leg stretch your hands upfront and lift your left leg behind you. ​\n•	Hold the position for some time and stand straight. \n•	Replace the legs. ",
          "program_2_ex_5_name": "Bridge",
          "program_2_ex_5_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Bridge.mp3',
          "program_2_ex_5_desc":
              "•	Lie on your back with your hands at your sides, knees bent, and feet flat on the floor under your knees. \n•	Raise your hips to create a straight line from your knees to shoulders. Tighten your abdominal and buttock muscles \n•	Complete at least 20 reps.​",
          "program_3": "Move mountains",
          "program_3_ex_1_name": "Standing Side Bends ",
          "program_3_ex_1_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Standing%20Side%20Bend.mp3',
          "program_3_ex_1_desc":
              "	•	Stand tall with feet and legs shoulder width apart. \n•	Put your right arm the right hip and exhale as you lengthen the left arm over the head, bending body gently to the right. Exhale as you repeat on the left side.",
          "program_3_ex_2_name": "Squats with Jumps",
          "program_3_ex_2_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Squats%20with%20Jumps.mp3',
          "program_3_ex_2_desc":
              "	•	Stand with heels wider than shoulder-distance apart, toes turned out slightly \n•	Bend at knees, sit hips back, and lower down into a squat, dropping arms down to touch floor between legs. \n•	Then, drive through heels to jump up, holding hands crossed on the chest. \n•	Perform some reps.​",
          "program_3_ex_3_name": "Pushups",
          "program_3_ex_3_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Pushups.mp3',
          "program_3_ex_3_desc":
              "	•	Start in a standard push-up position \n•	Bend your elbows \n•	Perform some reps.​ \n•	If it is too difficult step your knees back behind and do the exercise. ",
          "program_3_ex_4_name": "Plank Twists",
          "program_3_ex_4_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Plank%20Twists.mp3',
          "program_3_ex_4_desc":
              "	•	Start in a plank position. \n•	Pull your belly button in towards your spine as firm as you can. \n•	Then begin to raise your chest and one arm towards the ceiling. \n•	Return back to plank. Repeat on the other side",
          "program_3_ex_5_name": "Cats Dogs exercise",
          "program_3_ex_5_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Cats%20Dogs%20exercise.mp3',
          "program_3_ex_5_desc":
              "	•	Get down on all fours with your weight evenly distributed. Knees under your hips. Your head and neck in a straight line with your spine. \n•	Inhale and lift your head until you’re looking forwards. \n•	Exhale and pull your belly button to your spine, bring your hips forwards. Tuck your chin into your chest. \n•	Repeat for the desired number of repetitions.",
          "program_4": "Healthy Neck",
          "program_4_ex_1_name": "Side Tilt",
          "program_4_ex_1_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Side%20Tilt.mp3',
          "program_4_ex_1_desc":
              "•	Hold your head straight. \n•	Put your right hand on the left ear and gently bend your head to the right shoulder, stop if you feel discomfort. \n•	Change hands. ",
          "program_4_ex_2_name": "Forward and Backward Tilt",
          "program_4_ex_2_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Forward%20and%20Backward%20Tilt.mp3',
          "program_4_ex_2_desc":
              "•	Start with your head and back straight. \n•	Lower your chin toward your chest and get back to the start position. \n•	Tilt your chin up toward the ceiling and bring the base of your skull toward your back. \n•	Repeat the set several times.",
          "program_4_ex_3_name": "Side Rotation",
          "program_4_ex_3_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Side%20Rotation.mp3',
          "program_4_ex_3_desc":
              "•	Keep your head squarely over your shoulders and your back straight. \n•	Slowly turn your head to the right and left until you feel a stretch in the side of your neck and shoulder.",
          "program_4_ex_4_name": "Head rotation",
          "program_4_ex_4_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Head%20rotation.mp3',
          "program_4_ex_4_desc":
              "•	Sit or stand with your head and back straight. \n•	Rotate your head clockwise and counter clockwise 3 times.",
          "program_4_ex_5_name": "Shoulders rotation",
          "program_4_ex_5_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Shoulders%20rotation.mp3',
          "program_4_ex_5_desc":
              "•	Place your legs at shoulder-width, keep your arms relaxed. \n•	Gently perform both shoulders rotation clockwise and counter clockwise.",
          "program_4_ex_6_name": "Cow Face Pose",
          "program_4_ex_6_audio":
              'https://storage.yandexcloud.net/myaudio/Fitness/Cow%20Face%20Pose.mp3',
          "program_4_ex_6_desc":
              "•	Stand straight, keep your shoulders relaxed. \n•	Clasp hands behind your back, so one arm is up, another is down. Feel the stretch. \n•	Change hands and do again. ",
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
          "fitness": "FITNESS",
          "fitness_title":
              "Prepare for exercises which\n will restore your physical\n health",
          "good_morning": "Good morning,\n",
          "good_afternoon": "Good afternoon,\n",
          "good_evening": "Good evening,\n",
          "good_night": "Good night,\n",
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
          "reminders_page": "Reminders",
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
          "buy_days": "Try @days days for free",
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
          "input_cat_name": "Input category name",
          "input_desc": "Input a description",
          "player_voice": "Voice",
          "female": "Female",
          "male": "Male",
          "language": "Language",
          "x_minutes": "@x minutes",
          "faq_desc":
              "<b>1. APPENDIX: </b><br> <br> For people who want to <b> change their lives, but don't know where to start. </b><br><br><b>«Magic Morning» </b> will energize and help you to consciously plan your day. <br> <br> <b>2. «MAGIC MORNING»: </b><br> <br> Consists of <b> 6 </b> blocks <br> <br> <b>Meditation </b> - will help to slowly awaken the mind <br> <br> <b>Affirmations </b> - charge the mind with positive emotions <br> <br> <b>Visualizations</b> - allow you to accurately represent the desired success <br> <br> <b>Fitness</b> - charge your body with energy <br> <br> <b>Reading</b> - develop from the very morning! (especially if there is not enough time in the evening) <br> <br> <b>Diary </b> - remember what you did and what you learned, write down the most important thoughts <br> <br> <b>3. HOW TO USE:</b> <br> <br>√ Start with <b> «settings»</b> there you can set: <br> <br>- <b>Time </b> of each block <br> <br>- <b>Sequence </b> blocks <br> <br> - <b> Default Affirmation </b> <br> <br> - <b>The book</b> you are reading <br> <br> Settings can be changed at any time. <br> <br> √ Now you can start making your great morning by clicking the <b> «Start» </b> button, everything will go according to the specified settings. <br> <br> <b>√ Progress will show:</b> <br> <br> - <b>Time</b> for each day <br> <br> - <b>Number</b> of pages of books read <br> <br> - <b>Yours</b>Affirmations <br> <br> <b>4. IF YOU HAVE ANY QUESTIONS:</b> <br> <br> <a href='mailto:wonderfulmorningnow@gmail.com'>wonderfulmorningnow@gmail.com</a> <br><br>I will gladly answer all your questions",
          "add_exercise": "Add exercise",
          "name": "Name",
          "please_input_name": "Please enter your name",
          "delete_exercise": "Delete exercise",
          "delete_hint": "Clamp and hold\n to delete",
          "your_exercise": "Your exercise",
          "enter_your_exercise": "Enter your exercise",
          "add_permission": "Grant permission to record audio",
          "yes": "Yes",
          "no": "No",
          "other": "Other",
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
              "Try it for @days days for free and then the price will be @price per month. \n\nYou can cancel your subscription at any time",
          "vip_price_card": "1 month",
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
          "purchase_page_title": "Discover the morning in a new way",
          "purchase_page_desc": "@days days free",
          "go_start_record": "Click to start recording",
          "go_stop_record": "Recording in progress, click to stop",
          "empty_favorite_list": "You have no saved music",
        }
      };

  static Future<Locale> getInitialLocale() async {
    String _langCode = await MyDB()
        .getBox()
        .get(LOCALIZATION_KEY, defaultValue: Get.deviceLocale.languageCode);
    return Locale(_langCode);
  }

  static void switchLocale(String newLangCode) {
    final _newLocale = Locale(newLangCode);
    Get.updateLocale(_newLocale);
    MyDB().getBox().put(LOCALIZATION_KEY, newLangCode);
  }
}
