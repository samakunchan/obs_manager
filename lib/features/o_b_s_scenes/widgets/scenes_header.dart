import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';

/// Clean header display for the Scene selector area
class ScenesHeader extends StatelessWidget {
  const ScenesHeader({
    required this.presetsCount,
    super.key,
  });

  final int presetsCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Expanded(child: Text(context.localization.scenes.toUpperCase(), style: Theme.of(context).textTheme.bodyLarge)),
        Expanded(
          flex: 2,
          child: Text(
            context.localization.presetsLoaded(presetsCount),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontSize: 11,
              fontWeight: .w500,
              color: AppColors.cyberTextMuted,
            ),
            overflow: .ellipsis,
            textAlign: .end,
          ),
        ),
      ],
    );
  }
}
