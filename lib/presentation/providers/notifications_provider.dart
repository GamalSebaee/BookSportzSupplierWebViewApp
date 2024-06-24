import 'package:flutter/cupertino.dart';
import '../../data/beans/notification.dart';
import '../../data/repositories/notifications_repo.dart';

class NotificationsProvider extends ChangeNotifier {
  int? _unreadNotificationsCount;

  int get unreadNotificationsCount => _unreadNotificationsCount ?? 0;

  Future<void> getUnreadNotificationsCount() async {
    var requestResponse = await getUnreadNotificationsCountRequest();
    _unreadNotificationsCount = requestResponse;
    notifyListeners();
  }

  Future<void> updateNotificationsCount({int? count}) async {
    _unreadNotificationsCount = count;
    notifyListeners();
  }

  Future<void> clearNotificationCounter() async {
    var requestResponse = await clearNotificationCounterRequest();
    if (requestResponse) {
      _unreadNotificationsCount = null;
      notifyListeners();
    }
  }

  Future<NotificationsResponse?> getNotificationsData({
    int? limit = 10,
    int? offset = 0,
  }) async {
    var requestResponse =
        await getNotificationsRequest(limit: limit, offset: offset);

    return requestResponse;
  }
}
