import 'package:society_management/presentation/sign_in_screen/sign_in_screen.dart';

import '../app_export.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String signInScreen = '/sign_in_screen';

  static List<GetPage> pages = [
    GetPage(
      name: signInScreen,
      page: () => const SigninScreen(),
    ),
  ];
}
