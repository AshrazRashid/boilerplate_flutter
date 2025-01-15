import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:society_management/constants/enums.dart';
import 'package:society_management/core/app_export.dart';
import 'package:society_management/services/app_preferences.dart';
import 'package:upgrader/upgrader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Upgrader().initialize();
      var login = AppPreferences.getLogin();
      String startPage = AppRoutes.signInScreen;
      if (login != null && login.getJwtExpiry().isAfter(DateTime.now())) {
        startPage =
            // RoleEnum.isSG()
            //     ? AppRoutes.upcomingVisitorsScreen
            //     :
            AppRoutes.signInScreen;
        log(jsonEncode(login.toJson()));
      }

      Get.offAndToNamed(startPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Image.asset(
      ImageConstant.logo,
      width: SizeUtils.width * 0.7,
    )));
  }
}
