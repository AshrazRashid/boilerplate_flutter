import 'package:flutter/services.dart';

class CNICInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digitsOnly.length > 13) {
      digitsOnly = digitsOnly.substring(0, 13);
    }

    String formatted = '';
    if (digitsOnly.length == 13) {
      formatted =
          '${digitsOnly.substring(0, 5)}-${digitsOnly.substring(5, 12)}-${digitsOnly.substring(12, 13)}';
    } else if (digitsOnly.length > 5) {
      formatted =
          '${digitsOnly.substring(0, 5)}-${digitsOnly.substring(5, digitsOnly.length)}';
    } else {
      formatted = digitsOnly;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
