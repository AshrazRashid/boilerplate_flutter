import 'package:flutter/material.dart';
import 'package:society_management/core/app_export.dart';
import 'package:society_management/widgets/app_widgets/app_text.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? SizeUtils.width,
      height: height ?? SizeUtils.height,
      alignment: Alignment.center,
      child: AppText(
        text: "No Data found",
      ),
    );
  }
}
