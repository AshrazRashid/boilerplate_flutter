import 'package:flutter/material.dart';
import 'package:society_management/core/app_export.dart';

class AppText extends StatelessWidget {
  const AppText(
      {super.key,
      required this.text,
      this.style,
      this.padding,
      this.maxLines,
      this.overflow = TextOverflow.visible,
      this.textAlign = TextAlign.start,
      this.width});
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? padding;
  final int? maxLines;
  final TextOverflow overflow;
  final double? width;

  static TextStyle defaultFontStyle =
      TextStyle(color: Colors.black.withOpacity(0.65), fontSize: 14.fSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      width: width,
      child: Text(
        text,
        overflow: overflow,
        style: style ?? defaultFontStyle,
        textAlign: textAlign,
        maxLines: maxLines,
      ),
    );
  }
}
