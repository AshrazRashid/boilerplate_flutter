import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard(
      {super.key,
      required this.child,
      this.padding,
      this.margin,
      this.borderColor = Colors.transparent,
      this.borderWidth = 1,
      this.borderRadius,
      this.onTap,
      this.clipBehavior = Clip.none,
      this.width,
      this.height});
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color borderColor;
  final double borderWidth;
  final BorderRadiusGeometry? borderRadius;
  final Function()? onTap;
  final Clip clipBehavior;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        clipBehavior: clipBehavior,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
            border: Border.all(width: borderWidth, color: borderColor),
            color: Colors.white,
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200, blurRadius: 2, spreadRadius: 2)
            ]),
        child: child,
      ),
    );
  }
}
