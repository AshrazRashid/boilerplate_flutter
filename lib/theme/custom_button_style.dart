import 'package:flutter/material.dart';

import '../core/app_export.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Outline button style
  static ButtonStyle get outlineIndigoF => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.h),
        ),
        shadowColor: appTheme.indigo3003f,
        elevation: 10,
      );
  static ButtonStyle get outlineIndigoFTL15 => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.h),
        ),
        shadowColor: appTheme.indigo3003f,
        elevation: 10,
      );
// text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
