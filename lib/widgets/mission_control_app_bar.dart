import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/pages/my_home_page.dart';

/// Top app header featuring high-tech statuses
class MissionControlAppBar extends StatelessWidget {
  const MissionControlAppBar({
    required this.isStreaming,
    required this.pulseAnimation,
    required this.onDrawerPressed,
    super.key,
  });

  final bool isStreaming;
  final Animation<double> pulseAnimation;
  final VoidCallback onDrawerPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: AppDefaultValues.kBorderRadiusPrimary),
      decoration: BoxDecoration(
        color: AppColors.cyberSurfaceContainer.withValues(alpha: 0.6),
        border: const Border(bottom: BorderSide(color: Color(0x1F3B494C))),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: .spaceBetween,
          spacing: 12,
          children: [
            Row(
              spacing: 12,
              children: [
                IconButton(
                  onPressed: onDrawerPressed,
                  icon: const Icon(Icons.settings_input_component, color: AppColors.cyberCyan),
                  tooltip: 'Open Station Drawer',
                ),
                Text(
                  'MISSION CONTROL',
                  style: GoogleFonts.barlowCondensed(
                    fontSize: 20,
                    fontWeight: .bold,
                    letterSpacing: 1.5,
                    color: AppColors.cyberCyan,
                  ),
                ),
              ],
            ),
            Row(
              spacing: 16,
              children: [
                // REC Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0x1AFF1744), // cyberAlertRed 10%
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.cyberAlertRed.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: .min,
                    spacing: 6,
                    children: [
                      AnimatedBuilder(
                        animation: pulseAnimation,
                        builder: (BuildContext context, Widget? child) {
                          return Opacity(
                            opacity: pulseAnimation.value,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.cyberAlertRed),
                            ),
                          );
                        },
                      ),
                      Text(
                        isStreaming ? 'REC: 00:04:12' : 'REC: STANDBY',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.cyberAlertRed,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Switch directly to the Localization Showcase Page
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const MyHomePage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.swap_horizontal_circle_outlined),
                  color: AppColors.cyberTextMuted,
                  tooltip: 'Switch to Localization Showcase',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
