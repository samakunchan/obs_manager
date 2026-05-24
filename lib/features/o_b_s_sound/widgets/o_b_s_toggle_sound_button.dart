import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_server/o_b_s_server.dart';
import 'package:obs_manager/features/o_b_s_sound/services/services.dart';
import 'package:signals_flutter/signals_flutter.dart';

class OBSToggleSoundButton extends StatelessWidget {
  const OBSToggleSoundButton({super.key});

  @override
  Widget build(BuildContext context) {
    final soundService = getIt<OBSSoundService>();

    return Watch((_) {
      final isMuted = soundService.isSoundMuted.value;

      return Tooltip(
        message: isMuted ? 'Unmute microphone' : 'Mute microphone',
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              try {
                await soundService.toggleMuteSound();
              } catch (_) {}
            },
            borderRadius: BorderRadius.circular(8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isMuted ? AppColors.cyberAlertRed.withValues(alpha: 0.1) : AppColors.cyberCyan.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isMuted ? AppColors.cyberAlertRed : AppColors.cyberCyan,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isMuted ? AppColors.cyberAlertRed.withValues(alpha: 0.2) : AppColors.cyberCyan.withValues(alpha: 0.2),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Icon(
                  isMuted ? Icons.mic_off_rounded : Icons.mic_rounded,
                  key: ValueKey<bool>(isMuted),
                  color: isMuted ? AppColors.cyberAlertRed : AppColors.cyberCyan,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
