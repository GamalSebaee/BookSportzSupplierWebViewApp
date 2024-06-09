import 'package:graphql_flutter/graphql_flutter.dart';
import '../../commons/app_firebase_messaging.dart';
import '../graphgl_queries/app_backend_configuration.dart';
import '../graphgl_queries/queries.dart';

Future<bool> saveDeviceTokenRequest(
    {String? deviceId, String? deviceToken}) async {
  GraphQLClient client = await AppBackendConfiguration.clientToQuery();
  try {
    QueryResult queryResult = await client.query(QueryOptions(
        document: gql(GraphQLQueries.addDeviceTokenQuery()),
        variables: <String, String>{
          'deviceId': deviceId ?? '',
          'fcmToken': deviceToken ?? ''
        }));
    printLog("inside saveDeviceTokenRequest variables : ${{
      'deviceId': deviceId ?? '',
      'fcmToken': deviceToken ?? ''
    }}  -  data : ${queryResult.data} - errors : ${queryResult.exception}");
    if (queryResult.data != null) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<bool> deleteDeviceTokenRequest({String? deviceId}) async {
  GraphQLClient client = await AppBackendConfiguration.clientToQuery();
  try {
    QueryResult queryResult = await client.query(QueryOptions(
        document: gql(GraphQLQueries.deleteDeviceTokenQuery()),
        variables: <String, dynamic>{'deviceId': deviceId ?? ''}));
    printLog(
        "inside deleteDeviceTokenRequest : ${{
          'deviceId': deviceId ?? '',
        }}  - data : ${queryResult.data}  - errors : ${queryResult.exception}");
    if (queryResult.data != null) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
