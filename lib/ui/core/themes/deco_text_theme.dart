import 'package:flutter/material.dart';

class DecoTextTheme {
  static TextTheme create({
    required TextTheme base,
    required String fontFamily,
    required Color color,
  }) {
    TextStyle? s(TextStyle? t) => t?.copyWith(fontFamily: fontFamily, color: color);

    return base.copyWith(
      // 큰 타이틀
      headlineLarge: s(base.headlineLarge)?.copyWith(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        height: 1.12,
        letterSpacing: -0.4,
      ),

      // 섹션 타이틀
      headlineMedium: s(base.headlineMedium)?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.15,
        letterSpacing: -0.3,
      ),

      // 앱바/화면 타이틀
      titleLarge: s(base.titleLarge)?.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.3,
      ),

      // 카드/리스트 타이틀
      titleMedium: s(base.titleMedium)?.copyWith(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.1,
      ),

      // 서브 타이틀
      titleSmall: s(base.titleSmall)?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.25,
        letterSpacing: 0.0,
      ),

      // 본문
      bodyLarge: s(base.bodyLarge)?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.42,
        letterSpacing: 0.0,
      ),
      bodyMedium: s(base.bodyMedium)?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.42,
        letterSpacing: 0.0,
      ),
      bodySmall: s(base.bodySmall)?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: 0.1,
      ),

      // 라벨
      labelLarge: s(base.labelLarge)?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: 0.0,
      ),
      labelMedium: s(base.labelMedium)?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: 0.1,
      ),
      labelSmall: s(base.labelSmall)?.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        height: 1.15,
        letterSpacing: 0.1,
      ),
    );
  }
}
