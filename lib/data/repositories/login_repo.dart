import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../beans/base_model.dart';
import '../beans/user_model.dart';
import '../graphgl_queries/app_backend_configuration.dart';
import '../graphgl_queries/queries.dart';

Future<BaseModel<UserModel?>> loginRequest(
    String userEmail, String password) async {
  GraphQLClient client =await AppBackendConfiguration.clientToQuery();
  QueryResult queryResult = await client.query(QueryOptions(
      document:
          gql(GraphQLQueries.login(email: userEmail, password: password))));

  debugPrint("userLoginRequest : ${queryResult.data}");
  if (queryResult.data != null && queryResult.data!['login'] != null) {
    UserModel user =
        UserModel.fromJson(queryResult.data!['login'], token: null);
    return BaseModel(status: true, data: user);
  } else {
    debugPrint("userLoginRequest : ${queryResult.exception}");
    return BaseModel(
        status: false,
        errorMsg: queryResult.exception!.graphqlErrors.first.message);
  }
}

Future<BaseModel<UserModel?>> getSelfRequest() async {
  GraphQLClient client = await AppBackendConfiguration.clientToQuery();
  QueryResult queryResult =
      await client.query(QueryOptions(document: gql(GraphQLQueries.getSelf())));

  debugPrint("getSelf : ${queryResult.data}");
  if (queryResult.data != null && queryResult.data!['getSelf'] != null) {
    UserModel user =
        UserModel.fromJson(queryResult.data!['getSelf'], token: null);
    return BaseModel(status: true, data: user);
  } else {
    debugPrint("getSelfRequest : ${queryResult.exception}");
    return BaseModel(
        status: false,
        errorMsg: queryResult.exception!.graphqlErrors.first.message);
  }
}
