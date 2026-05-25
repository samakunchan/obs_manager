import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/index.dart';

InputDecoration buildInputDecoration({
  required String label,
  required String hint,
  required IconData prefixIcon,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    prefixIcon: Icon(prefixIcon, color: AppColors.cyberTextMuted, size: 18),
    suffixIcon: suffixIcon,
    labelStyle: GoogleFonts.jetBrainsMono(color: AppColors.cyberTextMuted, fontSize: 10, fontWeight: FontWeight.bold),
    hintStyle: GoogleFonts.jetBrainsMono(color: AppColors.cyberTextMuted.withValues(alpha: 0.5), fontSize: 12),
    floatingLabelStyle: GoogleFonts.jetBrainsMono(color: AppColors.cyberCyan, fontSize: 11, fontWeight: FontWeight.bold),
    filled: true,
    fillColor: AppColors.cyberSurfaceContainerLowest,
    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.cyberTextMuted.withValues(alpha: 0.2)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.cyberCyan, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.cyberAlertRed),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.cyberAlertRed, width: 1.5),
    ),
    errorStyle: GoogleFonts.jetBrainsMono(color: AppColors.cyberAlertRed, fontSize: 10, fontWeight: FontWeight.bold),
  );
}
