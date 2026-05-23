import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/index.dart';

/// Live video preview monitor
class PreviewMonitor extends StatelessWidget {
  const PreviewMonitor({
    required this.activeSceneName,
    super.key,
  });

  final String activeSceneName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDefaultValues.kBorderRadiusPrimary),
      decoration: BoxDecoration(
        color: AppColors.cyberSurfaceContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppDefaultValues.kBorderRadiusSecondary),
        border: Border.all(color: const Color(0x1F4FC3F7)), // Sky blue at 10%
      ),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: .expand,
                children: [
                  Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuA6ucsNB3NiCHk4UCWVcN6_DxkrvQYtTVTXMSJZPOmu0VtsY95XDuT1wEMmBRLYbUvAo2R7JWcq9A8JLHuDKsmV9NnGRge2QDmvQ7EMrTp2GmFPFKrHRVUtkAix2ZU09KoUkj8ROzvAssfbHhqmDSw8h8QJPRiKapQKonQpww_XxoAfyvCyTsKT8SxH2qeRkP6BYdxeiecGhZMs3pmkNk8bkyu5Sqyoycggc6spUdbERyZmnkrTxD5GRw5-FHRihSFL76lYNnTeEQ8K',
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return const ColoredBox(
                        color: Colors.black,
                        child: Center(child: Icon(Icons.videocam_off, color: AppColors.cyberAlertRed, size: 48)),
                      );
                    },
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const ColoredBox(
                        color: Colors.black38,
                        child: Center(child: CircularProgressIndicator(color: AppColors.cyberCyan)),
                      );
                    },
                  ),
                  // Outer glowing frame overlay
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.cyberCyan.withValues(alpha: 0.12),
                        width: 12,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      color: Colors.black.withValues(alpha: 0.8),
                      child: Text(
                        'PREVIEW: $activeSceneName',
                        style: GoogleFonts.jetBrainsMono(fontSize: 11, fontWeight: .bold, color: AppColors.cyberCyan),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
