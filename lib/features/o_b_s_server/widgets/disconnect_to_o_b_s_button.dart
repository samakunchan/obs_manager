import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_server/services/services.dart';

class DisconnectToOBSButton extends StatelessWidget {
  const DisconnectToOBSButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: getIt<OBSService>().logout,
      icon: const Icon(Icons.power_off, color: AppColors.cyberAlertRed, size: 16),
      label: Text(
        context.localization.disconnect.toUpperCase(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.cyberAlertRed),
      ),
      style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.cyberAlertRed)),
    );
  }
}
