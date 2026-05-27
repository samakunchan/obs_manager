import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';

/// Individual navigation button in the bottom action bar
class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    required this.icon,
    required this.label,
    required this.isActive,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.cyberCyan : AppColors.cyberTextMuted;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
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
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 9, fontWeight: .bold, color: color),
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
    required this.streamStatus,
    required this.onToggleStream,
    required this.isAudioActive,
    required this.onAudioTap,
    required this.isMonitoringActive,
    required this.onMonitoringTap,
    required this.isScenesActive,
    required this.onScenesTap,
    super.key,
  });

  final StatusStream streamStatus;
  final VoidCallback onToggleStream;
  final bool isAudioActive;
  final VoidCallback onAudioTap;
  final bool isMonitoringActive;
  final VoidCallback onMonitoringTap;
  final bool isScenesActive;
  final VoidCallback onScenesTap;

  @override
  Widget build(BuildContext context) {
    final String streamStatusMessage = switch (streamStatus) {
      StatusStream.isStarting => context.localization.isStarting.toUpperCase(),
      StatusStream.isStopping => context.localization.isStopping.toUpperCase(),
      StatusStream.started => context.localization.stopStream.toUpperCase(),
      StatusStream.stopped => context.localization.startStream.toUpperCase(),
    };

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.cyberSurfaceContainerLow.withValues(alpha: 0.8),
        border: const Border(top: BorderSide(color: Color(0x3B00E5FF))),
      ),
      child: Row(
        mainAxisAlignment: .spaceAround,
        children: [
          BottomNavButton(
            icon: Icons.grid_view,
            label: context.localization.scenes.toUpperCase(),
            isActive: isScenesActive,
            onTap: onScenesTap,
          ),
          BottomNavButton(
            icon: Icons.equalizer,
            label: context.localization.audio.toUpperCase(),
            isActive: isAudioActive,
            onTap: onAudioTap,
          ),
          BottomNavButton(
            icon: Icons.podcasts,
            label: context.localization.monitoring.toUpperCase(),
            isActive: isMonitoringActive,
            onTap: onMonitoringTap,
          ),

          /// Central broadcast CTA
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: streamStatus == StatusStream.started || streamStatus == StatusStream.isStopping
                      ? AppColors.cyberAlertRed
                      : AppColors.cyberSkyBlue.withValues(alpha: 0.8),
                  foregroundColor: Colors.black,
                  shadowColor: streamStatus == StatusStream.started || streamStatus == StatusStream.isStopping
                      ? AppColors.cyberAlertRed
                      : AppColors.cyberCyan,
                  elevation: 8,
                ),
                onPressed: onToggleStream,
                icon: const Icon(Icons.rocket_launch, size: 20),
                label: Text(
                  streamStatusMessage,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.cyberSurface),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
