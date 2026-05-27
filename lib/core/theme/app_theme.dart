import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/theme/constantes.dart';

/// Centralized application theme provider defining Light and Dark themes.
class AppTheme {
  AppTheme._();

  /// Dark Theme setup matching the premium indigo/purple aesthetic.
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: .dark,
      colorScheme: const ColorScheme.dark(primary: AppColors.primary, secondary: AppColors.accent, surface: AppColors.darkCardBg),
      scaffoldBackgroundColor: AppColors.darkScaffoldBg,
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
      textTheme: TextTheme(
        headlineMedium: const TextStyle(
          fontSize: 24,
          fontWeight: .bold,
          letterSpacing: 0.5,
          color: AppColors.textLight,
        ),
        titleMedium: const TextStyle(
          fontSize: 15,
          fontWeight: .bold,
          color: AppColors.textLight,
        ),
        bodyMedium: GoogleFonts.jetBrainsMono(color: Colors.white, fontWeight: .bold),
        bodySmall: GoogleFonts.jetBrainsMono(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.textHintLight,
          letterSpacing: 1,
        ),
        labelMedium: GoogleFonts.jetBrainsMono(fontSize: 11, fontWeight: .w500, color: AppColors.textHintLight),
        labelSmall: kDefaultlTextStyle,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: kElevatedButtonDarkPrimary),
      iconButtonTheme: IconButtonThemeData(style: kIconButtonDarkPrimary),
      outlinedButtonTheme: OutlinedButtonThemeData(style: kOutlinedButtonDarkPrimary),
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
        primary: AppColors.primary,
        secondary: AppColors.accent,
      ),
      scaffoldBackgroundColor: AppColors.lightScaffoldBg,
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
        selectedColor: AppColors.selectedChip,
        secondarySelectedColor: AppColors.selectedChip,
        disabledColor: AppColors.lightChipBg.withAlpha(128),
        labelStyle: const TextStyle(color: AppColors.textHintDark, fontWeight: .normal),
        secondaryLabelStyle: const TextStyle(color: AppColors.textLight, fontWeight: .bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDefaultValues.kBorderRadiusPrimary),
          side: const BorderSide(color: AppColors.lightChipBorder),
        ),
      ),
      textTheme: TextTheme(
        headlineMedium: const TextStyle(fontSize: 24, fontWeight: .bold, letterSpacing: 0.5, color: AppColors.textDark),
        titleMedium: const TextStyle(fontSize: 15, fontWeight: .bold, color: AppColors.textDark),
        bodyLarge: GoogleFonts.barlowCondensed(fontSize: 20, fontWeight: .bold, letterSpacing: 1, color: Colors.white),
        bodyMedium: const TextStyle(fontSize: 12.5, fontWeight: .w500, color: AppColors.textDark),
        bodySmall: const TextStyle(fontSize: 12, color: AppColors.textHintDark),
        labelMedium: const TextStyle(fontSize: 11, fontWeight: .bold, color: AppColors.textHintDark, letterSpacing: 1),
        labelSmall: kDefaultlTextStyle,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: kElevatedButtonDarkPrimary),
      iconButtonTheme: IconButtonThemeData(style: kIconButtonDarkPrimary),
      outlinedButtonTheme: OutlinedButtonThemeData(style: kOutlinedButtonDarkPrimary),
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
}

ButtonStyle kOutlinedButtonDarkPrimary = OutlinedButton.styleFrom(
  side: const BorderSide(color: AppColors.textHintLight),
  padding: const EdgeInsets.symmetric(vertical: 12),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppDefaultValues.kBorderRadiusQuaternary)),
  ),
);

ButtonStyle kIconButtonDarkPrimary = ElevatedButton.styleFrom(
  backgroundColor: AppColors.cyberSkyBlue.withValues(alpha: 0.8),
  foregroundColor: AppColors.cyberSurface,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppDefaultValues.kBorderRadiusQuaternary)),
  ),
);

ButtonStyle kElevatedButtonDarkPrimary = ElevatedButton.styleFrom(
  backgroundColor: AppColors.cyberSkyBlue.withValues(alpha: 0.8),
  foregroundColor: AppColors.cyberSurface,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppDefaultValues.kBorderRadiusQuaternary)),
  ),
  elevation: 0,
  padding: const EdgeInsets.symmetric(vertical: 12),
);

ButtonStyle kElevatedButtonDarkSuccess = ElevatedButton.styleFrom(
  backgroundColor: AppColors.successColor,
  foregroundColor: AppColors.textLight,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppDefaultValues.kBorderRadiusQuaternary)),
  ),
);

const IconThemeData kIconTheme = IconThemeData(
  color: AppColors.primary,
  size: 24,
);

const TextStyle kDefaultlTextStyle = TextStyle(
  fontFamily: AppDefaultValues.kFontFamilyTerminal,
  fontSize: 10,
  color: AppColors.textHintDark,
);

const TextStyle kTerminalTextStyle = TextStyle(
  fontFamily: AppDefaultValues.kFontFamilyTerminal,
  fontSize: 11,
  color: AppColors.terminalText,
);
