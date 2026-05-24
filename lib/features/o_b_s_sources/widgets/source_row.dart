import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/index.dart';

/// List element inside sources
class SourceRow extends StatelessWidget {
  const SourceRow({
    required this.icon,
    required this.label,
    required this.isVisible,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool isVisible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.cyberSurfaceContainerHigh.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0x0C3B494C),
          ),
        ),
        child: Opacity(
          opacity: isVisible ? 1.0 : 0.45,
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Row(
                spacing: 12,
                children: [
                  Icon(icon, size: 18, color: AppColors.cyberCyan),
                  Text(
                    label,
                    style: GoogleFonts.inter(fontSize: 13, fontWeight: .w500, color: AppColors.cyberTextLight),
                  ),
                ],
              ),
              Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
                size: 16,
                color: AppColors.cyberTextMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
