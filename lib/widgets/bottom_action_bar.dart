import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/widgets/widgets.dart';

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
    final Color color = isActive ? Theme.of(context).colorScheme.secondary : AppColors.cyberTextMuted;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: .min,
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

    final double width = MediaQuery.of(context).size.width;
    final bool isDesktop = width > 800;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow.withValues(alpha: 0.8),
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

          if (isDesktop) const Spacer(flex: 2),

          /// Central broadcast CTA
          if (isDesktop)
            CTACentralBroadcastDesktop(
              streamStatusMessage: streamStatusMessage,
              onToggleStream: onToggleStream,
              streamStatus: streamStatus,
            )
          else
            CTACentralBroadcastMobile(
              streamStatusMessage: streamStatusMessage,
              onToggleStream: onToggleStream,
              streamStatus: streamStatus,
            ),
        ],
      ),
    );
  }
}
