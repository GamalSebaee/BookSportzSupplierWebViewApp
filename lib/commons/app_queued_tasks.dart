import 'package:booksportz_supplier_webview_app/commons/routes.dart';
import 'package:booksportz_supplier_webview_app/commons/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../booksportz_app.dart';
import 'app_firebase_messaging.dart';
import 'constants.dart';

class AppQueuedTasks {
  static const redirectDetailsKey = "redirectDetails";

  static Map<String, Map<String, dynamic>?> _queuedTasks = {};

  static FirebaseNotificationModel? firebaseNotificationModel;

  static printAllTasks() {
    printLog("_queuedTasks is: $_queuedTasks");
  }

  static addTask({required String taskName, Map<String, dynamic>? parameters}) {
    _queuedTasks[taskName] = parameters;
  }

  static removeTask({required String taskName}) {
    _queuedTasks.remove(taskName);
  }

  static _removeAllTask() {
    _queuedTasks.clear();
  }

  static performAllTasks() async {
    var allEntries = _queuedTasks.entries;
    for (MapEntry<String, Map<String, dynamic>?> item in allEntries) {
      printAllTasks();
      if (item.key == AppQueuedTasks.redirectDetailsKey) {
        if (item.value != null) {
          var id = item.value!['id'];
          var type = item.value!['type'];
          if (id != null && type != null) {
            try {
              BuildContext? context =
                  BookSportzApp.navigatorKey.currentContext ??
                      BookSportzApp.navigatorKey.currentState?.context;
              if (context != null) {
                openPageWithName(
                    BookSportzApp.navigatorKey.currentState!.context,
                    Routes.appWebPage,
                    args: {
                      RouteParameter.data: getPageUrl(
                          pageUrl: firebaseNotificationModel?.redirect ?? ''),
                      RouteParameter.title:
                          '${AppLocalizations.of(context)?.reservationDetails}'
                    });
              }
            } catch (e) {
              printLog("Can't Open Supplier Profile $e");
            }
          }
        }
      }
    }
    _removeAllTask();
    printAllTasks();
  }

  static void handleBackgroundNotificationAction() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if ((firebaseNotificationModel?.redirect ?? '').trim().isEmpty) {
        return;
      }
      Future.delayed(const Duration(milliseconds: 1000), () async {
        BuildContext? context = BookSportzApp.navigatorKey.currentContext ??
            BookSportzApp.navigatorKey.currentState?.context;
        if (context != null) {
          openPageWithName(BookSportzApp.navigatorKey.currentState!.context,
              Routes.appWebPage,
              args: {
                RouteParameter.data: getPageUrl(
                    pageUrl: firebaseNotificationModel?.redirect ?? ''),
                RouteParameter.title:
                    '${AppLocalizations.of(context)?.reservationDetails}'
              });
        }
      });
    });
  }
}
