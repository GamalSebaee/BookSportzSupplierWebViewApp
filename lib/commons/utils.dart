import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

T? tryCast<T>(
    dynamic object,
    ) =>
    object is T ? object : null;

String concatenateStrings(
    List<String?> strings, {
      String separator = ' ',
    }) =>
    strings
        .where(
          (string) => string?.isNotEmpty == true,
    )
        .join(
      separator,
    );

Future<String?> getDeviceId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if(Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    var uniqueDeviceId = "${androidDeviceInfo.manufacturer}:${androidDeviceInfo.device}-${androidDeviceInfo.id}" ;
    return uniqueDeviceId;
  }else{
    return "";
  }
}
Future<String> getDeviceType() async {
  if (Platform.isIOS) {
    return "ios";
  } else if(Platform.isAndroid) {
    return "android";
  }else{
    return "web";
  }
}
