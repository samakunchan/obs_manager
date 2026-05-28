import 'package:flutter/material.dart';
import 'package:obs_manager/core/theme/constantes.dart';

/// Centralized application theme provider defining Light and Dark themes.
class AppTheme {
  AppTheme._();

  /// Dark Theme setup matching the premium indigo/purple aesthetic.
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: .dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.cyberCyan,
        secondary: AppColors.cyberSkyBlue,
        tertiary: AppColors.textLight,
        surface: AppColors.darkCardBg,
        surfaceContainerLowest: AppColors.cyberSurfaceContainerLowest,
        surfaceContainerLow: AppColors.cyberSurfaceContainerLow,
        surfaceContainer: AppColors.cyberSurfaceContainer,
        surfaceContainerHigh: AppColors.cyberSurfaceContainerHigh,
        surfaceContainerHighest: AppColors.cyberSurfaceContainerHighest,
        onSurface: AppColors.cyberSkyBlue,
        error: AppColors.cyberAlertRed,
      ),
      scaffoldBackgroundColor: AppColors.cyberSurface,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cyberSurface,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.darkCardBg,
        elevation: AppDefaultValues.kElevationPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppDefaultValues.kBorderRadiusSecondary)),
          side: BorderSide(color: AppColors.darkCardBorder, width: AppCardsTheme.borderWidth),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkCardBorder,
        space: AppDividersTheme.space,
        thickness: AppDividersTheme.thickness,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkChipBg,
        selectedColor: AppColors.selectedChip,
        secondarySelectedColor: AppColors.selectedChip,
        disabledColor: AppColors.darkChipBg.withAlpha(128),
        labelStyle: const TextStyle(
          color: AppColors.textHintLight,
          fontWeight: .normal,
        ),
        secondaryLabelStyle: const TextStyle(
          color: AppColors.textLight,
          fontWeight: .bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDefaultValues.kBorderRadiusPrimary),
          side: const BorderSide(color: AppColors.darkChipBorder),
        ),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontSize: 24, fontWeight: .bold, letterSpacing: 0.5, color: AppColors.textLight),
        titleMedium: TextStyle(fontSize: 15, fontWeight: .bold, color: AppColors.textLight),
        titleSmall: TextStyle(fontFamily: 'Inter', fontSize: 13, color: Colors.white),
        bodyLarge: TextStyle(
          fontFamily: 'BarlowCondensed',
          fontSize: 20,
          fontWeight: .bold,
          letterSpacing: 1,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(fontFamily: 'JetBrainsMono', fontSize: 12.5, color: Colors.white, fontWeight: .w500),
        bodySmall: TextStyle(fontFamily: 'JetBrainsMono', fontSize: 11, color: Colors.black),
        labelMedium: TextStyle(fontFamily: 'JetBrainsMono', fontSize: 11, fontWeight: .w500, color: AppColors.textHintLight),
        labelSmall: kDefaultTextStyle,
      ),
      // primary button
      elevatedButtonTheme: ElevatedButtonThemeData(style: kButtonStylePrimary),
      // primary icon button
      iconButtonTheme: IconButtonThemeData(
        style: kButtonStylePrimary.copyWith(padding: const WidgetStatePropertyAll(.zero)),
      ),
      // secondary button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: kButtonStyleSecondary.copyWith(backgroundColor: const WidgetStatePropertyAll(Colors.transparent)),
      ),
      iconTheme: kIconTheme,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.cyberSkyBlue.withValues(alpha: 0.8),
        foregroundColor: AppColors.cyberSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppDefaultValues.kBorderRadiusQuaternary)),
        ),
      ),
    );
  }

  /// Light Theme setup designed to follow proper semantic equivalents.
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: .light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.lightPrimary,
        secondary: AppColors.cyberSkyBlue,
        tertiary: AppColors.textDark,
        error: AppColors.lightError,
        surfaceContainerLowest: AppColors.lightCyberSurfaceContainerLowest,
        surfaceContainerLow: AppColors.lightCyberSurfaceContainerLow,
        surfaceContainer: AppColors.lightCyberSurfaceContainer,
        surfaceContainerHigh: AppColors.lightCyberSurfaceContainerHigh,
        surfaceContainerHighest: AppColors.lightCyberSurfaceContainerHighest,
        onSurface: AppColors.cyberSurface,
      ),
      scaffoldBackgroundColor: AppColors.lightScaffoldBg,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightScaffoldBg,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.lightCardBg,
        elevation: AppDefaultValues.kElevationPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppDefaultValues.kBorderRadiusSecondary)),
          side: BorderSide(color: AppColors.lightCardBorder, width: AppCardsTheme.borderWidth),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightCardBorder,
        space: AppDividersTheme.space,
        thickness: AppDividersTheme.thickness,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightChipBg,
        selectedColor: AppColors.lightPrimary,
        secondarySelectedColor: AppColors.lightPrimary,
        disabledColor: AppColors.lightChipBg.withAlpha(128),
        labelStyle: const TextStyle(color: AppColors.textHintDark, fontWeight: .normal),
        secondaryLabelStyle: const TextStyle(color: AppColors.textLight, fontWeight: .bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDefaultValues.kBorderRadiusPrimary),
          side: const BorderSide(color: AppColors.lightChipBorder),
        ),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontSize: 24, fontWeight: .bold, letterSpacing: 0.5, color: AppColors.textDark),
        titleMedium: TextStyle(fontSize: 15, fontWeight: .bold, color: AppColors.textDark),
        titleSmall: TextStyle(fontFamily: 'Inter', fontSize: 13, color: AppColors.textDark),
        bodyLarge: TextStyle(
          fontFamily: 'BarlowCondensed',
          fontSize: 20,
          fontWeight: .bold,
          letterSpacing: 1,
          color: AppColors.textDark,
        ),
        bodyMedium: TextStyle(fontFamily: 'JetBrainsMono', fontSize: 12.5, fontWeight: .w500, color: AppColors.textDark),
        bodySmall: TextStyle(fontFamily: 'JetBrainsMono', fontSize: 11, color: Colors.black),
        labelMedium: TextStyle(fontFamily: 'JetBrainsMono', fontSize: 11, fontWeight: .bold, color: AppColors.textHintDark),
        labelSmall: kDefaultTextStyle,
      ),
      // primary button
      elevatedButtonTheme: ElevatedButtonThemeData(style: kButtonStylePrimary),
      // primary icon button
      iconButtonTheme: IconButtonThemeData(
        style: kButtonStylePrimary.copyWith(padding: const WidgetStatePropertyAll(.zero)),
      ),
      // secondary button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: kButtonStyleSecondary.copyWith(
          backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
          overlayColor: kDefaultOverlayColor,
          shadowColor: kDefaultOverlayColor,
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.lightPrimary, size: 24),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.cyberSkyBlue,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppDefaultValues.kBorderRadiusQuaternary)),
        ),
      ),
    );
  }
}

WidgetStateProperty<Color?>? kDefaultOverlayColor = WidgetStateColor.resolveWith((Set<WidgetState> states) {
  if (states.contains(WidgetState.hovered)) {
    return AppColors.textHintLight;
  }
  return AppColors.cyberHighlight;
});

WidgetStateProperty<Color?>? kAlertOverlayColor = WidgetStateColor.resolveWith((Set<WidgetState> states) {
  if (states.contains(WidgetState.hovered)) {
    return AppColors.cyberAlertRed;
  }
  return AppColors.cyberAlertRed;
});

WidgetStateProperty<TextStyle?>? kAlertTextStyle = WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
  if (states.contains(WidgetState.hovered)) {
    return const TextStyle(fontFamily: 'JetBrainsMono', fontSize: 11, color: AppColors.textLight);
  }
  return const TextStyle(fontFamily: 'JetBrainsMono', fontSize: 11, color: AppColors.cyberAlertRed);
});

ButtonStyle kButtonStylePrimary = ElevatedButton.styleFrom(
  backgroundColor: AppColors.cyberSkyBlue,
  foregroundColor: Colors.black,
  iconColor: Colors.black,
  shadowColor: AppColors.cyberSkyBlue,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppDefaultValues.kBorderRadiusQuaternary)),
  ),
  elevation: 8,
  padding: const EdgeInsets.symmetric(vertical: 12),
);

ButtonStyle kButtonStyleSecondary = ElevatedButton.styleFrom(
  backgroundColor: AppColors.cyberSkyBlue,
  foregroundColor: Colors.black,
  iconColor: Colors.black,
  // shadowColor: AppColors.cyberCyan,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppDefaultValues.kBorderRadiusQuaternary)),
  ),
  elevation: 0,
  padding: const EdgeInsets.symmetric(vertical: 12),
);

const IconThemeData kIconTheme = IconThemeData(
  color: AppColors.cyberCyan,
  size: 24,
);

const TextStyle kDefaultTextStyle = TextStyle(
  fontFamily: AppDefaultValues.kFontFamilyTerminal,
  fontSize: 10,
  color: AppColors.textHintDark,
);

const TextStyle kTerminalTextStyle = TextStyle(
  fontFamily: AppDefaultValues.kFontFamilyTerminal,
  fontSize: 11,
  color: AppColors.terminalText,
);
