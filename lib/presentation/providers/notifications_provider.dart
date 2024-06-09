import 'package:booksportz_supplier_webview_app/commons/storage_handler.dart';
import 'package:flutter/cupertino.dart';

import '../../data/beans/notification.dart';
import '../../data/repositories/login_repo.dart';
import '../../data/repositories/notifications_repo.dart';

class NotificationsProvider extends ChangeNotifier {
  dynamic _errorMsg;
  bool _hasError = false;

  bool get hasError => _hasError;

  dynamic get errorMsg => _errorMsg;

  int? _unreadNotificationsCount;

  List<Notifications>? _notifications;

  List<Notifications> get notifications => _notifications ?? [];

  int get unreadNotificationsCount => _unreadNotificationsCount ?? 0;

  Future<void> getUnreadNotificationsCount() async {
    var requestResponse = await getUnreadNotificationsCountRequest();
    _unreadNotificationsCount = requestResponse;
    notifyListeners();
  }

  Future<void> getNotifications({
    int? limit = 10,
    int? offset = 0,
  }) async {
    var requestResponse = await getNotificationsRequest();
    _notifications = requestResponse?.notifications;
    _hasError = (_notifications == null);
    notifyListeners();
  }

  Future<NotificationsResponse?> getNotificationsData({
    int? limit = 10,
    int? offset = 0,
  }) async {
    var requestResponse = await getNotificationsRequest();

    return requestResponse;
  }
}
