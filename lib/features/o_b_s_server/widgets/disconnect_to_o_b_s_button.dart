import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        'DISCONNECT',
        style: GoogleFonts.jetBrainsMono(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.cyberAlertRed,
          letterSpacing: 1,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.cyberAlertRed),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
