import 'package:flutter/material.dart';
import 'package:obs_manager/features/o_b_s_scenes/o_b_s_scenes.dart';
import 'package:obs_manager/features/o_b_s_sources/o_b_s_sources.dart';

/// Dynamic Vertical Mobile Stacking Layout Widget
class MobileLayout extends StatelessWidget {
  const MobileLayout({
    required this.isConnected,
    required this.scenes,
    required this.activeSceneIndex,
    required this.onSceneSelected,
    super.key,
  });

  final bool isConnected;
  final List<Map<String, dynamic>> scenes;
  final int activeSceneIndex;
  final void Function(int index, String name) onSceneSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        /// Scene header + count
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: ScenesHeader(presetsCount: scenes.length),
        ),

        /// Scenes
        if (isConnected)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ScenesGrid(
              scenes: scenes,
              activeSceneIndex: activeSceneIndex,
              crossAxisCount: 2,
              onSceneSelected: onSceneSelected,
            ),
          )
        else
          /// When OBS is offline
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: OfflineScenesPlaceholder(),
          ),

        /// Sources
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: SourcesPanel(),
        ),

        /// Audio
        // const AudioMixPanel(),
      ],
    );
  }
}
