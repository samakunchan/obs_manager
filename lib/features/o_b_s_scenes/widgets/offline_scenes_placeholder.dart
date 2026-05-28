import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';

/// A custom cyber-aesthetic placeholder widget displayed when OBS is disconnected
class OfflineScenesPlaceholder extends StatelessWidget {
  const OfflineScenesPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppDefaultValues.kBorderRadiusSecondary),
        border: Border.all(
          color: Theme.of(context).colorScheme.error.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: .center,
        spacing: 16,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.error.withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
            child: Icon(
              Icons.wifi_off_rounded,
              color: Theme.of(context).colorScheme.error,
              size: 40,
            ),
          ),
          Text(
            context.localization.obsDisconnected.toUpperCase(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 22,
              letterSpacing: 1.5,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          Text(
            context.localization.sceneCommandCenterOffline,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              height: 1.4,
              color: AppColors.cyberTextMuted,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.settings_ethernet, size: 16),
            label: Text(
              context.localization.openControlConsole.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
