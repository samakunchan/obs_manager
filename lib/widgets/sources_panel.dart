import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/index.dart';

/// List element inside sources
class SourceRow extends StatelessWidget {
  const SourceRow({
    required this.icon,
    required this.label,
    required this.isVisible,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cyberSurfaceContainerHigh.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0x0C3B494C),
        ),
      ),
      child: Opacity(
        opacity: isVisible ? 1.0 : 0.45,
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Row(
              spacing: 12,
              children: [
                Icon(icon, size: 18, color: AppColors.cyberCyan),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: .w500,
                    color: AppColors.cyberTextLight,
                  ),
                ),
              ],
            ),
            Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              size: 16,
              color: AppColors.cyberTextMuted,
            ),
          ],
        ),
      ),
    );
  }
}

/// Active video and image input sources panel
class SourcesPanel extends StatelessWidget {
  const SourcesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDefaultValues.kBorderRadiusPrimary),
      decoration: BoxDecoration(
        color: AppColors.cyberSurfaceContainer.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(AppDefaultValues.kBorderRadiusSecondary),
        border: Border.all(color: const Color(0x1F4FC3F7)),
      ),
      child: Column(
        spacing: 12,
        crossAxisAlignment: .stretch,
        children: [
          /// Header
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text('SOURCES', style: AppTextTheme.barlowCondensed),
              // const Icon(Icons.add_circle, color: AppColors.cyberTextMuted, size: 20),
            ],
          ),

          /// Sources list
          const Column(
            spacing: 10,
            crossAxisAlignment: .stretch,
            children: [
              SourceRow(icon: Icons.videocam, label: 'Sony Alpha A7III', isVisible: true),
              SourceRow(icon: Icons.image, label: 'Overlay_Top_Left', isVisible: true),
              SourceRow(icon: Icons.subtitles, label: 'Live Captions', isVisible: false),
            ],
          ),
        ],
      ),
    );
  }
}
