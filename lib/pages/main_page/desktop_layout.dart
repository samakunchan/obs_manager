import 'package:flutter/material.dart';
import 'package:obs_manager/features/o_b_s_scenes/o_b_s_scenes.dart';
import 'package:obs_manager/features/o_b_s_sound/o_b_s_sound.dart';
import 'package:obs_manager/features/o_b_s_sources/o_b_s_sources.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({
    required this.isConnected,
    required this.scenes,
    required this.activeSceneIndex,
    required this.activeSceneName,
    required this.onSceneSelected,
    super.key,
  });

  final bool isConnected;
  final List<Map<String, dynamic>> scenes;
  final int activeSceneIndex;
  final String activeSceneName;
  final void Function(int index, String name) onSceneSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .start,
      spacing: 24,
      children: [
        // Left Area: Scene selector and main preview
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              ScenesHeader(presetsCount: scenes.length),
              const SizedBox(height: 12),
              if (isConnected)
                ScenesGrid(
                  scenes: scenes,
                  activeSceneIndex: activeSceneIndex,
                  crossAxisCount: 3,
                  onSceneSelected: onSceneSelected,
                )
              else
                const OfflineScenesPlaceholder(),
              const SizedBox(height: 24),
              // PreviewMonitor(activeSceneName: activeSceneName),
            ],
          ),
        ),
        const Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AudioMixPanel(),
              SizedBox(height: 24),
              SourcesPanel(),
            ],
          ),
        ),
      ],
    );
  }
}
