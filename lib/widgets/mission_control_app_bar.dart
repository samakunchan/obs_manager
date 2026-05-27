import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/widgets/rec_status_badge.dart';

class MissionControlAppBar extends StatelessWidget {
  const MissionControlAppBar({
    required this.isStreaming,
    required this.pulseAnimation,
    super.key,
  });

  final bool isStreaming;
  final Animation<double> pulseAnimation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: AppDefaultValues.kBorderRadiusPrimary),
          decoration: BoxDecoration(
            color: AppColors.cyberSurfaceContainer.withValues(alpha: 0.6),
            border: const Border(bottom: BorderSide(color: Color(0x1F3B494C))),
          ),
          child: Row(
            spacing: 12,
            children: [
              Expanded(
                child: Text(
                  context.localization.panelControl.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 20,
                    letterSpacing: 1.5,
                    color: AppColors.cyberCyan,
                  ),
                  textAlign: .center,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: RecStatusBadge(isStreaming: isStreaming, pulseAnimation: pulseAnimation),
        ),
      ],
    );
  }
}
