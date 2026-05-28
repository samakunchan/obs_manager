import 'package:flutter/material.dart';
import 'package:obs_manager/core/theme/constantes.dart';

class AppUtils {
  @Deprecated('Plus besoin')
  static Color highlightColor({required BuildContext context, required bool isActive}) {
    return !isActive
        ? AppColors
              .cyberHighlight // Cyber Cyan background highlight
        : Theme.of(context).colorScheme.secondary;
  }
}
