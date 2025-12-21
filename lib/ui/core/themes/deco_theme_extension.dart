
import 'package:flutter/material.dart';

class DecoThemeExtension extends ThemeExtension<DecoThemeExtension> {
  final LinearGradient primaryGradient;
  final Color outlineColor;
  final Color disabledBg;
  final Color disabledText;

  const DecoThemeExtension({
    required this.primaryGradient,
    required this.outlineColor,
    required this.disabledBg,
    required this.disabledText,
  });
  static const light = DecoThemeExtension(
    primaryGradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFFE85AAE),
        Color(0xFF7A5CFF),
      ],
    ),
    outlineColor: Color(0xFFE5A6D0),
    disabledBg: Color(0xFFE5E7EB),
    disabledText: Color(0xFF9CA3AF),
  );

  static const dark = DecoThemeExtension(
    primaryGradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFFB93D87),
        Color(0xFF5A45CC),
      ],
    ),
    outlineColor: Color(0xFF6B3A57),
    disabledBg: Color(0xFF2A2E37),
    disabledText: Color(0xFF9CA3AF),
  );

  @override
  DecoThemeExtension copyWith({
    LinearGradient? primaryGradient,
    Color? outlineColor,
    Color? disabledBg,
    Color? disabledText,
  }) {
    return DecoThemeExtension(
      primaryGradient: primaryGradient ?? this.primaryGradient,
      outlineColor: outlineColor ?? this.outlineColor,
      disabledBg: disabledBg ?? this.disabledBg,
      disabledText: disabledText ?? this.disabledText,
    );
  }

  @override
  DecoThemeExtension lerp(ThemeExtension<DecoThemeExtension>? other, double t) {
    if (other is! DecoThemeExtension) return this;
    return DecoThemeExtension(
      primaryGradient: LinearGradient.lerp(primaryGradient, other.primaryGradient, t)!,
      outlineColor: Color.lerp(outlineColor, other.outlineColor, t)!,
      disabledBg: Color.lerp(disabledBg, other.disabledBg, t)!,
      disabledText: Color.lerp(disabledText, other.disabledText, t)!,
    );
  }
}