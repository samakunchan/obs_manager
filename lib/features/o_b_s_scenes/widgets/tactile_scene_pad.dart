import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/core/utils/utils.dart';
import 'package:obs_manager/features/o_b_s_scenes/o_b_s_scenes.dart';

/// Custom 45° Clipped Tactile Button Pad
class TactileScenePad extends StatelessWidget {
  const TactileScenePad({
    required this.name,
    required this.icon,
    required this.isActive,
    required this.onTap,
    super.key,
  });

  final String name;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color borderColor = isActive ? AppColors.cyberCyan : AppColors.cyberHighlight;
    final Color iconColor = isActive ? AppColors.cyberCyan : AppColors.cyberTextMuted;
    final Color textColor = isActive ? AppColors.cyberCyan : AppColors.cyberTextLight;

    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: ChamferBorderPainter(color: borderColor, strokeWidth: isActive ? 2.0 : 1.5),
        child: ClipPath(
          clipper: const ChamferClipper(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppUtils.highlightColor(isActive: isActive),
            ),
            child: Stack(
              children: [
                Align(
                  child: Column(
                    mainAxisAlignment: .center,
                    spacing: 8,
                    children: [
                      Icon(icon, size: 32, color: iconColor),
                      Text(
                        name,
                        maxLines: 2,
                        overflow: .ellipsis,
                        style: GoogleFonts.jetBrainsMono(fontSize: 11, fontWeight: .w500, color: textColor),
                      ),
                    ],
                  ),
                ),
                if (isActive)
                  Positioned(
                    top: 2,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.cyberCyan,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'LIVE',
                        style: GoogleFonts.jetBrainsMono(fontSize: 8, fontWeight: .w900, color: AppColors.cyberSurface),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
