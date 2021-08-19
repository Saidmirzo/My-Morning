import 'dart:async';
import 'dart:isolate';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'notifications.dart';

class TimerLeftController extends GetxController {
  Isolate _isolate;
  ReceivePort _receivePort;
  DateTime appLeftTime;
  int leftSecondsBeforePauseApp = -1;

  var _isolateTime = -1;

  void onAppLeft(Timer timer, int time) async {
    print('До завершения таймера осталось $time c.');
    leftSecondsBeforePauseApp = time;
    // Уведомим о заверщении упражнения через N оставшихся секунд
    if (time > 0 && timer.isActive) {
      appLeftTime = DateTime.now();
      pushNotifications.sendNotificationWithSleep(
          'push_success'.tr, 'action_completed'.tr, time,
          id: PushNotifications.pushIdTreaning);
      if (GetPlatform.isAndroid) {
        // На андроид пуш не показывает на заблокированном экране
        // По этому запустим наш звук завершения, чтобы привлечь внимание
        _startIsolate(time);
      }
    } else {
      print('Пропускаем запуск изолятора т.к. таймер уже неактивен');
    }
  }

  void onAppResume(Timer timer, RxInt _time) async {
    int val =
        DateTime.now().difference(appLeftTime ?? DateTime.now()).inSeconds;
    print('Разница: $val сек');
    if (timer.isActive && leftSecondsBeforePauseApp > 0)
      _time.value = leftSecondsBeforePauseApp - val;
    pushNotifications.deleteNotification(PushNotifications.pushIdTreaning);
    _stopIsolate();
  }

  void _startIsolate(int tm) async {
    _isolateTime = tm;
    print('Запускаем изолятор на $tm sec');
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(
        waitAndNotifyInBg, IsolateData(_receivePort.sendPort, tm));
    _receivePort.listen(_isolateHandleMessage, onDone: () {
      print('onDone');
      // Проверка чтобы не срабатывало уведомление
      // если мы вернулись до окончания таймера и отменили изолятор вручную
      if (_isolate == null) notifyInBackground();
    });
  }

  void notifyInBackground() async {
    print('notifyInBackground');
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.setAsset("assets/audios/success.mp3");
    await audioPlayer.play();
  }

  static const periodic = 5;
  static void waitAndNotifyInBg(IsolateData data) async {
    print('leftSecondsBeforePauseApp : ${data.time}');
    Timer.periodic(periodic.seconds, (Timer t) {
      data.sendPort.send('recive ${DateTime.now()}');
    });
  }

  void _isolateHandleMessage(dynamic val) {
    print('RECEIVED: $val');
    _isolateTime -= periodic;
    if (_isolateTime <= 0) _stopIsolate();
  }

  void _stopIsolate() {
    if (_isolate != null) {
      print('_stopIsolate');
      _receivePort.close();
      _isolate.kill(priority: Isolate.immediate);
      _isolate = null;
    }
  }
}

class IsolateData {
  SendPort sendPort;
  int time;
  IsolateData(this.sendPort, this.time);
}
