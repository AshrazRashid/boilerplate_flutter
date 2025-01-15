import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:society_management/constants/enums.dart';
import 'package:society_management/core/app_export.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/utils/util.dart';
import 'package:society_management/widgets/app_widgets/circle_avatar_with_loader.dart';
import 'package:society_management/widgets/misc/developed_by_widget.dart';
import 'package:society_management/widgets/misc/drawer/drawer_controller.dart';
import '../misc_widget.dart';

// ignore: must_be_immutable
class DrawerWidget extends GetView<DrawerWidgetController> {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Colors.white,
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Column(
        children: [
          Expanded(
            child: Obx(() {
              var user = controller.user.value;
              return ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          CircleAvatarWithLoader(
                            radius: 40,
                            imageUrl: Util.getImageUrl(user.photo),
                          ),
                          const AppSpacerW(15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                user.name!,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                  width: Get.width * 0.42,
                                  child: Text(
                                    RoleEnum.isSG()
                                        ? "Security Representative"
                                        : "Resident",
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 13),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  ...controller.drawerList.value
                      .where((element) =>
                          (element['roles'] == null ||
                              element['roles']
                                  .contains(controller.user.value.roleId)) &&
                          (element['isVisible'] == null ||
                              element['isVisible'] == true))
                      .map<Widget>(
                        (item) => ListTile(
                          leading: Icon(item['icon']),
                          title: Text(item['title']),
                          shape: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.primary.withOpacity(0.25))),
                          onTap: () {
                            Navigator.pop(context);
                            if (item['route'] != null) {
                              Get.toNamed(item['route']);
                            } else {
                              controller.logout();
                            }
                          },
                        ),
                      ),
                ],
              );
            }),
          ),
          const DevelopedByWidget()
        ],
      ),
    );
  }
}
