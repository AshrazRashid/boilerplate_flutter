import 'package:flutter/material.dart';
import 'package:society_management/theme/app_colors.dart';
import '../../core/app_export.dart';
import '../../theme/fonts.dart';

class AppButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final Widget? icon;
  final Alignment? alignment;
  final bool showIconRightIcon;
  final bool isLoading;
  final bool isDisabled;
  final Color? borderColor;
  final double? borderWith;
  final double? borderRadius;
  const AppButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.alignment,
      this.color,
      this.textColor,
      this.width,
      this.height,
      this.icon,
      this.showIconRightIcon = true,
      this.isLoading = false,
      this.isDisabled = false,
      this.borderColor,
      this.borderWith,
      this.borderRadius});

  buttonStyle() => ElevatedButton.styleFrom(
      shadowColor: Colors.black,
      backgroundColor: isDisabled ? Colors.grey : (color ?? AppColors.primary),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          side: BorderSide(
              color: borderColor ?? color ?? AppColors.primary,
              width: borderWith ?? 0)),
      fixedSize: Size(width ?? Get.width * 0.8, height ?? 55.v));

  _buildText() => isLoading
      ? const CircularProgressIndicator()
      : Text(text,
          style: TextStyle(
              color: isDisabled ? Colors.black38 : textColor ?? Colors.white,
              fontFamily: Fonts.semiBold));

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: alignment ?? Alignment.center,
        child: icon != null
            ? ElevatedButton.icon(
                style: buttonStyle(),
                onPressed: isDisabled || isLoading ? () {} : onPressed,
                icon: icon ?? const SizedBox(),
                label: _buildText())
            : ElevatedButton(
                onPressed: isDisabled || isLoading ? () {} : onPressed,
                style: buttonStyle(),
                child: !showIconRightIcon
                    ? _buildText()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.h),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 20.h,
                              ),
                              _buildText(),
                              if (showIconRightIcon)
                                CircleAvatar(
                                  radius: 16.h,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 17.h,
                                  ),
                                )
                            ]),
                      ),
              ));
  }
}
