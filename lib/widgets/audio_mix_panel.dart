import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/index.dart';

/// Individual VU meter visual slider representation
class VolumeMeterRow extends StatelessWidget {
  const VolumeMeterRow({
    required this.channelName,
    required this.dbValue,
    required this.baseThreshold,
    super.key,
  });

  final String channelName;
  final double dbValue;
  final double baseThreshold;

  @override
  Widget build(BuildContext context) {
    // Translate dB (-60 to 0) into percentage (0.0 to 1.0)
    final double percentage = ((dbValue + 60) / 60.0).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: .start,
      spacing: 6,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              channelName,
              style: GoogleFonts.jetBrainsMono(fontSize: 11, fontWeight: .w500, color: AppColors.cyberTextLight),
            ),
            Text(
              '${dbValue.toStringAsFixed(1)}dB',
              style: GoogleFonts.jetBrainsMono(fontSize: 11, fontWeight: .bold, color: AppColors.cyberCyan),
            ),
          ],
        ),

        /// Stylized bar meter with glowing active parts
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 12,
            width: .infinity,
            color: AppColors.cyberSurfaceContainerHighest,
            child: FractionallySizedBox(
              alignment: .centerLeft,
              widthFactor: percentage,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.cyberCyan, AppColors.cyberSkyBlue, AppColors.cyberAlertRed],
                    stops: [0.6, 0.85, 1],
                  ),
                  boxShadow: [
                    BoxShadow(color: AppColors.cyberCyan, blurRadius: 6, spreadRadius: 1),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Audio Mixer Panel with dynamic sliders
class AudioMixPanel extends StatelessWidget {
  const AudioMixPanel({
    required this.micDb,
    required this.bgmDb,
    required this.discordDb,
    super.key,
  });

  final double micDb;
  final double bgmDb;
  final double discordDb;

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
        crossAxisAlignment: .start,
        spacing: 16,
        children: [
          /// header
          Text('AUDIO MIX', style: AppTextTheme.barlowCondensed),

          /// List audio bar
          VolumeMeterRow(channelName: 'MIC_MAIN', dbValue: micDb, baseThreshold: -12),
          VolumeMeterRow(channelName: 'DESKTOP_BGM', dbValue: bgmDb, baseThreshold: -24),
          VolumeMeterRow(channelName: 'DISCORD_VOICE', dbValue: discordDb, baseThreshold: -18),
        ],
      ),
    );
  }
}
