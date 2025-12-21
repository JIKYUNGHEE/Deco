
import 'package:flutter/material.dart';

import 'app_colors.dart';

class DecoThemeExtension extends ThemeExtension<DecoThemeExtension> {
  final LinearGradient primaryGradient;

  final Color textPrimary;
  final Color textSecondary;
  final Color textPressed;

  final Color outlineColor;
  final Color disabledBg;
  final Color disabledText;

  final Color outlinePressed;
  final Color overlayBase;

  final Color error;

  const DecoThemeExtension({
    required this.primaryGradient,
    required this.textPrimary,
    required this.textSecondary,
    required this.textPressed,
    required this.outlineColor,
    required this.disabledBg,
    required this.disabledText,
    required this.outlinePressed,
    required this.overlayBase,
    required this.error,
  });
  static const light = DecoThemeExtension(
    primaryGradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        AppColors.primary,
        AppColors.secondary,
      ],
    ),
    textPrimary: AppColors.gray900,
    textSecondary: AppColors.gray500,
    textPressed: AppColors.gray700,
    outlineColor: AppColors.gray300,
    disabledText: AppColors.gray300,
    disabledBg: AppColors.gray200,
    outlinePressed: AppColors.primary,
    overlayBase: AppColors.primary,
    error: AppColors.error,
  );

  static const dark = DecoThemeExtension(
    primaryGradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        AppColors.primaryDark,
        AppColors.secondaryDark,
      ],
    ),
    textPrimary: AppColors.gray50,
    textSecondary: AppColors.gray400,
    textPressed: AppColors.gray200,
    outlineColor: AppColors.gray600,
    disabledText: AppColors.gray600,
    disabledBg: AppColors.gray800,
    outlinePressed: AppColors.primaryDark,
    overlayBase: AppColors.primaryDark,
    error: AppColors.errorDark,
  );

  @override
  DecoThemeExtension copyWith({
    LinearGradient? primaryGradient,
    Color? textPrimary,
    Color? textSecondary,
    Color? textPressed,
    Color? outlineColor,
    Color? disabledText,
    Color? disabledBg,
    Color? outlinePressed,
    Color? overlayBase,
    Color? error,
  }) {
    return DecoThemeExtension(
      primaryGradient: primaryGradient ?? this.primaryGradient,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textPressed: textPressed ?? this.textPressed,
      outlineColor: outlineColor ?? this.outlineColor,
      disabledText: disabledText ?? this.disabledText,
      disabledBg: disabledBg ?? this.disabledBg,
      outlinePressed: outlinePressed ?? this.outlinePressed,
      overlayBase: overlayBase ?? this.overlayBase,
      error: error ?? this.error,
    );
  }

  @override
  DecoThemeExtension lerp(ThemeExtension<DecoThemeExtension>? other, double t) {
    if (other is! DecoThemeExtension) return this;
    return DecoThemeExtension(
      primaryGradient:
      LinearGradient.lerp(primaryGradient, other.primaryGradient, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textPressed: Color.lerp(textPressed, other.textPressed, t)!,
      outlineColor: Color.lerp(outlineColor, other.outlineColor, t)!,
      disabledText: Color.lerp(disabledText, other.disabledText, t)!,
      disabledBg: Color.lerp(disabledBg, other.disabledBg, t)!,
      outlinePressed: Color.lerp(outlinePressed, other.outlinePressed, t)!,
      overlayBase: Color.lerp(overlayBase, other.overlayBase, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}