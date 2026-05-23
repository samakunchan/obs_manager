import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_server/services/services.dart';

class ConnectToOBSButton extends StatelessWidget {
  const ConnectToOBSButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Parameters to connect can be filled in by the user
        getIt<OBSService>().connect(
          ip: '192.168.0.140',
          port: '4456',
          password: 'password123A&',
        );
      },
      icon: const Icon(Icons.power, color: Colors.white, size: 16),
      label: Text(
        'CONNECT',
        style: GoogleFonts.jetBrainsMono(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.cyberCyan,
        foregroundColor: AppColors.cyberSurface,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
