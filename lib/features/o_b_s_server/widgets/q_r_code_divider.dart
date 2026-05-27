import 'package:flutter/material.dart';
import 'package:obs_manager/core/theme/constantes.dart';

class QRCodeDivider extends StatelessWidget {
  const QRCodeDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        const Expanded(child: Divider(color: AppColors.darkCardBorder)),
        Text(
          'OR CONNECT VIA QR CODE',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 9,
            fontWeight: .bold,
            color: AppColors.cyberTextMuted,
          ),
        ),
        const Expanded(child: Divider(color: AppColors.darkCardBorder)),
      ],
    );
  }
}
