import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_server/services/services.dart';

class DisconnectToOBSButton extends StatelessWidget {
  const DisconnectToOBSButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: getIt<OBSService>().logout,
      icon: const Icon(Icons.power_off, size: 16),
      label: Text(
        context.localization.disconnect.toUpperCase(),
      ),
      style:
          OutlinedButton.styleFrom(
            side: BorderSide(color: Theme.of(context).colorScheme.error),
          ).copyWith(
            overlayColor: kAlertOverlayColor,
            backgroundColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.hovered)) {
                return Theme.of(context).colorScheme.error.withValues(alpha: 0.15);
              }
              return Colors.transparent;
            }),
            foregroundColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.hovered)) {
                return Colors.black;
              }
              return AppColors.cyberAlertRed;
            }),
            iconColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.hovered)) {
                return Colors.black;
              }
              return AppColors.cyberAlertRed;
            }),
            textStyle: kAlertTextStyle,
          ),
    );
  }
}
