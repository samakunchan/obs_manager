import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/theme/constantes.dart';

class LabelInfoStatusConnection extends StatelessWidget {
  const LabelInfoStatusConnection({required this.isConnected, required this.status, super.key});
  final bool isConnected;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(
          'OBS CONNECTION:',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 10,
            fontWeight: FontWeight.bold,
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
            style: GoogleFonts.jetBrainsMono(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: isConnected ? AppColors.successColor : AppColors.cyberAlertRed,
            ),
          ),
        ),
      ],
    );
  }
}
