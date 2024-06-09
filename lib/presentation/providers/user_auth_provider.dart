import 'package:flutter/cupertino.dart';
import '../../commons/storage_handler.dart';
import '../../data/beans/user_model.dart';
import '../../data/repositories/login_repo.dart';

class UserAuthProvider extends ChangeNotifier {
  dynamic _errorMsg;
  bool _hasError = false;
  UserModel? _userModel;
  String? _userToken;

  String? get userToken => _userToken;

  bool get hasError => _hasError;

  bool get isLoggedUser => (_userToken != null &&
      (_userToken?.isNotEmpty == true) &&
      _userModel != null);

  dynamic get errorMsg => _errorMsg;

  UserModel? get userModel => _userModel;

  Future<void> getSelf() async {
    await getSavedToken();
    if(_userToken == null){
      return;
    }
    var requestResponse = await getSelfRequest();
    _errorMsg = requestResponse.errorMsg;
    _userModel = requestResponse.data;
    _hasError = !(_userModel != null);
    notifyListeners();
  }

  Future<void> getSavedToken() async {
    _userToken = await StorageHandler.loadString(StorageHandler.apiTokenKey);
    notifyListeners();
  }

  Future<void> logout() async{
    await StorageHandler.deleteKey(StorageHandler.apiTokenKey);
    _userToken=null;
    _userModel=null;
    notifyListeners();
  }
}
