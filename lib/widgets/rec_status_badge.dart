import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_server/o_b_s_server.dart';

class RecStatusBadge extends StatelessWidget {
  const RecStatusBadge({required this.isStreaming, required this.pulseAnimation, super.key});
  final bool isStreaming;
  final Animation<double> pulseAnimation;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        /// REC Status Badge
        if (getIt<OBSService>().isConnected.value)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isStreaming
                  ? AppColors.successColor.withValues(alpha: 0.3)
                  : Theme.of(context).colorScheme.error.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isStreaming
                    ? AppColors.successColor.withValues(alpha: 0.3)
                    : Theme.of(context).colorScheme.error.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: .min,
              spacing: 6,
              children: [
                AnimatedBuilder(
                  animation: pulseAnimation,
                  builder: (BuildContext context, Widget? child) {
                    return Opacity(
                      opacity: pulseAnimation.value,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: .circle,
                          color: isStreaming ? AppColors.successColor : Theme.of(context).colorScheme.error,
                        ),
                      ),
                    );
                  },
                ),
                Text(
                  isStreaming ? context.localization.onAir.toUpperCase() : context.localization.recStandby.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    fontWeight: .bold,
                    color: isStreaming ? AppColors.successColor : Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
