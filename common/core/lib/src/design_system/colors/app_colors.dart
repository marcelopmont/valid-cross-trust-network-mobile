import 'package:flutter/material.dart';

abstract final class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF000000);

  // Accent
  static const Color accent = Color(0xFF0F3D66);

  // Backgrounds
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);

  // Border
  static const Color border = Color(0xFFE1E6ED);

  // Semantic
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
}
