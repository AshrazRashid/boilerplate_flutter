import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      this.backgroundColor,
      this.iconSize,
      this.style,
      this.buttonSize});
  final Function() onPressed;
  final Widget icon;
  final Color? backgroundColor;
  final double? iconSize;
  final ButtonStyle? style;
  final double? buttonSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonSize,
      width: buttonSize,
      child: IconButton(
        onPressed: onPressed,
        iconSize: iconSize,
        icon: icon,
        style: style ?? IconButton.styleFrom(backgroundColor: backgroundColor),
      ),
    );
  }
}
