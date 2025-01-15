import 'package:flutter/material.dart';
import 'package:society_management/core/app_export.dart';
import 'package:society_management/theme/app_colors.dart';

class AppOutlineButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final IconData? icon;
  const AppOutlineButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.color,
      this.textColor,
      this.width,
      this.height,
      this.icon});

  buttonStyle() => OutlinedButton.styleFrom(
      side: BorderSide(width: 1, color: _getColor()),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      fixedSize: Size(width ?? Get.width * 0.8, height ?? 65.v));

  _buildText() => Text(text, style: TextStyle(color: _getColor()));

  _getColor() => color ?? AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? OutlinedButton.icon(
            style: buttonStyle(),
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: _getColor(),
            ),
            label: _buildText())
        : OutlinedButton(
            onPressed: onPressed,
            style: buttonStyle(),
            child: _buildText(),
          );
  }
}
