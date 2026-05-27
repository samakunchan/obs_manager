import 'package:flutter/material.dart';
import 'package:obs_manager/core/theme/constantes.dart';

class LabelInfoStatusConnection extends StatelessWidget {
  const LabelInfoStatusConnection({required this.isConnected, required this.status, super.key});
  final bool isConnected;
  final String status;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(
          'OBS CONNECTION:',
          style: textTheme.bodySmall?.copyWith(
            fontSize: 10,
            fontWeight: .bold,
            color: AppColors.cyberTextLight,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          decoration: BoxDecoration(
            color: isConnected ? AppColors.successColor.withValues(alpha: 0.15) : AppColors.cyberAlertRed.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isConnected ? AppColors.successColor : AppColors.cyberAlertRed,
            ),
          ),
          child: Text(
            status.toUpperCase(),
            style: textTheme.bodySmall?.copyWith(
              fontSize: 9,
              fontWeight: .bold,
              color: isConnected ? AppColors.successColor : AppColors.cyberAlertRed,
            ),
          ),
        ),
      ],
    );
  }
}
