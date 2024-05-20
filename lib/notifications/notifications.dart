import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../utils/locator.dart';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

class AndroidNotif {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      getIt<FlutterLocalNotificationsPlugin>();

  NotificationDetails getNewChapterNoSoundPlatformChannelDetails() {
    const AndroidNotificationDetails androidPlatformChannelDetails =
        AndroidNotificationDetails('no_sound_chapter_id', 'no_sound_chapter',
            channelDescription: 'no sound chapter notification',
            priority: Priority.high,
            ticker: 'no sound');

    NotificationDetails platformChannelDetails = const NotificationDetails(
      android: androidPlatformChannelDetails,
    );
    return platformChannelDetails;
  }

  //TODO : Future update when sharedPreferences is implemented : give path to song saved by user
  NotificationDetails getNewChapterOraPlatformChannelDetails() {
    const AndroidNotificationDetails androidPlatformChannelDetails =
        AndroidNotificationDetails('ora_chapter_id', 'ora_chapter',
            channelDescription: 'ora chapter notification',
            priority: Priority.high,
            sound: UriAndroidNotificationSound('assets/tunes/ora.mp3'),
            playSound: true,
            ticker: 'ora');

    NotificationDetails platformChannelDetails = const NotificationDetails(
      android: androidPlatformChannelDetails,
    );
    return platformChannelDetails;
  }

  NotificationDetails getNewChapterYujiroLaughsPlatformChannelDetails() {
    const AndroidNotificationDetails androidNoSoundPlatformChannelDetails =
        AndroidNotificationDetails(
            'yujiro_laughs_chapter_id', 'yujiro_laughs_chapter',
            channelDescription: 'yujiro_laughs chapter notification',
            priority: Priority.high,
            sound:
                UriAndroidNotificationSound('assets/tunes/yujiro_laughs.mp3'),
            ticker: 'yujiro_laughs');

    NotificationDetails platformChannelDetails = const NotificationDetails(
      android: androidNoSoundPlatformChannelDetails,
    );
    return platformChannelDetails;
  }

  Future<void> showNotification(ReceivedNotification notification,
      NotificationDetails notificationDetails) async {
    await flutterLocalNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      notificationDetails,
      payload: notification.payload,
    );
  }

  Future<void> showNotificationWithActions(
    ReceivedNotification notification,
    String tickerData,
  ) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'action_notification_id',
      'action_notification_channel',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: tickerData,
      actions: <AndroidNotificationAction>[
        const AndroidNotificationAction(
          'read_chapter',
          'Lire le chapitre',
          icon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
          showsUserInterface: true,
        ),
        const AndroidNotificationAction(
          'chapter_already_read',
          'Déjà lu',
          icon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
          showsUserInterface: true,
        ),
      ],
    );

    NotificationDetails platformChannelDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(notification.id,
        notification.title, notification.body, platformChannelDetails,
        payload: notification.payload);
  }
}
