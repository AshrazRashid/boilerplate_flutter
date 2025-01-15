import 'package:flutter/material.dart';
import 'package:society_management/theme/app_colors.dart';

class CircleOutlined extends StatelessWidget {
  const CircleOutlined(
      {super.key,
      required this.size,
      required this.child,
      this.borderColor,
      this.borderWidth = 2});
  final double size;
  final Color? borderColor;
  final double borderWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(
              color: borderColor ?? AppColors.primary, width: borderWidth),
          borderRadius: BorderRadius.circular(size / 2)),
      child: child,
    );
  }
}
