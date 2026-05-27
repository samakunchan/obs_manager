import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_server/widgets/connect_to_o_b_s_dialog.dart';

class ConnectToOBSButton extends StatelessWidget {
  const ConnectToOBSButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog<void>(
          context: context,
          barrierColor: Colors.black87,
          builder: (BuildContext context) => const ConnectToOBSDialog(),
        );
      },
      icon: const Icon(Icons.power, size: 16),
      label: Text(
        context.localization.connect.toUpperCase(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.cyberSurface),
      ),
    );
  }
}
