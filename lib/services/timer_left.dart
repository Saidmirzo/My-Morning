import 'dart:async';
import 'dart:isolate';

// import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'notifications.dart';

class TimerLeftController extends GetxController {
  Isolate _isolate;
  ReceivePort _receivePort;
  DateTime appLeftTime;
  int leftSecondsBeforePauseApp = -1;

  var _isolateTime = -1;

  Timer _timer;
  Function _onPlayPause;

  void onAppLeft(Timer timer, int time,
      {Function onPlayPause, AudioPlayer player}) async {
    _timer = timer;
    _onPlayPause = onPlayPause;
    print('До завершения таймера осталось $time c.');
    leftSecondsBeforePauseApp = time;
    // Уведомим о заверщении упражнения через N оставшихся секунд
    if (time > 0 && _timer.isActive) {
      appLeftTime = DateTime.now();
      pushNotifications.sendNotificationWithSleep(
          'push_success'.tr, 'action_completed'.tr, time,
          id: PushNotifications.pushIdTreaning);
      if (GetPlatform.isAndroid) {
        // На андроид пуш не показывает на заблокированном экране
        // По этому запустим наш звук завершения, чтобы привлечь внимание
        _startIsolate(time, player);
      }
    } else {
      print('Пропускаем запуск изолятора т.к. таймер уже неактивен');
    }
  }

  void onAppResume(Timer timer, RxInt _time, RxInt passedSec) async {
    int val =
        DateTime.now().difference(appLeftTime ?? DateTime.now()).inSeconds;
    print('Разница: $val сек');
    if (leftSecondsBeforePauseApp > 0) {
      _time.value =
          val > leftSecondsBeforePauseApp ? 0 : leftSecondsBeforePauseApp - val;
      passedSec.value +=
          val > leftSecondsBeforePauseApp ? leftSecondsBeforePauseApp : val;
    }
    pushNotifications.deleteNotification(PushNotifications.pushIdTreaning);
    _stopIsolate();
    if (_onPlayPause != null) _onPlayPause();
  }

  void _startIsolate(int tm, AudioPlayer player) async {
    _isolateTime = tm;
    print('Запускаем изолятор на $tm sec');
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(
        waitAndNotifyInBg, IsolateData(_receivePort.sendPort, tm));
    _receivePort.listen((dynamic val) {
      print('RECEIVED: $val');
      _isolateTime -= periodic;
      if (_isolateTime <= 0) {
        _stopIsolate();
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      }
    }, onDone: () {
      print('onDone');
      // Проверка чтобы не срабатывало уведомление
      // если мы вернулись до окончания таймера и отменили изолятор вручную
      if (_isolate == null) {
        notifyInBackground();
        player.stop();
        // Запускаем таймер
      }
    });
    // Останавливаем таймер
    if (_onPlayPause != null && _timer.isActive) _onPlayPause();
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

  // void _isolateHandleMessage(dynamic val) {
  //   print('RECEIVED: $val');
  //   _isolateTime -= periodic;
  //   if (_isolateTime <= 0) {
  //     _stopIsolate();
  //     //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //   }
  // }

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
