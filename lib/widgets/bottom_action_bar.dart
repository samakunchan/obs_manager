import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/index.dart';

/// Individual navigation button in the bottom action bar
class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    required this.icon,
    required this.label,
    required this.isActive,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.cyberCyan : AppColors.cyberTextMuted;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
            children: [
              Icon(icon, size: 20, color: color),
              Text(
                label,
                style: GoogleFonts.jetBrainsMono(fontSize: 9, fontWeight: .bold, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Bottom action bar controls (CTA & horizontal navigation)
class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    required this.isStreaming,
    required this.onToggleStream,
    super.key,
  });

  final bool isStreaming;
  final VoidCallback onToggleStream;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.cyberSurfaceContainerLow.withValues(alpha: 0.8),
        border: const Border(top: BorderSide(color: Color(0x3B00E5FF))),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: .spaceAround,
          children: [
            const BottomNavButton(icon: Icons.grid_view, label: 'SCENES', isActive: true),
            const BottomNavButton(icon: Icons.equalizer, label: 'AUDIO', isActive: false),
            const BottomNavButton(icon: Icons.podcasts, label: 'MONITORING', isActive: false),
            // const BottomNavButton(icon: Icons.layers, label: 'SOURCES', isActive: false),

            /// Central broadcast CTA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isStreaming ? AppColors.cyberAlertRed : AppColors.cyberSkyBlue.withValues(alpha: 0.8),
                  foregroundColor: Colors.black,
                  shadowColor: isStreaming ? AppColors.cyberAlertRed : AppColors.cyberCyan,
                  elevation: 8,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDefaultValues.kBorderRadiusTertiary)),
                ),
                onPressed: onToggleStream,
                icon: const Icon(Icons.rocket_launch, size: 20),
                label: Text(
                  isStreaming ? 'STOP STREAM' : 'START STREAM',
                  style: GoogleFonts.barlowCondensed(fontSize: 16, fontWeight: .bold, letterSpacing: 1.2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
