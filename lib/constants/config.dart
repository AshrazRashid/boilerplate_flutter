import 'enums.dart';

class AppConfig {
  AppConfig._();
  static bool isHttps = false;
  static bool isInternalHttps = false;

  //Base Url For APP
  static EnvironmentEnum env = EnvironmentEnum.prod;
  //Base Url For APP

  static setEnv(EnvironmentEnum environment) {
    env = environment;
  }

  static bool get isDev => env != EnvironmentEnum.prod; // DO NOT UPDATE

  static String get baseUrl {
    switch (env) {
      case EnvironmentEnum.dev:
        {
          return 'http://staging.yoururl.com';
        }
      default:
        return 'http://live.yoururl.com';
    }
  }
}
