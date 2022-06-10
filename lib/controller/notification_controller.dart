import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationController extends GetxController {
  static final NotificationController _notificationService =
      NotificationController._internal();

  factory NotificationController() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final onNotifications = BehaviorSubject<String?>();

  NotificationController._internal();

  Future<void> initNotification() async {
    tz.initializeTimeZones();
    try {
      var _locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(_locationName));
    } catch (e) {
      print('Could not get the local timezone');
    }

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_launcher_foreground');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    //when app is closed
    final details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.payload);
    }

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });
  }

  Future<void> showScheduledNotificationFood({
    int id = 0,
    required String title,
    required String body,
    required String payload,
    required int hours,
    int? minutes,
    int? seconds,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _scheduleDaily(Time(hours, minutes ?? 0, seconds ?? 0)),
      const NotificationDetails(
        android: AndroidNotificationDetails('main_channel', 'Main Channel',
            channelDescription: 'Main channel notifications',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/ic_launcher_foreground'),
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  // Future<void> showScheduledNotificationMakanSiang({
  //   int id = 0,
  //   required String title,
  //   required String body,
  //   required String payload,
  //   required int hours,
  //   int? minutes,
  //   int? seconds,
  // }) async {
  //   // final sound = 'notification_sound.wav';
  //   // sound.split('.').first
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     id,
  //     title,
  //     body,
  //     _scheduleDaily(Time(hours, minutes ?? 0, seconds ?? 0)),
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails('main_channel', 'Main Channel',
  //           channelDescription: 'Main channel notifications',
  //           importance: Importance.max,
  //           priority: Priority.max,
  //           playSound: true,
  //           // sound: RawResourceAndroidNotificationSound('notification_sound'),
  //           enableVibration: false,
  //           icon: '@drawable/ic_launcher_foreground'),
  //       iOS: IOSNotificationDetails(
  //         sound: 'default.wav',
  //         presentAlert: true,
  //         presentBadge: true,
  //         presentSound: true,
  //       ),
  //     ),
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //     androidAllowWhileIdle: true,
  //     matchDateTimeComponents: DateTimeComponents.time,
  //     payload: payload,
  //   );
  // }

  // Future<void> showScheduledNotificationMakanMalam({
  //   int id = 0,
  //   required String title,
  //   required String body,
  //   required String payload,
  //   required String channelId,
  //   required String channelName,
  //   required int hours,
  //   required int minutes,
  //   int? seconds,
  // }) async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     id,
  //     title,
  //     body,
  //     _scheduleDaily(Time(hours, minutes, seconds ?? 0)),
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(channelId, channelName,
  //           channelDescription: 'Main channel notifications',
  //           importance: Importance.max,
  //           priority: Priority.max,
  //           icon: '@drawable/ic_launcher_foreground'),
  //       iOS: IOSNotificationDetails(
  //         sound: 'default.wav',
  //         presentAlert: true,
  //         presentBadge: true,
  //         presentSound: true,
  //       ),
  //     ),
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //     androidAllowWhileIdle: true,
  //     matchDateTimeComponents: DateTimeComponents.time,
  //     payload: payload,
  //   );
  // }

  Future<void> showScheduledFluid({
    int id = 0,
    required String title,
    required String body,
    required String payload,
    required String channelId,
    required String channelName,
    required int hours,
    required int minutes,
    int? seconds,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _scheduleDaily(Time(hours, minutes, seconds ?? 0)),
      NotificationDetails(
        android: AndroidNotificationDetails(channelId, channelName,
            channelDescription: 'Main channel notifications',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/ic_launcher_foreground'),
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);

    final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(Duration(days: 1))
        : scheduledDate;
  }

  void cancel(int id) {
    flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  //getX stuff
  final data = GetStorage('myData');
  int? hourSarapan = 7;
  int? minuteSarapan = 00;
  int? hourMakanSiang = 14;
  int? minuteMakanSiang = 00;
  int? hourMakanMalam = 17;
  int? minuteMakanMalam = 00;
  void rememberNotificationFood(String? session) {
    if (session != null) {
      if (session == 'Sarapan') {
        if (data.read('dataNotificationFoodSarapan') != null) {
          print('dataNotificationFoodSarapan dihapus');
          data.remove('dataNotificationFoodSarapan');
          data.write('dataNotificationFoodSarapan', {
            'hour': hourSarapan,
            'minute': minuteSarapan,
          });
        } else {
          data.write('dataNotificationFoodSarapan', {
            'hour': hourSarapan,
            'minute': minuteSarapan,
          });
        }
      } else if (session == 'Makan Siang') {
        if (data.read('dataNotificationFoodMakanSiang') != null) {
          print('dataNotificationFoodMakanSiang dihapus');
          data.remove('dataNotificationFoodMakanSiang');
          data.write('dataNotificationFoodMakanSiang', {
            'hour': hourMakanSiang,
            'minute': minuteMakanSiang,
          });
        } else {
          data.write('dataNotificationFoodMakanSiang', {
            'hour': hourMakanSiang,
            'minute': minuteMakanSiang,
          });
        }
      } else {
        if (data.read('dataNotificationFoodMakanMalam') != null) {
          print('dataNotificationFoodMakanMalam dihapus');
          data.remove('dataNotificationFoodMakanMalam');
          data.write('dataNotificationFoodMakanMalam', {
            'hour': hourMakanMalam,
            'minute': minuteMakanMalam,
          });
        } else {
          data.write('dataNotificationFoodMakanMalam', {
            'hour': hourMakanMalam,
            'minute': minuteMakanMalam,
          });
        }
      }
    } else {
      print('session null');
    }
  }

  void notificationFoodSarapan(id) {
    //1
    showScheduledNotificationFood(
      id: id,
      title: 'Sarapan',
      body: 'Hari ini Sarapan jam 7, yuk cari menu di sirkadian!',
      payload: 'Sarapan',
      hours: data.read('dataNotificationFoodSarapan')['hour'] ?? hourSarapan,
      minutes:
          data.read('dataNotificationFoodSarapan')['minute'] ?? minuteSarapan,
      seconds: 00,
    );
  }

  void notificationFoodMakanSiang(id) {
    //2
    print(id);
    showScheduledNotificationFood(
      id: id,
      title: 'Makan Siang',
      body: 'Hari ini Makan Siang jam 12, yuk cari menu di sirkadian!',
      payload: 'Makan Siang',
      hours:
          data.read('dataNotificationFoodMakanSiang')['hour'] ?? hourMakanSiang,
      minutes: data.read('dataNotificationFoodMakanSiang')['hour'] ??
          minuteMakanSiang,
      seconds: 00,
    );
  }

  void notificationFoodMakanMalam(id) {
    //3
    showScheduledNotificationFood(
      id: id,
      title: 'Makan Malam',
      body: 'Hari ini Makan Malam jam 5, yuk cari menu di sirkadian!',
      payload: 'Makan Malam',
      hours:
          data.read('dataNotificationFoodMakanMalam')['hour'] ?? hourMakanMalam,
      minutes: data.read('dataNotificationFoodMakanMalam')['hour'] ??
          minuteMakanMalam,
      seconds: 00,
    );
  }

  void notificationFluidList() {
    // showScheduledMinum(
    //     title: "Reminder Minum",
    //     body: 'Jangan lupa minum dan catat di aplikasi Sirkadian',
    //     payload: 'minum',
    //     hours: 7,
    //     minutes: 00,
    //     seconds: 00,
    //     id: 4);

    // showScheduledMinum(
    //     title: "Reminder Minum",
    //     body: 'Jangan lupa minum dan catat di aplikasi Sirkadian',
    //     payload: 'minum',
    //     hours: 11,
    //     minutes: 00,
    //     seconds: 00,
    //     id: 5);
    // showScheduledMinum(
    //     title: "Reminder Minum",
    //     body: 'Jangan lupa minum dan catat di aplikasi Sirkadian',
    //     payload: 'minum',
    //     hours: 15,
    //     minutes: 00,
    //     seconds: 00,
    //     id: 6);
    // showScheduledMinum(
    //     title: "Reminder Minum",
    //     body: 'Jangan lupa minum dan catat di aplikasi Sirkadian',
    //     payload: 'minum',
    //     hours: 19,
    //     minutes: 00,
    //     seconds: 00,
    //     id: 7);
  }
}
