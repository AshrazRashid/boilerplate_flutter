import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:society_management/constants/constant.dart';
import 'package:society_management/services/app_preferences.dart';
import 'package:society_management/services/firebase_service.dart';
import 'package:society_management/widgets/misc/misc_widget.dart';
import 'core/di.dart';
import 'utils/context_less_nav.dart';
import 'core/app_export.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await DI.initServices();
  await AppPreferences.init();
  await Firebase.initializeApp();
  await FirebaseService().init();
  await Future.delayed(const Duration(seconds: 1));
  // SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(statusBarColor: Colors.white));
  // Future.delayed(const Duration(seconds: 2))
  //     .then((value) => FirebaseCrashlytics.instance.crash());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (_) => const LoadingWidget(),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          translations: AppLocalization(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
          title: AppConstants.appShortName,
          navigatorKey: ContextLess.navigatorkey,
          initialRoute: AppRoutes.splashScreen,
          getPages: AppRoutes.pages,
        ),
      );
    });
  }
}
