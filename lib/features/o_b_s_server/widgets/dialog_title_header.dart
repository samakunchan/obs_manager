import 'package:flutter/material.dart';
import 'package:obs_manager/core/theme/constantes.dart';

class DialogTitleHeader extends StatelessWidget {
  const DialogTitleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.cyberCyan.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.cyberCyan),
          ),
          child: const Icon(Icons.settings_input_component, color: AppColors.cyberCyan, size: 20),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: 2,
            children: [
              Text(
                'CONNECTION_CONSOLE',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                  color: AppColors.cyberCyan,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                'OBS WEBSOCKET V5 CONFIGURATION',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 9,
                  fontWeight: .bold,
                  color: AppColors.cyberTextMuted,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: AppColors.cyberTextMuted, size: 20),
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
