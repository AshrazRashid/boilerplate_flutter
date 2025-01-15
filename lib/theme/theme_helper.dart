import 'package:flutter/material.dart';
import 'package:society_management/constants/constant.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/theme/fonts.dart';
import 'package:society_management/utils/size_utils.dart';
import '../core/app_export.dart';
import '../utils/pref_utils.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // The current app theme
  final _appTheme = PrefUtils().getThemeData();

// A map of custom color themes supported by the app
  final Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

// A map of color schemes supported by the app
  final Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Changes the app theme to [newTheme].
  void changeTheme(String newTheme) {
    PrefUtils().setThemeData(newTheme);
    Get.forceAppUpdate();
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.secondary,
        selectionColor: AppColors.secondary.withOpacity(0.3),
        selectionHandleColor: AppColors.secondary,
      ),
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      fontFamily: Fonts.regular,
      textTheme:
          TextThemes.textTheme(colorScheme).apply(fontFamily: Fonts.regular),
      scaffoldBackgroundColor: colorScheme.primary,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: colorScheme.errorContainer,
          elevation: 0,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: colorScheme.onPrimaryContainer,
          fontSize: 16.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: appTheme.gray600,
          fontSize: 14.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        displaySmall: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 35.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: TextStyle(
          color: colorScheme.onPrimaryContainer,
          fontSize: 24.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          color: colorScheme.primary,
          fontSize: 22.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: colorScheme.primary,
          fontSize: 18.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static const lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFFFFFFFF),
    primaryContainer: Color(0XFF2E55B9),
    secondaryContainer: Color(0X87FFFFFF),
    errorContainer: Color(0X3FD2D4E2),
    onErrorContainer: Color(0XFF171766),
    onPrimary: Color(0XFF37364A),
    onPrimaryContainer: Color(0XFF110C26),
  );
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  // Black
  Color get black900 => const Color(0XFF000000);
// Blue
  Color get blueA400 => const Color(0XFF1977F3);
// BlueGray
  Color get blueGray400 => const Color(0XFF888888);
// Gray
  Color get gray300 => const Color(0XFFE4DEDE);
  Color get gray500 => const Color(0XFF9D9898);
  Color get gray50001 => const Color(0XFF979797);
  Color get gray600 => const Color(0XFF747688);
  Color get gray60001 => const Color(0XFF7F7979);
  Color get gray900 => const Color(0XFF0B1A39);
// Indigof
  Color get indigo3003f => const Color(0X3F6F7DC8);
// Indigo
  Color get indigoA200 => const Color(0XFF5A61FF);
  Color get indigoA20001 => const Color(0XFF5668FF);
// Red
  Color get red600 => const Color(0XFFE43E2B);
}
