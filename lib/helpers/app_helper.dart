import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:society_management/repos/app_repo.dart';
import '../core/app_export.dart';
import '../services/app_preferences.dart';

class AppHelper {
  static Future<void> handleFirebaseToken(String? token) async {
    log("handleFirebaseToken $token");
    if (token != null) {
      AppPreferences.setFCMToken(token);
    } else if (AppPreferences.getFCMToken() != null) {
      var fcmToken = AppPreferences.getFCMToken()!;
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      String deviceModel;
      String deviceName;

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceModel = androidInfo.model;
        deviceName = androidInfo.manufacturer;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceModel = iosInfo.utsname.machine;
        deviceName = iosInfo.name;
      } else {
        deviceModel = 'Unknown';
        deviceName = 'Unknown';
      }

      var repo = Get.find<AppRepository>();
      repo.addFirebaseToken({
        "token": fcmToken,
        "device": deviceModel,
        "name": deviceName,
        "timeStamp": DateTime.now().toIso8601String(),
        "os": Platform.isAndroid ? 'android' : 'iOS',
      });
    }
  }
}
