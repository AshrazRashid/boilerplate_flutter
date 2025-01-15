import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/widgets/app_widgets/app_text.dart';

class AppDateTimePicker extends StatelessWidget {
  final String placeholder;
  final bool showTitle;
  final String? title;
  final DateTime minDate;
  final DateTime maxDate;
  final String name;
  final Function(DateTime?)? onDateSelected;
  final String? Function(DateTime?)? validator;
  final InputType inputType;
  final double? width;
  final Color color;
  final Widget? sufficIcon;
  final DateTime? initialDate;
  final String format;

  const AppDateTimePicker(
      {super.key,
      required this.placeholder,
      this.title,
      required this.minDate,
      required this.maxDate,
      this.onDateSelected,
      required this.name,
      this.validator,
      this.showTitle = true,
      this.inputType = InputType.date,
      this.width,
      this.sufficIcon,
      this.color = Colors.white,
      this.initialDate,
      this.format = "dd-MMM-yyyy"});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showTitle && title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: AppText(
                text: title!,
                style: AppText.defaultFontStyle
                    .copyWith(color: const Color(0xFF4A4A4A)),
              ),
            ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.border),
                color: color,
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.only(left: 10),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.primary, // header background color
                  onPrimary: Colors.white, // header text color
                  onSurface: AppColors.text, // body text color
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary, // button text color
                  ),
                ),
              ),
              child: FormBuilderDateTimePicker(
                inputType: inputType,
                format: DateFormat(format),
                validator: validator,
                currentDate: DateTime.now(),
                decoration: InputDecoration(
                    suffixIcon: sufficIcon,
                    hintText: placeholder,
                    hintStyle: AppText.defaultFontStyle,
                    border: InputBorder.none),
                onChanged: onDateSelected,
                name: name,
                initialDate: initialDate ?? DateTime.now(),
                firstDate: minDate,
                initialTime: TimeOfDay.fromDateTime(
                  DateTime.now().add(const Duration(minutes: 1)),
                ),
                lastDate: maxDate,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
