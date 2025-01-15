import 'package:flutter/material.dart';
import 'package:society_management/theme/app_colors.dart';
import '../../core/app_export.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: Get.back,
        child: const Padding(
          padding: EdgeInsets.only(top: 10.0, right: 10, bottom: 10),
          child: Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
        ));
  }
}
