import 'package:flutter/material.dart';

class AppColors {
  // ===== Neutral (Light) =====
  static const gray900 = Color(0xFF111827);
  static const gray700 = Color(0xFF374151);
  static const gray500 = Color(0xFF6B7280);
  static const gray300 = Color(0xFFD1D5DB);
  static const gray200 = Color(0xFFE5E7EB);
// ===== Neutral (Dark) =====
  static const gray50  = Color(0xFFF9FAFB);
  static const gray400 = Color(0xFF9CA3AF);
  static const gray600 = Color(0xFF4B5563);
  static const gray800 = Color(0xFF1F2937);
  static const gray900Dark = Color(0xFF111827);

  static const error = Color(0xFFE44D61);
  static const errorDark = Color(0xFFFF6B7A);

  // Brand
  static const primary = Color(0xFFFF4FA3); // 핑크(메인 버튼/포인트)
  static const secondary = Color(0xFF8B5CF6); // 퍼플(서브 포인트)

  static const primaryDark = Color(0xFFB93D87);
  static const secondaryDark = Color(0xFF5A45CC);

  // Accent (홈 카드들에 보이는 주황 계열)
  static const accentOrange = Color(0xFFFFA62B);

  // Background / Surface
  static const bg = Color(0xFFF6F2FF); // 연보라 톤 배경
  static const surface = Colors.white;

  // Text
  static const text = Color(0xFF1F1F1F);
  static const subText = Color(0xFF6B6B6B);

  // Border
  static const border = Color(0xFFE7E1F3);

  // ===== Dark Palette =====
  static const darkBg = Color(0xFF0F0C18);       // 아주 진한 보라빛 블랙
  static const darkSurface = Color(0xFF181226);  // 카드/시트 배경
  static const darkText = Color(0xFFF4F2FF);     // 본문 텍스트
  static const darkSubText = Color(0xFFB9B4C9);  // 보조 텍스트
  static const darkBorder = Color(0xFF2A223A);   // 테두리

  // 다크에서 쓰기 좋은 그라데이션(조금 더 딥하게)
  static const darkBrandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );

  // Gradients
  static const brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );

  static const warmGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentOrange, primary],
  );
}