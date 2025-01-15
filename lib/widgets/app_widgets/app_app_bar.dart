import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:society_management/core/app_export.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/theme/fonts.dart';
import 'package:society_management/widgets/app_widgets/app_text.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar(
      {super.key,
      required this.title,
      this.color = AppColors.primary,
      this.elevation = 0,
      this.centerWidget,
      this.actions});
  final String title;
  final Color color;
  final double elevation;
  final Widget? centerWidget;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      foregroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      actions: actions,
      backgroundColor: color,
      elevation: elevation,
      centerTitle: true,
      shadowColor: Colors.black38,
      title: centerWidget != null
          ? centerWidget!
          : AppText(
              text: title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.fSize,
                  fontFamily: Fonts.medium),
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
