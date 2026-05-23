import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        Text('SCENES', style: AppTextTheme.barlowCondensed),
        Text(
          '$presetsCount PRESETS LOADED',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11,
            fontWeight: .w500,
            color: AppColors.cyberTextMuted,
          ),
        ),
      ],
    );
  }
}
