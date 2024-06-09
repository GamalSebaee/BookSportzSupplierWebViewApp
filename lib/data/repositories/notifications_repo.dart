import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../beans/notification.dart';
import '../graphgl_queries/app_backend_configuration.dart';
import '../graphgl_queries/queries.dart';

Future<int?> getUnreadNotificationsCountRequest() async {
  GraphQLClient client = await AppBackendConfiguration.clientToQuery();
  QueryResult queryResult = await client.query(
      QueryOptions(document: gql(GraphQLQueries.getNotificationsCount())));

  debugPrint("getUnreadNotificationsCount : ${queryResult.data}");
  if (queryResult.data != null &&
      queryResult.data!['getNotifications'] != null) {
    NotificationsResponse notificationsResponse =
        NotificationsResponse.fromJson(queryResult.data!['getNotifications']);
    return notificationsResponse.unseenCounter;
  } else {
    debugPrint("userLoginRequest : ${queryResult.exception}");
    return 0;
  }
}

Future<NotificationsResponse?> getNotificationsRequest({int? limit=10,
  int? offset=0,}) async {
  GraphQLClient client = await AppBackendConfiguration.clientToQuery();
  QueryResult queryResult = await client.query(
      QueryOptions(document: gql(GraphQLQueries.getNotifications()
      )));

  debugPrint("getNotificationsRequest : ${queryResult.data}");
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

