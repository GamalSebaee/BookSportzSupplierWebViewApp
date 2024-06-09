import 'package:booksportz_supplier_webview_app/commons/utils.dart';
import 'package:flutter/cupertino.dart';

import '../../commons/app_firebase_messaging.dart';
import '../../commons/ui_utils.dart';
import '../../data/repositories/app_setting_repo.dart';

class DeviceInfoNotifier extends ChangeNotifier {
  String? _deviceId;
  String? _deviceFCMToken;
  String? _deviceType;

  String? get deviceId => _deviceId;

  Future<void> _getDeviceId() async {
    _deviceId = await getDeviceId();
    notifyListeners();
  }

  Future<void> _getDeviceToken() async {
    _deviceFCMToken = await getDeviceFCMToken();
    printLog("_deviceFCMToken: $_deviceFCMToken");
    notifyListeners();
  }

  Future<void> _getDeviceType() async {
    _deviceType = await getDeviceType();
    notifyListeners();
  }

  Future<void> getDeviceInfo() async {
    await _getDeviceToken();
    await _getDeviceId();
    await _getDeviceType();
  }

  Future<void> submitDeviceToken() async {
    if (_deviceId == null || _deviceFCMToken == null) {
      await getDeviceInfo();
    }
    await _confirmSubmitDeviceToken();
  }

  Future<void> _confirmSubmitDeviceToken() async {
    if (_deviceId != null && _deviceFCMToken != null) {
      var requestResponse = await saveDeviceTokenRequest(
          deviceToken: _deviceFCMToken, deviceId: _deviceId);
    /*  showAppMessage("saveDeviceTokenRequest :  $requestResponse");*/
    }
  }

  String? get deviceFCMToken => _deviceFCMToken;

  String? get deviceType => _deviceType;

  Future<void> deleteDeviceToken() async {
    if (_deviceId == null) {
      await getDeviceInfo();
    }
    await deleteDeviceTokenRequest(deviceId: deviceId);
  }
}
