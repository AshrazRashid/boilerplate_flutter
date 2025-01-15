import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/widgets/app_widgets/app_text.dart';

class AppPhoneNumberInput extends StatelessWidget {
  const AppPhoneNumberInput(
      {super.key,
      required this.onPhoneNumberChanged,
      required this.onPhoneNumberValidated,
      required this.phoneNumber,
      this.color = Colors.white,
      this.title,
      this.borderWidth = 1,
      this.hintText = "Phone number",
      this.isEnabled = true});
  final Function(PhoneNumber) onPhoneNumberChanged;
  final Function(bool) onPhoneNumberValidated;
  final PhoneNumber phoneNumber;
  final String hintText;
  final Color color;
  final String? title;
  final double borderWidth;
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
              color: color,
              border: Border.all(color: AppColors.border, width: borderWidth),
              borderRadius: BorderRadius.circular(10)),
          child: InternationalPhoneNumberInput(
            isEnabled: isEnabled,
            inputBorder:
                const OutlineInputBorder(borderSide: BorderSide(width: 1)),
            onInputChanged: (PhoneNumber number) {
              var phoneNum = number.phoneNumber?.split(number.dialCode!)[1];
              var finalNum = "${number.dialCode}$phoneNum";
              onPhoneNumberChanged(number);
              print("patched $finalNum");
            },
            onInputValidated: (bool value) {
              onPhoneNumberValidated(value);
            },
            // validator: (val) {
            //   if (val != null && val.startsWith('0')) {
            //     return "Must not start with 0";
            //   }
            //   return null;
            // },
            inputDecoration:
                InputDecoration(border: InputBorder.none, hintText: hintText),
            hintText: hintText,
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.DIALOG,
            ),
            initialValue: phoneNumber,
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            selectorTextStyle: const TextStyle(color: Colors.black),
            formatInput: true,
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: true),
            onSaved: (PhoneNumber number) {
              print('On Saved: $number');
            },
          ),
        ),
      ],
    );
  }
}
