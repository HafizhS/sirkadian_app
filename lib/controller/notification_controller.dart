import 'package:flutter/material.dart';
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
    required int minutes,
    int? seconds,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _scheduleDaily(Time(hours, minutes, seconds ?? 0)),
      const NotificationDetails(
        android: AndroidNotificationDetails('food_channel', 'food channel',
            channelDescription: 'food channel notifications',
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

  Future<void> showScheduledNotificationFoodMuted({
    int id = 0,
    required String title,
    required String body,
    required String payload,
    required int hours,
    required int minutes,
    int? seconds,
  }) async {
    // final sound = 'notification_sound.wav';
    // sound.split('.').first
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _scheduleDaily(Time(hours, minutes, seconds ?? 0)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'food_channel_muted', 'food channel muted',
            channelDescription: 'food channel notifications muted',
            importance: Importance.min,
            priority: Priority.min,
            playSound: false,
            // sound: RawResourceAndroidNotificationSound('notification_sound'),
            enableVibration: false,
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

  Future<void> showScheduledNotificationFluid({
    int id = 0,
    required String title,
    required String body,
    required String payload,
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
        android: AndroidNotificationDetails('fluid_channel', 'fluid channel',
            channelDescription: 'fluid channel notifications',
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

  Future<void> showScheduledNotificationFluidMuted({
    int id = 0,
    required String title,
    required String body,
    required String payload,
    required int hours,
    required int minutes,
    int? seconds,
  }) async {
    // final sound = 'notification_sound.wav';
    // sound.split('.').first
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _scheduleDaily(Time(hours, minutes, seconds ?? 0)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'fluid_channel_muted', 'fluid channel muted',
            channelDescription: 'fluid channel notifications muted',
            importance: Importance.min,
            priority: Priority.min,
            playSound: false,
            // sound: RawResourceAndroidNotificationSound('notification_sound'),
            enableVibration: false,
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

  void cancelNotification(int id) {
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
  int? hourMakanMalam = 19;
  int? minuteMakanMalam = 00;
  bool isSoundSarapan = true;
  bool isSoundMakanSiang = true;
  bool isSoundMakanMalam = true;
  TimeOfDay timeOfDaySarapan = TimeOfDay(hour: 7, minute: 00);
  TimeOfDay timeOfDayMakanSiang = TimeOfDay(hour: 14, minute: 00);
  TimeOfDay timeOfDayMakanMalam = TimeOfDay(hour: 19, minute: 00);
  void rememberNotificationFood(String? session) {
    if (session != null) {
      if (session == 'Sarapan') {
        if (data.read('dataNotificationFoodSarapan') != null) {
          print('dataNotificationFoodSarapan dihapus');
          data.remove('dataNotificationFoodSarapan');
          data.write('dataNotificationFoodSarapan', {
            'hour': hourSarapan,
            'minute': minuteSarapan,
            'sound': isSoundSarapan,
          });
        } else {
          data.write('dataNotificationFoodSarapan', {
            'hour': hourSarapan,
            'minute': minuteSarapan,
            'sound': isSoundSarapan,
          });
        }
      } else if (session == 'Makan Siang') {
        if (data.read('dataNotificationFoodMakanSiang') != null) {
          print('dataNotificationFoodMakanSiang dihapus');
          data.remove('dataNotificationFoodMakanSiang');
          data.write('dataNotificationFoodMakanSiang', {
            'hour': hourMakanSiang,
            'minute': minuteMakanSiang,
            'sound': isSoundMakanSiang,
          });
        } else {
          data.write('dataNotificationFoodMakanSiang', {
            'hour': hourMakanSiang,
            'minute': minuteMakanSiang,
            'sound': isSoundMakanSiang,
          });
        }
      } else {
        if (data.read('dataNotificationFoodMakanMalam') != null) {
          print('dataNotificationFoodMakanMalam dihapus');
          data.remove('dataNotificationFoodMakanMalam');
          data.write('dataNotificationFoodMakanMalam', {
            'hour': hourMakanMalam,
            'minute': minuteMakanMalam,
            'sound': isSoundMakanMalam,
          });
        } else {
          data.write('dataNotificationFoodMakanMalam', {
            'hour': hourMakanMalam,
            'minute': minuteMakanMalam,
            'sound': isSoundMakanMalam,
          });
        }
      }
    } else {
      print('session null');
    }
  }

  void notificationFoodSarapan(id, sound) {
    //1
    if (sound == true) {
      cancelNotification(id);
      showScheduledNotificationFood(
        id: id,
        title: 'Sarapan',
        body:
            'Hari ini Sarapan jam ${data.read('dataNotificationFoodSarapan') != null ? data.read('dataNotificationFoodSarapan')['hour'] : hourSarapan}:${data.read('dataNotificationFoodSarapan') != null ? data.read('dataNotificationFoodSarapan')['minute'] : minuteSarapan}, yuk cari menu di sirkadian!',
        payload: 'Sarapan',
        hours: data.read('dataNotificationFoodSarapan') != null
            ? data.read('dataNotificationFoodSarapan')['hour']
            : hourSarapan,
        minutes: data.read('dataNotificationFoodSarapan') != null
            ? data.read('dataNotificationFoodSarapan')['minute']
            : minuteSarapan,
        seconds: 00,
      );
    } else {
      cancelNotification(id);
      showScheduledNotificationFoodMuted(
        id: id,
        title: 'Sarapan',
        body:
            'Hari ini Sarapan jam ${data.read('dataNotificationFoodSarapan') != null ? data.read('dataNotificationFoodSarapan')['hour'] : hourSarapan}:${data.read('dataNotificationFoodSarapan') != null ? data.read('dataNotificationFoodSarapan')['minute'] : minuteSarapan}, yuk cari menu di sirkadian!',
        payload: 'Sarapan',
        hours: data.read('dataNotificationFoodSarapan') != null
            ? data.read('dataNotificationFoodSarapan')['hour']
            : hourSarapan,
        minutes: data.read('dataNotificationFoodSarapan') != null
            ? data.read('dataNotificationFoodSarapan')['minute']
            : minuteSarapan,
        seconds: 00,
      );
    }
  }

  void notificationFoodMakanSiang(id, sound) {
    //2
    if (sound == true) {
      cancelNotification(id);
      showScheduledNotificationFood(
        id: id,
        title: 'Makan Siang',
        body:
            'Hari ini Makan Siang jam ${data.read('dataNotificationFoodMakanSiang') != null ? data.read('dataNotificationFoodMakanSiang')['hour'] : hourMakanSiang}:${data.read('dataNotificationFoodMakanSiang') != null ? data.read('dataNotificationFoodMakanSiang')['minute'] : minuteMakanSiang} , yuk cari menu di sirkadian!',
        payload: 'Makan Siang',
        hours: data.read('dataNotificationFoodMakanSiang') != null
            ? data.read('dataNotificationFoodMakanSiang')['hour']
            : hourMakanSiang,
        minutes: data.read('dataNotificationFoodMakanSiang') != null
            ? data.read('dataNotificationFoodMakanSiang')['minute']
            : minuteMakanSiang,
        seconds: 00,
      );
    } else {
      cancelNotification(id);
      showScheduledNotificationFoodMuted(
        id: id,
        title: 'Makan Siang',
        body:
            'Hari ini Makan Siang jam ${data.read('dataNotificationFoodMakanSiang') != null ? data.read('dataNotificationFoodMakanSiang')['hour'] : hourMakanSiang}:${data.read('dataNotificationFoodMakanSiang') != null ? data.read('dataNotificationFoodMakanSiang')['minute'] : minuteMakanSiang} , yuk cari menu di sirkadian!',
        payload: 'Makan Siang',
        hours: data.read('dataNotificationFoodMakanSiang') != null
            ? data.read('dataNotificationFoodMakanSiang')['hour']
            : hourMakanSiang,
        minutes: data.read('dataNotificationFoodMakanSiang') != null
            ? data.read('dataNotificationFoodMakanSiang')['minute']
            : minuteMakanSiang,
        seconds: 00,
      );
    }
  }

  void notificationFoodMakanMalam(id, sound) {
    //3
    if (sound == true) {
      cancelNotification(id);
      showScheduledNotificationFood(
        id: id,
        title: 'Makan Malam',
        body:
            'Hari ini Makan Malam jam ${data.read('dataNotificationFoodMakanMalam') != null ? data.read('dataNotificationFoodMakanMalam')['hour'] : hourMakanMalam}:${data.read('dataNotificationFoodMakanMalam') != null ? data.read('dataNotificationFoodMakanMalam')['minute'] : minuteMakanMalam}, yuk cari menu di sirkadian!',
        payload: 'Makan Malam',
        hours: data.read('dataNotificationFoodMakanMalam') != null
            ? data.read('dataNotificationFoodMakanMalam')['hour']
            : hourMakanMalam,
        minutes: data.read('dataNotificationFoodMakanMalam') != null
            ? data.read('dataNotificationFoodMakanMalam')['minute']
            : minuteMakanMalam,
        seconds: 00,
      );
    } else {
      cancelNotification(id);
      showScheduledNotificationFoodMuted(
        id: id,
        title: 'Makan Malam',
        body:
            'Hari ini Makan Malam jam ${data.read('dataNotificationFoodMakanMalam') != null ? data.read('dataNotificationFoodMakanMalam')['hour'] : hourMakanMalam}:${data.read('dataNotificationFoodMakanMalam') != null ? data.read('dataNotificationFoodMakanMalam')['minute'] : minuteMakanMalam}, yuk cari menu di sirkadian!',
        payload: 'Makan Malam',
        hours: data.read('dataNotificationFoodMakanMalam') != null
            ? data.read('dataNotificationFoodMakanMalam')['hour']
            : hourMakanMalam,
        minutes: data.read('dataNotificationFoodMakanMalam') != null
            ? data.read('dataNotificationFoodMakanMalam')['minute']
            : minuteMakanMalam,
        seconds: 00,
      );
    }
  }

  int? hourMinum1 = 7;
  int? minuteMinum1 = 00;
  int? hourMinum2 = 12;
  int? minuteMinum2 = 00;
  int? hourMinum3 = 17;
  int? minuteMinum3 = 00;
  int? hourMinum4 = 21;
  int? minuteMinum4 = 00;
  bool isSoundMinum1 = true;
  bool isSoundMinum2 = true;
  bool isSoundMinum3 = true;
  bool isSoundMinum4 = true;
  TimeOfDay timeOfDayMinum1 = TimeOfDay(hour: 7, minute: 00);
  TimeOfDay timeOfDayMinum2 = TimeOfDay(hour: 12, minute: 00);
  TimeOfDay timeOfDayMinum3 = TimeOfDay(hour: 17, minute: 00);
  TimeOfDay timeOfDayMinum4 = TimeOfDay(hour: 21, minute: 00);

  void rememberNotificationFluid(String? session) {
    if (session != null) {
      if (session == 'Minum1') {
        if (data.read('dataNotificationFluidMinum1') != null) {
          print('dataNotificationFluidMinum1 dihapus');
          data.remove('dataNotificationFluidMinum1');
          data.write('dataNotificationFluidMinum1', {
            'hour': hourMinum1,
            'minute': minuteMinum1,
            'sound': isSoundMinum1,
          });
        } else {
          data.write('dataNotificationFluidMinum1', {
            'hour': hourMinum1,
            'minute': minuteMinum1,
            'sound': isSoundMinum1,
          });
        }
      } else if (session == 'Minum2') {
        if (data.read('dataNotificationFluidMinum2') != null) {
          print('dataNotificationFluidMinum2 dihapus');
          data.remove('dataNotificationFluidMinum2');
          data.write('dataNotificationFluidMinum2', {
            'hour': hourMinum2,
            'minute': minuteMinum2,
            'sound': isSoundMinum2,
          });
        } else {
          data.write('dataNotificationFluidMinum2', {
            'hour': hourMinum2,
            'minute': minuteMinum2,
            'sound': isSoundMinum2,
          });
        }
      } else if (session == 'Minum3') {
        if (data.read('dataNotificationFluidMinum3') != null) {
          print('dataNotificationFluidMinum3 dihapus');
          data.remove('dataNotificationFluidMinum3');
          data.write('dataNotificationFluidMinum3', {
            'hour': hourMinum3,
            'minute': minuteMinum3,
            'sound': isSoundMinum3,
          });
        } else {
          data.write('dataNotificationFluidMinum3', {
            'hour': hourMinum3,
            'minute': minuteMinum3,
            'sound': isSoundMinum3,
          });
        }
      } else {
        if (data.read('dataNotificationFluidMinum4') != null) {
          print('dataNotificationFluidMinum4 dihapus');
          data.remove('dataNotificationFluidMinum4');
          data.write('dataNotificationFluidMinum4', {
            'hour': hourMinum4,
            'minute': minuteMinum4,
            'sound': isSoundMinum4,
          });
        } else {
          data.write('dataNotificationFluidMinum4', {
            'hour': hourMinum4,
            'minute': minuteMinum4,
            'sound': isSoundMinum4,
          });
        }
      }
    } else {
      print('session null');
    }
  }

  void notificationFluidMinum1(id, sound) {
    //4
    if (sound == true) {
      cancelNotification(id);
      showScheduledNotificationFluid(
        id: id,
        title: 'Reminder Minum',
        body: 'Jangan lupa minum dan catat di aplikasi Sirkadian',
        payload: 'false',
        hours: data.read('dataNotificationFluidMinum1') != null
            ? data.read('dataNotificationFluidMinum1')['hour']
            : hourMinum1,
        minutes: data.read('dataNotificationFluidMinum1') != null
            ? data.read('dataNotificationFluidMinum1')['minute']
            : minuteMinum1,
        seconds: 00,
      );
    } else {
      cancelNotification(id);
      showScheduledNotificationFluidMuted(
        id: id,
        title: 'Reminder Minum',
        body: 'Jangan lupa minum dan catat di aplikasi Sirkadian',
        payload: 'false',
        hours: data.read('dataNotificationFluidMinum1') != null
            ? data.read('dataNotificationFluidMinum1')['hour']
            : hourMinum1,
        minutes: data.read('dataNotificationFluidMinum1') != null
            ? data.read('dataNotificationFluidMinum1')['minute']
            : minuteMinum1,
        seconds: 00,
      );
    }
  }

  void notificationFluidMinum2(id, sound) {
    //5
    if (sound == true) {
      cancelNotification(id);
      showScheduledNotificationFluid(
        id: id,
        title: 'Reminder Minum',
        body: 'Jangan lupa minum dan catat di aplikasi Sirkadian',
        payload: 'false',
        hours: data.read('dataNotificationFluidMinum2') != null
            ? data.read('dataNotificationFluidMinum2')['hour']
            : hourMinum2,
        minutes: data.read('dataNotificationFluidMinum2') != null
            ? data.read('dataNotificationFluidMinum2')['minute']
            : minuteMinum2,
        seconds: 00,
      );
    } else {
      cancelNotification(id);
      showScheduledNotificationFluidMuted(
        id: id,
        title: 'Reminder Minum',
        body: 'Jangan lupa minum dan catat di aplikasi Sirkadian',
        payload: 'false',
        hours: data.read('dataNotificationFluidMinum2') != null
            ? data.read('dataNotificationFluidMinum2')['hour']
            : hourMinum2,
        minutes: data.read('dataNotificationFluidMinum2') != null
            ? data.read('dataNotificationFluidMinum2')['minute']
            : minuteMinum2,
        seconds: 00,
      );
    }
  }

  void notificationFluidMinum3(id, sound) {
    //6
    if (sound == true) {
      cancelNotification(id);
      showScheduledNotificationFluid(
        id: id,
        title: 'Reminder Minum',
        body: 'Jangan lupa minum dan catat di aplikasi Sirkadian',
        payload: 'false',
        hours: data.read('dataNotificationFluidMinum3') != null
            ? data.read('dataNotificationFluidMinum3')['hour']
            : hourMinum3,
        minutes: data.read('dataNotificationFluidMinum3') != null
            ? data.read('dataNotificationFluidMinum3')['minute']
            : minuteMinum3,
        seconds: 00,
      );
    } else {
      cancelNotification(id);
      showScheduledNotificationFluidMuted(
        id: id,
        title: 'Reminder Minum',
        body: 'Jangan lupa minum dan catat di aplikasi Sirkadian',
        payload: 'false',
        hours: data.read('dataNotificationFluidMinum3') != null
            ? data.read('dataNotificationFluidMinum3')['hour']
            : hourMinum3,
        minutes: data.read('dataNotificationFluidMinum3') != null
            ? data.read('dataNotificationFluidMinum3')['minute']
            : minuteMinum3,
        seconds: 00,
      );
    }
  }

  void notificationFluidMinum4(id, sound) {
    //7
    if (sound == true) {
      cancelNotification(id);
      showScheduledNotificationFluid(
        id: id,
        title: 'Reminder Minum',
        body: 'Jangan lupa minum dan catat di aplikasi Sirkadian',
        payload: 'false',
        hours: data.read('dataNotificationFluidMinum4') != null
            ? data.read('dataNotificationFluidMinum4')['hour']
            : hourMinum4,
        minutes: data.read('dataNotificationFluidMinum4') != null
            ? data.read('dataNotificationFluidMinum4')['minute']
            : minuteMinum4,
        seconds: 00,
      );
    } else {
      cancelNotification(id);
      showScheduledNotificationFluidMuted(
        id: id,
        title: 'Reminder Minum',
        body: 'Jangan lupa minum dan catat di aplikasi Sirkadian',
        payload: 'false',
        hours: data.read('dataNotificationFluidMinum4') != null
            ? data.read('dataNotificationFluidMinum4')['hour']
            : hourMinum4,
        minutes: data.read('dataNotificationFluidMinum4') != null
            ? data.read('dataNotificationFluidMinum4')['minute']
            : minuteMinum4,
        seconds: 00,
      );
    }
  }

  //retrieve data
  void getToData() {
    if (data.read('dataNotificationFoodSarapan') != null) {
      timeOfDaySarapan = TimeOfDay(
          hour: data.read('dataNotificationFoodSarapan')['hour'],
          minute: data.read('dataNotificationFoodSarapan')['minute']);
      isSoundSarapan = data.read('dataNotificationFoodSarapan')['sound'];
    }
    if (data.read('dataNotificationFoodMakanSiang') != null) {
      timeOfDayMakanSiang = TimeOfDay(
          hour: data.read('dataNotificationFoodMakanSiang')['hour'],
          minute: data.read('dataNotificationFoodMakanSiang')['minute']);
      isSoundMakanSiang = data.read('dataNotificationFoodMakanSiang')['sound'];
    }
    if (data.read('dataNotificationFoodMakanMalam') != null) {
      timeOfDayMakanMalam = TimeOfDay(
          hour: data.read('dataNotificationFoodMakanMalam')['hour'],
          minute: data.read('dataNotificationFoodMakanMalam')['minute']);
      isSoundMakanMalam = data.read('dataNotificationFoodMakanMalam')['sound'];
    }
    if (data.read('dataNotificationFluidMinum1') != null) {
      timeOfDayMinum1 = TimeOfDay(
          hour: data.read('dataNotificationFluidMinum1')['hour'],
          minute: data.read('dataNotificationFluidMinum1')['minute']);
      isSoundMinum1 = data.read('dataNotificationFluidMinum1')['sound'];
    }
    if (data.read('dataNotificationFluidMinum2') != null) {
      timeOfDayMinum2 = TimeOfDay(
          hour: data.read('dataNotificationFluidMinum2')['hour'],
          minute: data.read('dataNotificationFluidMinum2')['minute']);
      isSoundMinum2 = data.read('dataNotificationFluidMinum1')['sound'];
    }
    if (data.read('dataNotificationFluidMinum3') != null) {
      timeOfDayMinum3 = TimeOfDay(
          hour: data.read('dataNotificationFluidMinum3')['hour'],
          minute: data.read('dataNotificationFluidMinum3')['minute']);
      isSoundMinum3 = data.read('dataNotificationFluidMinum1')['sound'];
    }
    if (data.read('dataNotificationFluidMinum4') != null) {
      timeOfDayMinum4 = TimeOfDay(
          hour: data.read('dataNotificationFluidMinum4')['hour'],
          minute: data.read('dataNotificationFluidMinum4')['minute']);
      isSoundMinum4 = data.read('dataNotificationFluidMinum4')['sound'];
    }
  }
}
