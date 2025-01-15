import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:society_management/constants/enums.dart';
import 'package:society_management/core/app_export.dart';
import 'package:society_management/models/login.dart';
import 'package:society_management/repos/app_repo.dart';
import 'package:society_management/services/app_preferences.dart';

class DrawerWidgetController extends GetxController {
  Rx<Login> user = Rx(AppPreferences.getLogin()!);

  RxList drawerList = RxList();

  @override
  void onInit() {
    super.onInit();
    drawerList.value = [
      {
        "title": "Dashboard",
        "route": AppRoutes.dashboardScreen,
        "icon": Icons.dashboard,
        "roles": [RoleEnum.residential.value, RoleEnum.residentialChild.value]
      },
      {
        "title": "Visitors",
        "route": AppRoutes.visitorsScreen,
        "icon": Icons.list,
        "roles": [RoleEnum.residential.value, RoleEnum.residentialChild.value]
      },
      {
        "title": "Today's Visitors",
        "route": AppRoutes.upcomingVisitorsScreen,
        "icon": Icons.list,
        "roles": [RoleEnum.securityGuard.value]
      },
      {
        "title": "Subusers",
        "route": AppRoutes.subusersScreen,
        "icon": Icons.manage_accounts,
        "roles": [RoleEnum.residential.value]
      },
      {
        "title": "Maintenance Requests",
        "route": AppRoutes.requestsScreen,
        "icon": Icons.view_list,
        "roles": [RoleEnum.residential.value],
        "isVisible": false,
        "visibleProp": "isMaintenanceVisible"
      },
      {
        "title": "Chat",
        "route": AppRoutes.inboxScreen,
        "icon": Icons.chat,
        "roles": [RoleEnum.residential.value],
        "isVisible": false,
        "visibleProp": "isChatVisible"
      },
      {
        "title": "Edit Profile",
        "route": AppRoutes.profileScreen,
        "icon": Icons.edit,
      },
      {"title": "Logout", "icon": Icons.logout},
    ];
  }

  void logout() async {
    Get.find<AppRepository>().removeFirebaseToken(AppPreferences.getFCMToken());
    AppPreferences.removeLogin();
    Get.deleteAll();
    Get.offNamedUntil(AppRoutes.signInScreen, (route) => false);
  }
}
