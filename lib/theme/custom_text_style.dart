import 'package:flutter/material.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/theme/fonts.dart';
import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  // Body text style
  static get bodyMediumGray900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray900,
        fontSize: 15.fSize,
      );
  static get bodyBoldGray900 => theme.textTheme.bodyMedium!.copyWith(
      color: appTheme.gray900, fontSize: 15.fSize, fontWeight: FontWeight.bold);

  static get bodyMediumOnPrimaryContainer =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 15.fSize,
      );
  static get bodyMediumOnPrimaryContainer15 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 15.fSize,
      );
  static get bodyMediumOnPrimaryContainer_1 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get bodyMediumPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary.withOpacity(0.64),
        fontSize: 15.fSize,
      );
// Title text style
  static get titleMedium16 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 16.fSize,
        fontFamily: Fonts.medium,
        color: AppColors.text,
      );
  static TextStyle get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
        fontFamily: Fonts.medium,
        color: AppColors.text,
      );
  static get titleMediumGray500 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray500,
        fontSize: 16.fSize,
      );
  static get titleMediumSecondaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.secondaryContainer,
      );
}
