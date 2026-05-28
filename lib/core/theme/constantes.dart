import 'package:flutter/material.dart';

class AppDefaultValues {
  AppDefaultValues._();

  /// Value: 'monospace'
  static const String kFontFamilyTerminal = 'monospace';

  /// Value: 20
  static const double kBorderRadiusPrimary = 20;

  /// Value: 16
  static const double kBorderRadiusSecondary = 16;

  /// Value: 12
  static const double kBorderRadiusTertiary = 12;

  /// Value: 10
  static const double kBorderRadiusQuaternary = 10;

  /// Value: 8
  static const double kElevationPrimary = 8;
}

/// Centralized repository of all colors used throughout the app.
/// Hardcoded colors are prohibited in widget files.
class AppColors {
  AppColors._();

  // Core Brand / Theme Colors
  // static const Color primary = Color(0xFF6366F1);
  // static const Color accent = Color(0xFFA855F7);
  static const Color selectedChip = Color(0xFF4F46E5);

  // Cyber-Broadcaster / Stitch UI Colors
  static const Color cyberSurface = Color(0xFF051424);
  static const Color cyberSurfaceContainerLowest = Color(0xFF010F1F);
  static const Color cyberSurfaceContainerLow = Color(0xFF0E1C2D);
  static const Color cyberSurfaceContainer = Color(0xFF122031);
  static const Color cyberSurfaceContainerHigh = Color(0xFF1D2B3C);
  static const Color cyberSurfaceContainerHighest = Color(0xFF283647);
  static const Color cyberCyan = Color(0xFF00E5FF);
  static const Color cyberHighlight = Color(0x3B494C66);
  static const Color cyberSkyBlue = Color(0xFF75D1FF);
  static const Color cyberAlertRed = Color(0xFFFF1744);
  static const Color cyberTextLight = Color(0xFFD5E4FA);
  static const Color cyberTextMuted = Color(0xFF909C9F);

  // Semantic Status Colors
  static const Color successColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);

  // Text Semantic Colors
  static const Color textLight = Colors.white;
  static const Color textDark = Colors.black87;
  static const Color textHintLight = Colors.grey;
  static const Color textHintDark = Colors.black54;

  // Dark Mode Layout / Containers Colors
  static const Color darkCardBg = Color(0xFF16162A);
  static const Color darkCardBorder = Color(0xFF2C2C4E);
  static const Color darkChipBg = Color(0xFF1E1E38);
  static const Color darkChipBorder = Color(0xFF3B3B6D);
  static const Color darkTerminalBg = Color(0xFF09090F);
  static const Color darkTerminalBorder = Color(0xFF232338);
  static const Color terminalText = Color(0xFF34D399);

  // Light Mode Layout / Containers Colors (From Stitch "Tactile Command: Refined Light Mode")
  static const Color lightPrimary = Color(0xFF006875);
  static const Color lightAccent = Color(0xFF00E5FF);
  static const Color lightSecondary = Color(0xFF4F6073);
  static const Color lightError = Color(0xFFFF5252);
  static const Color lightScaffoldBg = Color(0xFFF6FAFE);
  static const Color lightCardBg = Colors.white;
  static const Color lightCardBorder = Color(0xFFEAEEF2);
  static const Color lightChipBg = Color(0xFFEAEEF2);
  static const Color lightChipBorder = Color(0xFFBAC9CC);
  static const Color lightTerminalBg = Color(0xFFF0F4F8);
  static const Color lightTerminalBorder = Color(0xFFBAC9CC);

  // Light Mode cyberSurfaceContainers
  static const Color lightCyberSurface = Color(0xFFF6FAFE);
  static const Color lightCyberSurfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color lightCyberSurfaceContainerLow = Color(0xFFF0F4F8);
  static const Color lightCyberSurfaceContainer = Color(0xFFEAEEF2);
  static const Color lightCyberSurfaceContainerHigh = Color(0xFFE4E9ED);
  static const Color lightCyberSurfaceContainerHighest = Color(0xFFDFE3E7);
}

class AppCardsTheme {
  AppCardsTheme._();

  static const double borderWidth = 1.5;
}

class AppDividersTheme {
  AppDividersTheme._();

  static const double space = 20;
  static const double thickness = 1;
}

class AppChipsTheme {
  AppChipsTheme._();

  static const double borderWidth = 1;
}
