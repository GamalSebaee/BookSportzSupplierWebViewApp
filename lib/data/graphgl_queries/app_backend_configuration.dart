import 'package:booksportz_supplier_webview_app/commons/storage_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../commons/constants.dart';

class AppBackendConfiguration {
  static Future<GraphQLClient> clientToQuery() async{
    String? token=await _getSavedUserToken();
    final HttpLink httpLink = HttpLink( Constants.baseUrl);
    debugPrint("AppConstants.baseUrl ${Constants.baseUrl} - token=$token");

    final AuthLink authLink = AuthLink(getToken: () {
      return token != null ? "Bearer $token" : "";
    });
    final Link link = authLink.concat(httpLink);
    return GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );
  }

  static Future<String?> _getSavedUserToken() async {
    String? userToken =
        await StorageHandler.loadString(StorageHandler.apiTokenKey);
    return userToken;
  }
}
