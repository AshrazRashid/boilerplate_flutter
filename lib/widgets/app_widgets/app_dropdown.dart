import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:society_management/core/app_export.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/widgets/app_widgets/app_text.dart';
import 'package:society_management/widgets/misc/reuseable_widget.dart';

class AppDropdown extends StatelessWidget {
  const AppDropdown(
      {super.key,
      required this.name,
      required this.placeholder,
      required this.items,
      required this.width,
      this.color = Colors.white,
      this.onChanged,
      this.placeholderStyle,
      this.title,
      this.borderColor,
      this.borderWidth,
      this.showBorder = true,
      this.icon,
      this.validator,
      this.isEnabled = true});
  final String name;
  final String placeholder;
  final List<DropdownMenuItem<dynamic>> items;
  final double width;
  final TextStyle? placeholderStyle;
  final Function(dynamic)? onChanged;
  final Color color;
  final String? title;
  final Color? borderColor;
  final double? borderWidth;
  final bool showBorder;
  final String? icon;
  final String? Function(dynamic)? validator;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: AppText(
              text: title!,
              style: AppText.defaultFontStyle
                  .copyWith(color: const Color(0xFF4A4A4A)),
            ),
          ),
        Container(
            width: width,
            height: 60,
            decoration: BoxDecoration(
                border: showBorder
                    ? Border.all(
                        color: borderColor ?? AppColors.border,
                        width: borderWidth ?? 1)
                    : null,
                color: color,
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.only(left: 10, right: 15),
            child: FormBuilderDropdown(
              name: name,
              enabled: isEnabled,
              validator: validator,
              onChanged: (value) {
                if (onChanged != null) {
                  onChanged!(value);
                }
              },
              icon: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ReusableWidget.loadSvg('arrow_down',
                    color: LightCodeColors().gray600, width: 15),
              ),
              isExpanded: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: icon != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 15, right: 15, bottom: 15),
                          child: ReusableWidget.loadSvg(icon!),
                        )
                      : null,
                  hintText: placeholder,
                  hintStyle: placeholderStyle ?? AppText.defaultFontStyle),
              items: items,
            )),
      ],
    );
  }
}
