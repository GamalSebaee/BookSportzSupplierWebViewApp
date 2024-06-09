import 'package:permission_handler/permission_handler.dart';

Future<bool> isLocationPermissionGranted() async {
  var status = await Permission.location.status;

  return (status.isGranted);
}

Future<bool> isNotificationPermissionGranted() async {
  var status = await Permission.notification.status;

  return (status.isGranted);
}

Future<void> requestNotificationPermission() async {
  Permission.notification.request();
}

Future<void> requestLocationPermission() async {
  Permission.location.request();
}

Future<bool> requestPermission({required Permission permission}) async {
  var request = await permission.request();
  if (request.isGranted) {
    return true;
  } else {
    return false;
  }
}

var appPermissions = [Permission.notification, Permission.location];

Future<List<Permission>> getMissingPermissions() async {
  List<Permission> missingPermissions = [];
  for (var element in appPermissions) {
    if ((await element.status.isDenied ||
        await element.status.isPermanentlyDenied)) {
      missingPermissions.add(element);
    }
  }
  return missingPermissions;
}
