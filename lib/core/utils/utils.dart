import 'dart:ui';

import 'package:obs_manager/core/theme/constantes.dart';

class AppUtils {
  static Color highlightColor({required bool isActive}) {
    return isActive
        ? AppColors
              .cyberHighlight // Cyber Cyan background highlight
        : AppColors.cyberSurfaceContainerLow;
  }
}
