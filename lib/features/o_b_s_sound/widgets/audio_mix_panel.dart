import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_server/o_b_s_server.dart';
import 'package:obs_manager/features/o_b_s_sound/o_b_s_sound.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// Audio Mixer/Mic Control Panel
class AudioMixPanel extends StatelessWidget {
  const AudioMixPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final soundService = getIt<OBSSoundService>();
    final obsService = getIt<OBSService>();

    return Watch((_) {
      final isMuted = soundService.isSoundMuted.value;
      final isConnected = obsService.isConnected.value;
      final micName = soundService.inputName.value;

      return Container(
        padding: const EdgeInsets.all(AppDefaultValues.kBorderRadiusPrimary),
        decoration: BoxDecoration(
          color: AppColors.cyberSurfaceContainer.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(AppDefaultValues.kBorderRadiusSecondary),
          border: Border.all(color: const Color(0x1F4FC3F7)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            /// header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('AUDIO CONTROL', style: AppTextTheme.barlowCondensed),
                if (isConnected)
                  const OBSToggleSoundButton()
                else
                  const Icon(Icons.mic_off_rounded, color: AppColors.cyberTextMuted, size: 20),
              ],
            ),

            /// Simple, premium status representation
            Row(
              spacing: 12,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isConnected
                        ? (isMuted
                              ? AppColors.cyberAlertRed.withValues(alpha: 0.1)
                              : AppColors.successColor.withValues(alpha: 0.1))
                        : AppColors.cyberSurfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isConnected ? (isMuted ? Icons.mic_off_rounded : Icons.mic_rounded) : Icons.link_off_rounded,
                    color: isConnected ? (isMuted ? AppColors.cyberAlertRed : AppColors.successColor) : AppColors.cyberTextMuted,
                    size: 16,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text(
                        isConnected ? micName : 'DISCONNECTED',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isConnected ? AppColors.cyberTextLight : AppColors.cyberTextMuted,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        isConnected
                            ? (isMuted ? 'Microphone is currently muted' : 'Microphone is live and active')
                            : 'Connect to OBS to enable mic control',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
