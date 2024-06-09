import 'package:booksportz_supplier_webview_app/commons/storage_handler.dart';
import 'package:flutter/cupertino.dart';

import '../../data/repositories/login_repo.dart';

class LoginProvider extends ChangeNotifier {
  dynamic _errorMsg;
  bool _hasError = false;

  bool get hasError => _hasError;
  dynamic get errorMsg => _errorMsg;

  Future<void> confirmLogin(
      {required String userEmail, required String password}) async {
    var requestResponse = await loginRequest(userEmail, password);
    _errorMsg = requestResponse.errorMsg;
    _hasError = !(requestResponse.data != null &&
        requestResponse.data!.jwtToken != null);
    if (!_hasError) {
      await StorageHandler.saveString(
          StorageHandler.apiTokenKey, requestResponse.data!.jwtToken);
    }
    notifyListeners();
  }
}
