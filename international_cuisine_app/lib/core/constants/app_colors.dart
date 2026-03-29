import 'package:flutter/material.dart';

class AppColors {
  // ── Primary Palette ──
  static const Color primary = Color(0xFFFF8C00); // Dark Orange
  static const Color primaryLight = Color(0xFFFFAD33);
  static const Color primaryDark = Color(0xFFCC7000);

  // ── Secondary Palette ──
  static const Color secondary = Color(0xFFE8B931); // Gold
  static const Color secondaryLight = Color(0xFFF0D060);

  // ── CTA / Accent ──
  static const Color cta = Color(0xFFFF6B35); // Vivid Orange-Red
  static const Color ctaHover = Color(0xFFE85A25);

  // ── Backgrounds ──
  static const Color background = Color(0xFF121212);
  static const Color backgroundLight = Color(0xFF1A1A2E);
  static const Color scaffoldDark = Color(0xFF0D0D0D);

  // ── Surfaces ──
  static const Color surface = Color(0xFF1E1E2C);
  static const Color surfaceVariant = Color(0xFF2A2A3E);
  static const Color surfaceElevated = Color(0xFF252538);
  static const Color overlay = Color(0x33FFFFFF); // 20% white

  // ── Text ──
  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFFB0B0C0);
  static const Color textMuted = Color(0xFF78788C);
  static const Color textOnPrimary = Color(0xFF121212);

  // ── Semantic ──
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color warning = Color(0xFFFFA726);
  static const Color warningLight = Color(0xFFFFCC80);
  static const Color error = Color(0xFFEF5350);
  static const Color errorLight = Color(0xFFE57373);
  static const Color info = Color(0xFF42A5F5);

  // ── Difficulty ──
  static const Color difficultyBeginner = Color(0xFF66BB6A);
  static const Color difficultyIntermediate = Color(0xFFFFA726);
  static const Color difficultyAdvanced = Color(0xFFEF5350);

  // ── Misc ──
  static const Color shimmerBase = Color(0xFF2A2A3E);
  static const Color shimmerHighlight = Color(0xFF3A3A52);
  static const Color divider = Color(0xFF2E2E42);
  static const Color shadow = Color(0x40000000); // 25% black

  // ── Gradients ──
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF8C00), Color(0xFFFF6B35)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E1E2C), Color(0xFF2A2A3E)],
  );

  static const LinearGradient progressGradient = LinearGradient(
    colors: [Color(0xFFFF8C00), Color(0xFFE8B931)],
  );

  static const LinearGradient overlayGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0xCC000000)],
  );

  static Color difficultyColor(String difficulty) {
    switch (difficulty.toUpperCase()) {
      case 'BEGINNER':
        return difficultyBeginner;
      case 'INTERMEDIATE':
        return difficultyIntermediate;
      case 'ADVANCED':
        return difficultyAdvanced;
      default:
        return textMuted;
    }
  }

  // Continent accent colors
  static Color continentColor(String continent) {
    switch (continent.toUpperCase()) {
      case 'ASIA':
        return const Color(0xFFFF6B6B);
      case 'EUROPE':
        return const Color(0xFF4ECDC4);
      case 'AMERICAS' || 'NORTH AMERICA' || 'SOUTH AMERICA':
        return const Color(0xFFFFE66D);
      case 'AFRICA':
        return const Color(0xFFA06CD5);
      case 'OCEANIA':
        return const Color(0xFF45B7D1);
      default:
        return primary;
    }
  }
}
