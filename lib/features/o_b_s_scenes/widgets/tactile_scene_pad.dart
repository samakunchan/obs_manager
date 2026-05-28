import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';
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
    final Color borderColor = isActive ? Theme.of(context).colorScheme.secondary : AppColors.cyberHighlight;
    final Color iconColor = isActive ? Theme.of(context).colorScheme.onSurface : AppColors.cyberTextMuted;
    final Color textColor = isActive ? Theme.of(context).colorScheme.onSurface : AppColors.cyberTextLight;

    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: ChamferBorderPainter(
          color: borderColor,
          strokeWidth: isActive ? 2.0 : 1.5,
          elevation: isActive ? 8.0 : 0.0,
          mode: Theme.of(context).brightness,
          isActive: isActive,
        ),
        child: ClipPath(
          clipper: const ChamferClipper(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: const EdgeInsets.all(12),
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
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: textColor),
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
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'LIVE',
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium?.copyWith(fontSize: 8, fontWeight: .w900, color: AppColors.cyberSurface),
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
