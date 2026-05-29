import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_server/o_b_s_server.dart';
import 'package:obs_manager/features/o_b_s_sound/o_b_s_sound.dart';
import 'package:obs_manager/widgets/widgets.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// Premium State-of-the-art Glassmorphic Audio Quick Control Panel.
/// Re-engineered to delegate layouts and transitions to [BottomActionPanelWrapper].
class ActionPanelAudio extends StatefulWidget {
  const ActionPanelAudio({required this.onClose, super.key});

  final VoidCallback onClose;

  @override
  State<ActionPanelAudio> createState() => _ActionPanelAudioState();
}

class _ActionPanelAudioState extends State<ActionPanelAudio> {
  // Mock Decibel level logic for a premium real-time visualizer effect
  final List<double> _barHeights = List.filled(15, 0.1);
  Timer? _visualizerTimer;

  @override
  void initState() {
    super.initState();
    // Periodic simulation for the live decibel VU bars when active
    _visualizerTimer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      if (mounted) {
        final OBSSoundService soundService = getIt<OBSSoundService>();
        final bool isMuted = soundService.isSoundMuted.value;
        final bool isConnected = getIt<OBSService>().isConnected.value;

        setState(() {
          for (int i = 0; i < _barHeights.length; i++) {
            if (!isConnected || isMuted) {
              _barHeights[i] = 0.05; // flatline when muted or offline
            } else {
              _barHeights[i] = (math.Random().nextDouble() * 0.7 + 0.1) * 1;
              // Simulated dynamic levels multiplied by volume value
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _visualizerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OBSSoundService soundService = getIt<OBSSoundService>();
    final OBSService obsService = getIt<OBSService>();

    return BottomActionPanelWrapper(
      glowColor: Theme.of(context).colorScheme.tertiary,
      title: context.localization.quickAudioControl.toUpperCase(),
      onClose: widget.onClose,
      leadingHeader: Watch((_) {
        final bool isMuted = soundService.isSoundMuted.value;
        final bool isConnected = obsService.isConnected.value;

        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isConnected
                ? (isMuted ? Theme.of(context).colorScheme.error : AppColors.successColor)
                : AppColors.cyberTextMuted,
            boxShadow: [
              if (isConnected && !isMuted)
                BoxShadow(
                  color: AppColors.successColor.withValues(alpha: 0.6),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
            ],
          ),
        );
      }),
      child: Watch((_) {
        final bool isMuted = soundService.isSoundMuted.value;
        final bool isConnected = obsService.isConnected.value;
        final String micName = soundService.inputName.value;

        return Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: [
            /// Mic Status and VU visualizer Row
            Row(
              children: [
                /// Microphone Active Toggle Button
                if (isConnected)
                  const OBSToggleSoundButton()
                else
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.mic_off_rounded, color: AppColors.cyberTextMuted, size: 20),
                  ),
                const SizedBox(width: 12),

                /// Connection & Device Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 2,
                    children: [
                      Text(
                        isConnected ? micName : context.localization.obsOffline.toUpperCase(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          fontWeight: .bold,
                          color: isConnected ? Theme.of(context).colorScheme.secondary : AppColors.cyberTextMuted,
                        ),
                        maxLines: 1,
                        overflow: .ellipsis,
                      ),
                      Text(
                        isConnected
                            ? (isMuted ? context.localization.muted : context.localization.recordingDecibelsLive)
                            : context.localization.connectToActiveObsServer,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 9, color: AppColors.cyberTextMuted),
                      ),
                    ],
                  ),
                ),

                /// Real-time VU meter bars
                Container(
                  height: 24,
                  width: 80,
                  alignment: .center,
                  child: Row(
                    mainAxisAlignment: .spaceEvenly,
                    crossAxisAlignment: .end,
                    children: List.generate(_barHeights.length, (int index) {
                      final double h = _barHeights[index];
                      Color barColor = AppColors.successColor;
                      if (index > 11) {
                        barColor = AppColors.cyberAlertRed;
                      } else if (index > 8) {
                        barColor = AppColors.warningColor;
                      }
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 80),
                        width: 3,
                        height: 24 * h,
                        decoration: BoxDecoration(
                          color: barColor.withValues(alpha: isMuted ? 0.2 : 0.8),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
