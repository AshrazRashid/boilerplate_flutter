import 'package:flutter/services.dart';

class PreventLeadingZeroInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // If the new value starts with zero and is not empty, return the old value
    if (newValue.text.startsWith('0') && newValue.text.length == 1) {
      // Prevent the zero from being added
      return oldValue;
    }
    return newValue;
  }
}
