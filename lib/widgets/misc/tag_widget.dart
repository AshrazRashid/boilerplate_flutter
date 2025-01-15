import 'package:flutter/material.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/theme/fonts.dart';

import '../app_widgets/app_text.dart';

class TagWidget extends StatelessWidget {
  const TagWidget(
      {super.key,
      required this.tag,
      this.borderRadius = 15,
      this.height = 28,
      this.fontSize = 12,
      this.width,
      this.color,
      this.textWidth,
      this.onRemove});
  final String tag;
  final double borderRadius;
  final double height;
  final double? width;
  final Color? color;
  final double fontSize;
  final double? textWidth;
  final Function(String)? onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: height,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: color ?? AppColors.secondary)),
          child: AppText(
            text: tag,
            width: textWidth,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.defaultFontStyle.copyWith(
                color: color ?? AppColors.secondary,
                fontSize: fontSize,
                fontFamily: Fonts.medium),
          ),
        ),
        if (onRemove != null)
          Positioned(
              right: -7,
              child: GestureDetector(
                onTap: () => onRemove!(tag),
                child: Container(
                    width: height / 1.5,
                    height: height / 1.5,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(height)),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: height / 3,
                    )),
              ))
      ],
    );
  }
}
