import 'package:flutter/material.dart';
import 'package:society_management/constants/constant.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/utils/size_utils.dart';

class AppTabbar extends StatelessWidget {
  const AppTabbar({super.key, required this.tabs, this.padding});
  final List<Map<String, dynamic>> tabs;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return TabBar(
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: AppColors.primary,
        unselectedLabelColor: const Color(0xFF4A4A4A),
        tabs: tabs
            .map<Widget>(
              (e) => Container(
                width: SizeUtils.width * (tabs.length == 3 ? 0.3 : 0.4),
                padding: padding ?? const EdgeInsets.only(bottom: 5),
                child: Text(
                  e['text'],
                  textAlign: TextAlign.center,
                ),
              ),
            )
            .toList()
        // [
        //   Container(
        //     width: SizeUtils.width * 0.3,
        //     padding: const EdgeInsets.only(bottom: 5),
        //     child: const Text(
        //       "Home",
        //       textAlign: TextAlign.center,
        //     ),
        //   ),
        //   Container(
        //     width: SizeUtils.width * 0.3,
        //     padding: const EdgeInsets.only(bottom: 5),
        //     child: const Text(
        //       "Book",
        //       textAlign: TextAlign.center,
        //     ),
        //   ),
        //   Container(
        //     width: SizeUtils.width * 0.3,
        //     padding: const EdgeInsets.only(bottom: 5),
        //     child: Text(
        //       "Tournaments",
        //       textAlign: TextAlign.center,
        //       style: TextStyle(fontSize: 15.fSize),
        //     ),
        //   ),
        // ],
        );
  }
}
