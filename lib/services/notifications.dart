import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/utils.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class PushNotifications {
  PushNotifications() {
    _initLocalPush();
  }

  // Consts
  static const int pushIdTreaning = 1;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  String selectedNotificationPayload;

  /// Streams are created so that app can respond to notification-related events
  /// since the plugin is initialised in the `main` function
  final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();

  final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();

  MethodChannel platform = const MethodChannel('dexterx.dev/flutter_local_notifications_example');

  Future<void> _initLocalPush() async {
    await configureLocalTimeZone();

    final NotificationAppLaunchDetails notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    // String initialRoute = AppRouting.initialRoute;
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload = notificationAppLaunchDetails.notificationResponse.payload;
      // initialRoute = AppRouting.initialRoute;
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {
          didReceiveLocalNotificationSubject
              .add(ReceivedNotification(id: id, title: title, body: body, payload: payload));
        });
    const DarwinInitializationSettings initializationSettingsMacOS = DarwinInitializationSettings(
        requestAlertPermission: false, requestBadgePermission: false, requestSoundPermission: false);
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) async {
      if (response.payload != null) {
        debugPrint('notification payload: ${response.payload}');
      }
      selectedNotificationPayload = response.payload;
      selectNotificationSubject.add(response.payload);
    });
    // Запрос уже показывало, но на всякий случай запросим принудительно еще раз
    if (GetPlatform.isIOS) pushNotifications.requestPermissions();
  }

  Future<void> configureLocalTimeZone() async {
    const MethodChannel platform = MethodChannel('dexterx.dev/flutter_local_notifications_example');
    tz.initializeTimeZones();

    // final String timeZoneName =
    //     await platform.invokeMethod<String>('getTimeZoneName');
    // tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  void requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> sendNotificationWithSleep(String title, String msg, int secondsSleep, {int id = 0}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'My Morning',
        "meditation is complete".tr,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: secondsSleep)),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            channelDescription: 'your channel description',
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
    print('Добавили пуш, сработает через $secondsSleep sec');
  }

  Future<void> sendWeekleRepeat(String title, String msg, DateTime dateTime, {int id = 0}) async {
    print('Добавили еженедельный пуш id $id начиная с $dateTime');

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        msg,
        tz.TZDateTime.from(dateTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            channelDescription: 'your channel description',
          ),
        ),
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> deleteNotification(int id) async {
    print('Удалили локальный пуш id $id');
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}

class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

PushNotifications pushNotifications;
