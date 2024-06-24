import 'dart:convert';

import 'package:booksportz_supplier_webview_app/commons/routes.dart';
import 'package:booksportz_supplier_webview_app/commons/ui_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../booksportz_app.dart';
import '../presentation/providers/notifications_provider.dart';
import 'constants.dart';

const String notificationsChannelId = "booksportz_supplier_app_channel";
const String channelDescription =
    "This channel is a default notifications channel.";
const String iconPath = "@mipmap/ic_stat_ic_launcher";
const String iosThread = "booksportz_supplier_thread";
const String defaultTitle = "BookSportz Supplier";
const String defaultBody = "new Notification";

AndroidNotificationDetails createAndroidChannel({
  String? imagePath,
}) {
  final hasPicture = imagePath != null;
  return AndroidNotificationDetails(
    notificationsChannelId, // id
    'Notifications', // title
    channelDescription: channelDescription,
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    channelShowBadge: false,
    icon: iconPath,
    largeIcon: hasPicture
        ? FilePathAndroidBitmap(
            imagePath,
          )
        : null,
    styleInformation: hasPicture
        ? BigPictureStyleInformation(
            FilePathAndroidBitmap(
              imagePath,
            ),
            hideExpandedLargeIcon: true,
          )
        : null,
  );
}

DarwinNotificationDetails createIOSConfig({
  String? imagePath,
}) {
  final hasAttachment = imagePath != null;
  return DarwinNotificationDetails(
    threadIdentifier: iosThread,
    presentSound: true,
    presentBadge: false,
    presentAlert: true,
    attachments: hasAttachment
        ? [
            DarwinNotificationAttachment(
              imagePath,
            ),
          ]
        : null,
  );
}

void initRequestPermissions() async {
  try {
    await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: false,
          sound: true,
        );

    await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  } catch (e) {
    debugPrint("initRequestPermissions $e");
  }
}

Future<NotificationDetails> setNotificationDetails({
  String? imageUrl,
}) async {
  return NotificationDetails(
    android: createAndroidChannel(
      imagePath: imageUrl,
    ),
    iOS: createIOSConfig(
      imagePath: imageUrl,
    ),
  );
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    printLog("firebaseMessagingBackgroundHandler: $message");
    FirebaseNotificationModel? firebaseNotificationModel =
        await parseFirebaseRemoteMessage(message);
    _handelNotificationAction(firebaseNotificationModel);
  } catch (e) {
    printLog(":::firebaseMessagingBackgroundHandler::: $e");
  }
}

Future<FirebaseNotificationModel?> parseFirebaseRemoteMessage(
    RemoteMessage? message) async {
  if (message == null || message.data.isEmpty) {
    return null;
  }
  return FirebaseNotificationModel.fromJson(message.data);
}

void initFirebaseMessaging() async {
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    debugPrint("inside is app opened");
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
    RemoteNotification? notification = message?.notification;
    AndroidNotification? androidNotification = message?.notification?.android;
    AppleNotification? appleNotification = message?.notification?.apple;
    printLog("Inside push notification ${message?.data}");
    FirebaseNotificationModel? firebaseNotificationModel =
        await parseFirebaseRemoteMessage(message);
    if (notification != null) {
      if (androidNotification != null) {
        handleLocalNotification(
          notification.title ?? defaultTitle,
          notification.body ?? defaultBody,
          firebaseNotificationModel,
          androidNotification.imageUrl,
        );
      } else if (appleNotification != null) {
        handleLocalNotification(
          notification.title ?? defaultTitle,
          notification.body ?? defaultBody,
          firebaseNotificationModel,
          appleNotification.imageUrl,
        );
      }
    }
  });
}

void handleLocalNotification(
  String notificationTitle,
  String notificationBody,
  FirebaseNotificationModel? firebaseNotificationModel, [
  String? notificationImageUrl,
]) async {
  NotificationDetails platformChannelSpecifics = await setNotificationDetails(
    imageUrl: notificationImageUrl,
  );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings(iconPath),
      iOS: DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
      ));
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (data) =>
          onDidReceiveNotificationResponse(data, firebaseNotificationModel));
  var notId = createNotificationId();
  try {
    flutterLocalNotificationsPlugin.show(
        notId, notificationTitle, notificationBody, platformChannelSpecifics);
  } catch (e) {
    printLog("inside handleLocalNotification: $e");
  }

  refreshNotificationsCounter();
}

void refreshNotificationsCounter() {
  try {
    printLog("Inside refreshNotificationsCounter");
    BuildContext? context = BookSportzApp.navigatorKey.currentContext ??
        BookSportzApp.navigatorKey.currentState?.context;
    printLog("Inside refreshNotificationsCounter $context");
    if (context != null) {
      Future.delayed(Duration.zero).then((_) {
        Provider.of<NotificationsProvider>(context, listen: false)
            .updateNotificationsCount(count: 1);
      });
    }
  } catch (e) {
    printLog("refreshNotificationsCounter exception $e");
  }
}

void onDidReceiveNotificationResponse(NotificationResponse details,
    FirebaseNotificationModel? firebaseNotificationModel) {
  try {
    printLog(
        "handel notification action : ${firebaseNotificationModel?.redirect}");
    _handelNotificationAction(firebaseNotificationModel);
  } catch (e) {
    printLog("onDidReceiveNotificationResponse fail $e");
  }
}

void _handelNotificationAction(
    FirebaseNotificationModel? firebaseNotificationModel) {
  if ((firebaseNotificationModel?.redirect ?? '').trim().isEmpty) {
    return;
  }
  BuildContext? context = BookSportzApp.navigatorKey.currentContext ??
      BookSportzApp.navigatorKey.currentState?.context;
  if (context != null) {
    openPageWithName(context, Routes.appWebPage, args: {
      RouteParameter.data:
          getPageUrl(pageUrl: firebaseNotificationModel?.redirect ?? ''),
      RouteParameter.title:
          '${AppLocalizations.of(context)?.reservationDetails}'
    });
  }

  updateBadgeCount(count: 0);
}

void printLog(String s) {
  debugPrint(":::AppFirebaseMessaging::: -> $s");
}

class FirebaseNotificationModel {
  dynamic type;
  String? redirect;

  FirebaseNotificationModel({this.type, this.redirect});

  FirebaseNotificationModel.fromJson(Map<String, dynamic>? json) {
    Constants.notificationData = json;
    try {
      type = json?['type'];
      if (json?['redirect'] != null) {
        redirect = json?['redirect'];
      } else if (json?['notification'] != null) {
        var obj =
            PushNotificationModel.fromJson(jsonDecode(json?['notification']));
        redirect = obj.redirect;
      } else if (json?['redirect_url'] != null) {
        redirect = json?['redirect_url'];
      }
    } catch (e) {
      debugPrint("Notification parsing exception$e");
    }
  }
}

Future<String?> getDeviceFCMToken() async {
  String? deviceToken = await FirebaseMessaging.instance.getToken();

  return deviceToken;
}

int createNotificationId() {
  int notificationId = (DateTime.now().microsecond.toInt() +
      DateTime.now().millisecond.toInt() +
      DateTime.now().second.toInt());
  return notificationId;
}

class PushNotificationModel {
  String? redirect;

  PushNotificationModel({this.redirect});

  PushNotificationModel.fromJson(Map<String, dynamic> json) {
    redirect = json['redirect'];
  }
}

void updateBadgeCount({int count = 0}) async {
  if(count == 0){
    await FlutterLocalNotificationsPlugin().cancelAll();
  }
  bool isSupported = await FlutterAppBadger.isAppBadgeSupported();
  if (!isSupported) {
    return;
  }
  if (count == 0) {
    FlutterAppBadger.removeBadge();
    //return;
  }
  FlutterAppBadger.updateBadgeCount(count);

}
