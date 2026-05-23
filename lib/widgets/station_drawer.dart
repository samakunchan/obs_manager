import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/theme/constantes.dart';
import 'package:obs_manager/features/o_b_s_server/o_b_s_server.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// Individual list option in the station drawer
class StationDrawerOption extends StatelessWidget {
  const StationDrawerOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0x1F00E5FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppColors.cyberCyan : AppColors.cyberTextLight,
        ),
        title: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? AppColors.cyberCyan : AppColors.cyberTextLight,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}

/// Toggled sidebar configuration console drawer
class StationDrawer extends StatelessWidget {
  const StationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.cyberSurfaceContainerHighest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            /// Station Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Row(
                spacing: 12,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: AppColors.cyberCyan, borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.terminal, color: AppColors.cyberSurface),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: 2,
                      children: [
                        Text(
                          'OBS_STATION_01',
                          maxLines: 1,
                          overflow: .ellipsis,
                          style: GoogleFonts.barlowCondensed(fontSize: 18, fontWeight: .bold, color: AppColors.cyberCyan),
                        ),
                        Text(
                          'ONLINE • v29.1.3',
                          style: GoogleFonts.jetBrainsMono(fontSize: 10, fontWeight: .bold, color: AppColors.cyberCyan),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// Navigation Menu
            const Expanded(
              child: SelectionArea(
                child: Column(
                  children: [
                    StationDrawerOption(icon: Icons.settings, label: 'Output Settings', isSelected: true),
                    StationDrawerOption(icon: Icons.vpn_key, label: 'Stream Keys', isSelected: false),
                    StationDrawerOption(icon: Icons.keyboard, label: 'Hotkeys', isSelected: false),
                    StationDrawerOption(icon: Icons.movie_edit, label: 'Transitions', isSelected: false),
                    StationDrawerOption(icon: Icons.developer_board, label: 'Advanced', isSelected: false),
                  ],
                ),
              ),
            ),

            /// OBS Connection Controls
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Watch((context) {
                final bool isConnected = getIt<OBSService>().isConnected.value;
                final String status = getIt<OBSService>().statusMessage.value;

                return Column(
                  crossAxisAlignment: .stretch,
                  spacing: 12,
                  children: [
                    LabelInfoStatusConnection(isConnected: isConnected, status: status),
                    const ConnectToOBSButton(),
                    const DisconnectToOBSButton(),
                  ],
                );
              }),
            ),

            /// Close Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: OutlinedButton(
                onPressed: Navigator.of(context).pop,
                child: Text('CLOSE CONSOLE', style: GoogleFonts.jetBrainsMono(fontSize: 11, fontWeight: .bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
