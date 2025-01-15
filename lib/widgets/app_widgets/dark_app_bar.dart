import 'package:flutter/material.dart';
import 'package:society_management/core/app_export.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/theme/fonts.dart';
import 'package:society_management/widgets/app_widgets/app_text.dart';
import 'package:society_management/widgets/misc/misc_widget.dart';
import 'package:society_management/widgets/misc/reuseable_widget.dart';

class DarkAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DarkAppBar(
      {super.key,
      required this.title,
      this.showProfile = false,
      this.showNotification = false,
      this.centerWidget,
      this.leading});
  final String title;
  final bool showProfile;
  final bool showNotification;
  final Widget? centerWidget;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80.v,
      leadingWidth: 100,
      leading: leading ??
          (showProfile
              ? Row(
                  children: [
                    const AppSpacerW(15),
                    IconButton(
                        style: IconButton.styleFrom(
                            backgroundColor: Colors.white10),
                        onPressed: () {
                          // Navigator.of(context).push(
                          //   CupertinoPageRoute(
                          //     fullscreenDialog: true,
                          //     builder: (context) => ProfileOptionsModal(),
                          //   ),
                          // );

                          // AppPreferences.removeLogin();
                          // Get.deleteAll();
                          // Get.offNamedUntil(AppRoutes.signInScreen, (route) => false);
                        },
                        icon: ReusableWidget.loadSvg("hamburger",
                            color: Colors.white, width: 17)),
                  ],
                )
              : const SizedBox()),
      backgroundColor: AppColors.primary,
      centerTitle: true,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(80.h),
        bottomRight: Radius.circular(80.h),
      )),
      actions: [
        if (showNotification) ...[
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.1),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ReusableWidget.loadSvg("bell",
                      color: Colors.white, width: 15),
                  Positioned(
                    right: -4,
                    top: -3,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 5.h,
                      child: CircleAvatar(
                        backgroundColor: AppColors.secondary,
                        radius: 3.h,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
        const AppSpacerW(20)
      ],
      title: centerWidget ??
          AppText(
            text: title,
            style: TextStyle(color: Colors.white, fontFamily: Fonts.semiBold),
          ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
