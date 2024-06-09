class NotificationsResponse {
  int? count;
  int? unseenCounter;
  List<Notifications>? notifications;

  NotificationsResponse({this.count, this.unseenCounter, this.notifications});

  NotificationsResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    unseenCounter = json['unseenCounter'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['unseenCounter'] = unseenCounter;
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String? id;
  int? userId;
  String? message;
  int? reservationId;
  dynamic itemId;
  dynamic itemType;
  dynamic reviewId;
  dynamic requestId;
  String? type;
  String? redirect;
  String? createdAt;
  bool? seen;
  dynamic reservation;

  Notifications(
      {this.id,
      this.userId,
      this.message,
      this.reservationId,
      this.itemId,
      this.itemType,
      this.reviewId,
      this.requestId,
      this.type,
      this.createdAt,
      this.seen,
      this.redirect,
      this.reservation});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    message = json['message'];
    reservationId = json['reservationId'];
    itemId = json['itemId'];
    itemType = json['itemType'];
    reviewId = json['reviewId'];
    requestId = json['requestId'];
    type = json['type'];
    createdAt = json['createdAt'];
    seen = json['Seen'];
    reservation = json['reservation'];
    redirect = json['redirect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['message'] = message;
    data['reservationId'] = reservationId;
    data['itemId'] = itemId;
    data['itemType'] = itemType;
    data['reviewId'] = reviewId;
    data['requestId'] = requestId;
    data['type'] = type;
    data['createdAt'] = createdAt;
    data['Seen'] = seen;
    data['reservation'] = reservation;
    data['redirect'] = redirect;
    return data;
  }
}
