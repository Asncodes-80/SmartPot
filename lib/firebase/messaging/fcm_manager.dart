/*
  Following i developed a simple notification in app process view.
  key of FCM Auth use it in server side, see in README.md.
*/
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMManager {
  // Init notification plugin. (in-app-notification-widget)
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    "id",
    "name",
    "description",
    importance: Importance.high,
  );

  AndroidInitializationSettings initializationAndroidSetting =
      const AndroidInitializationSettings("@mipmap/ic_launcher");

  init() {
    ///
    /// Init messaging notification plugin. (in-app-notification-widget)
    /// It will wait and listen by user device token while that FCM call it.
    /// Init this method in initState of main.dart.
    /// In initState setup Android and iOS initializationSettings and use that in
    /// fcm.flutterLocalNotificationPlugin.initialize(<your initSettings>).
    /// After that use this method.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      // Setup that only for android.
      AndroidNotification? android = message.notification?.android;

      if (notification != null || android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification?.title,
          notification?.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: IOSNotificationDetails(
              subtitle: notification?.body,
            ),
          ),
        );
      }
    });
  }

  Future firebaseMessagingBackgroundHandler(RemoteMessage msg) async {
    ///
    /// _firebaseMessagingBackgroundHandler is called when app is in background.
    /// Getting notification from the background, it will ring a sound in
    /// notification center at the top.
    /// When user be inside of app, it will show a bar called
    /// FlutterLocalNotificationsPlugin.
    await Firebase.initializeApp();

    // Will show message in notification center and show bar inside of app
    flutterLocalNotificationsPlugin.show(
      msg.notification.hashCode,
      msg.notification?.title,
      msg.notification?.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  Future<String?> deviceToken() async =>
      await FirebaseMessaging.instance.getToken();
}
