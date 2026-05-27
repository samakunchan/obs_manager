import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:obs_manager/core/theme/constantes.dart';
import 'package:obs_manager/features/o_b_s_server/o_b_s_server.dart';
import 'package:obs_manager/features/persistances/persistances.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// Individual list option in the station drawer
class StationDrawerOption extends StatelessWidget {
  const StationDrawerOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0x1F00E5FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? AppColors.cyberCyan : AppColors.cyberTextLight),
        title: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            fontWeight: isSelected ? .bold : .normal,
            color: isSelected ? AppColors.cyberCyan : AppColors.cyberTextLight,
          ),
        ),
        onTap: onTap,
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
                  FutureBuilder(
                    future: PackageInfo.fromPlatform(),
                    builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
                      if (kDebugMode) {
                        print(snapshot.data?.version);
                        print('Si la version n‘est pas la même. Il faut cut/restart.');
                      }
                      if (snapshot.hasData) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsetsGeometry.symmetric(vertical: 16),
                            child: Column(
                              crossAxisAlignment: .start,
                              spacing: 2,
                              children: [
                                Text(
                                  'OBS MANAGER',
                                  overflow: .ellipsis,
                                  style:
                                      Theme.of(
                                        context,
                                      ).textTheme.titleSmall?.copyWith(
                                        fontWeight: .bold,
                                        color: AppColors.cyberCyan,
                                      ),
                                ),
                                Text(
                                  'v${snapshot.data?.version}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(fontSize: 10, fontWeight: .bold, color: AppColors.cyberCyan),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return Text(
                          '${snapshot.error}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(fontSize: 10, fontWeight: .bold, color: AppColors.cyberCyan),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),

            /// Navigation Menu
            Expanded(
              child: SelectionArea(
                child: Column(
                  children: [
                    StationDrawerOption(
                      icon: Icons.delete,
                      label: 'Cache clear',
                      isSelected: false,
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          barrierColor: Colors.black87,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: AppColors.cyberSurfaceContainerLow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppDefaultValues.kBorderRadiusSecondary),
                                side: const BorderSide(color: AppColors.cyberAlertRed, width: 1.5),
                              ),
                              insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                              child: Container(
                                constraints: const BoxConstraints(maxWidth: 400),
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  mainAxisSize: .min,
                                  spacing: 16,
                                  children: [
                                    Row(
                                      spacing: 12,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: AppColors.cyberAlertRed.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: const Icon(
                                            Icons.warning_amber_rounded,
                                            color: AppColors.cyberAlertRed,
                                            size: 28,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'SYSTEM PURGE REQUEST',
                                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                              fontWeight: .bold,
                                              color: AppColors.cyberAlertRed,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(color: AppColors.cyberAlertRed, thickness: 1),
                                    Text(
                                      'WARNING: This operation will permanently wipe all local database registries, cached credentials, and system log history.\n\nYou will be logged out of the station. Are you sure you want to proceed?',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: AppColors.cyberTextLight,
                                        height: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: .end,
                                      spacing: 12,
                                      children: [
                                        OutlinedButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(color: AppColors.cyberTextMuted),
                                            foregroundColor: AppColors.cyberTextLight,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            'CANCEL',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              fontWeight: .bold,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            // 1. Logout cleanly from OBS
                                            await getIt<OBSService>().logout();
                                            // 2. Clear all persistence services
                                            await getIt<PersistancesService>().clear();
                                            await getIt<PersistancesScenesService>().clear();
                                            await getIt<PersistancesLogsService>().clear();

                                            if (context.mounted) {
                                              // Pop warning dialog
                                              Navigator.of(context).pop();
                                              // Pop drawer
                                              Navigator.of(context).pop();

                                              // Show success banner
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  backgroundColor: AppColors.successColor,
                                                  content: Text(
                                                    '🤖 CACHE FULLY PURGED AND LOGGED OUT CLEANLY',
                                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight: .bold,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  duration: const Duration(seconds: 3),
                                                ),
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.cyberAlertRed,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            'PURGE',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              fontWeight: .bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            /// OBS Connection Controls
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Watch((_) {
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
                child: Text(
                  'CLOSE CONSOLE',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11, fontWeight: .bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
