import 'package:booksportz_supplier_webview_app/commons/app_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../beans/notification.dart';
import '../graphgl_queries/app_backend_configuration.dart';
import '../graphgl_queries/queries.dart';

Future<int?> getUnreadNotificationsCountRequest() async {
  GraphQLClient client = await AppBackendConfiguration.clientToQuery();
  QueryResult queryResult = await client.query(
      QueryOptions(document: gql(GraphQLQueries.notificationCounter())));

  debugPrint("getUnreadNotificationsCount : ${queryResult.data}");
  if (queryResult.data != null &&
      queryResult.data!['notificationCounter'] != null) {
    return queryResult.data!['notificationCounter'];
  } else {
    debugPrint("notificationCounter Exception : ${queryResult.exception}");
    return 0;
  }
}

Future<NotificationsResponse?> getNotificationsRequest({int? limit=10,
  int? offset=0,}) async {
  GraphQLClient client = await AppBackendConfiguration.clientToQuery();
  QueryResult queryResult = await client.query(
      QueryOptions(document: gql(GraphQLQueries.getNotifications(
        limit: limit,
        offset: offset
      )
      )));

  debugPrint("getNotificationsRequest : limit=$limit - offset=$offset ${queryResult.data}");
  if (queryResult.data != null &&
      queryResult.data!['getNotifications'] != null) {
    NotificationsResponse notificationsResponse =
    NotificationsResponse.fromJson(queryResult.data!['getNotifications']);
    return notificationsResponse;
  } else {
    debugPrint("userLoginRequest : ${queryResult.exception}");
    return null;
  }
}

Future<bool> clearNotificationCounterRequest() async {
  GraphQLClient client = await AppBackendConfiguration.clientToQuery();

  try {
    QueryResult queryResult = await client.query(QueryOptions(
        document: gql(GraphQLQueries.clearNotificationCounter())));

    debugPrint(
        "inside clearNotificationCounter data : ${queryResult.data}  - errors : ${queryResult.exception}");
    if (queryResult.data != null && queryResult.data!['clearNotificationCounter'] != null) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}


Future<bool> markAllNotificationsAsReadRequest() async {
  GraphQLClient client = await AppBackendConfiguration.clientToQuery();
  try {
    QueryResult queryResult = await client.query(QueryOptions(
        document: gql(GraphQLQueries.markAllNotificationsAsRead())));

    debugPrint(
        "inside markAllAsRead data : ${queryResult.data}  - errors : ${queryResult.exception}");
    if (queryResult.data != null && queryResult.data!['markAllAsRead'] != null) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<bool> makeNotificationSeenRequest({String? notificationId}) async {
  GraphQLClient client = await AppBackendConfiguration.clientToQuery();
  try {
    num? convertedNotificationId=notificationId.convertStringToInt();
    QueryResult queryResult = await client.query(QueryOptions(
        document: gql(GraphQLQueries.makeNotificationSeen()),
        variables: <String, num>{'id': convertedNotificationId ?? 0}));

    debugPrint(
        "inside makeNotificationSeenRequest data : ${queryResult.data}  - errors : ${queryResult.exception}");
    if (queryResult.data != null && queryResult.data!['notificationSeen'] != null) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

