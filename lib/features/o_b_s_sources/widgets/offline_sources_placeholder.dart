import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';

/// A custom cyber-aesthetic placeholder widget displayed when OBS is disconnected
class OfflineSourcesPlaceholder extends StatelessWidget {
  const OfflineSourcesPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppDefaultValues.kBorderRadiusQuaternary),
        border: Border.all(
          color: AppColors.cyberHighlight,
        ),
      ),
      child: Column(
        mainAxisAlignment: .center,
        spacing: 12,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.cyberHighlight.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.sensors_off_rounded,
              color: AppColors.cyberTextMuted,
              size: 24,
            ),
          ),
          Text(
            context.localization.sourcesOffline.toUpperCase(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
               fontSize: 14,
               letterSpacing: 1.2,
               color: AppColors.cyberTextMuted,
             ),
           ),
           const SizedBox(height: 12),
           Text(
            context.localization.connectObsToLoadInputs,
             textAlign: TextAlign.center,
             style: Theme.of(context).textTheme.titleSmall?.copyWith(
               fontSize: 11,
               height: 1.3,
               color: AppColors.cyberTextMuted.withValues(alpha: 0.7),
             ),
           ),
        ],
      ),
    );
  }
}
