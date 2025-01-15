import 'package:get/get.dart';
import 'package:society_management/datasource/app_data_source.dart';
import 'package:society_management/datasource/auth_datasource.dart';
import 'package:society_management/repos/app_repo.dart';
import '../repos/auth_repo.dart';

class DI {
  static initServices() async {
    ///Common

    await Future.delayed(const Duration(seconds: 1));

    //Services
    // Get.lazyPut(() => RealTimeConfigService(), fenix: true);

    ///DataSource
    Get.lazyPut<AuthDataSource>(() => AuthDataSourceImpl(), fenix: true);
    Get.lazyPut<AppDataSource>(() => AppDataSourceImpl(), fenix: true);

    ///Repository
    Get.lazyPut(() => AuthRepository(), fenix: true);
    Get.lazyPut(() => AppRepository(), fenix: true);

    ///controllers
    // Get.lazyPut(() => SigninController(), fenix: true);
  }
}
