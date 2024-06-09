import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'booksportz_app.dart';
import 'commons/app_firebase_messaging.dart';
import 'commons/app_queued_tasks.dart';
import 'presentation/providers/home_menu_notifier.dart';
import 'presentation/providers/device_info_notifier.dart';
import 'presentation/providers/login_provider.dart';
import 'presentation/providers/notifications_provider.dart';
import 'presentation/providers/user_auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
  FirebaseNotificationModel? firebaseNotificationModel =
      await parseFirebaseRemoteMessage(message);
  AppQueuedTasks.firebaseNotificationModel=firebaseNotificationModel;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeMenuNotifier>(
          create: (context) => HomeMenuNotifier(),
        ),
        ChangeNotifierProvider<DeviceInfoNotifier>(
          create: (context) => DeviceInfoNotifier(),
        ),
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider<UserAuthProvider>(
          create: (context) => UserAuthProvider(),
        ),
        ChangeNotifierProvider<NotificationsProvider>(
          create: (context) => NotificationsProvider(),
        ),
      ],
      child: const BookSportzApp(),
    ),
  );
}
