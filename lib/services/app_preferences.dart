import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:society_management/constants/enums.dart';
import 'package:society_management/models/login.dart';
import 'package:society_management/models/user_location.dart';

class AppPreferences {
  static SharedPreferences? _preferences;
  static String? token;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static const String _loginData = "loginData";
  static const String _userLocation = "userLocation";
  static const String _fcmToken = "fcmToken";
  static String session = "session";
  static String startPage = "startPage";

  static setFCMToken(String token) async {
    await _preferences?.setString(_fcmToken, token);
  }

  static String? getFCMToken() => _preferences?.getString(_fcmToken);

  static void setData(String key, Map<String, dynamic> data) =>
      _preferences?.setString(key, jsonEncode(data));

  static Map<String, dynamic> getData(String key) {
    final String? json = _preferences?.getString(key);
    return json == null ? {} : jsonDecode(json);
  }

  static void removeData(String key) => _preferences?.remove(key);

  static void setLogin(Login login) {
    token = login.token;
    _preferences?.setString(_loginData, jsonEncode(login.toJson()));
  }

  static Login? getLogin() {
    final String? json = _preferences?.getString(_loginData);
    Login? login;
    if (json != null) {
      login = Login.fromJson(jsonDecode(json));
      token = login.token;
    }
    return login;
  }

  static void removeLogin() {
    AppPreferences.token = null;
    _preferences?.remove(_loginData);
  }

  static void setStartPage(StartPageType startPageType) =>
      _preferences?.setString(startPage, startPageType.name);

  static StartPageType? getStartPage() {
    final String? val = _preferences?.getString(startPage);
    return val == null
        ? null
        : StartPageType.values.firstWhere((element) => element.name == val);
  }

  static void removeStartPage() => _preferences?.remove(startPage);

  static void setLocation(UserLocation location) =>
      _preferences?.setString(_userLocation, jsonEncode(location.toJson()));

  static UserLocation? getLocation() {
    final String? json = _preferences?.getString(_userLocation);
    return json == null ? null : UserLocation.fromJson(jsonDecode(json));
  }
}
