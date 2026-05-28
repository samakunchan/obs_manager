import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';

InputDecoration buildInputDecoration({
  required BuildContext context,
  required String label,
  required String hint,
  required IconData prefixIcon,
  Widget? suffixIcon,
}) {
  final textTheme = Theme.of(context).textTheme;
  return InputDecoration(
    labelText: label,
    hintText: hint,
    prefixIcon: Icon(prefixIcon, color: AppColors.cyberTextMuted, size: 18),
    suffixIcon: suffixIcon,
    labelStyle: textTheme.bodySmall?.copyWith(color: AppColors.cyberTextMuted, fontSize: 10, fontWeight: .bold),
    hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.cyberTextMuted.withValues(alpha: 0.5), fontSize: 12),
    floatingLabelStyle: textTheme.bodySmall?.copyWith(color: AppColors.cyberCyan, fontSize: 11, fontWeight: .bold),
    filled: true,
    fillColor: Theme.of(context).colorScheme.surfaceContainerLowest,
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
    errorStyle: textTheme.bodySmall?.copyWith(color: AppColors.cyberAlertRed, fontSize: 10, fontWeight: .bold),
  );
}
