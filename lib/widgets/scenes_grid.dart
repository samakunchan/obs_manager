import 'package:flutter/material.dart';
import 'package:obs_manager/widgets/widgets.dart';

/// Dynamic grid displaying all preset scene buttons
class ScenesGrid extends StatelessWidget {
  const ScenesGrid({
    required this.scenes,
    required this.activeSceneIndex,
    required this.crossAxisCount,
    required this.onSceneSelected,
    super.key,
  });

  final List<Map<String, dynamic>> scenes;
  final int activeSceneIndex;
  final int crossAxisCount;
  final void Function(int index, String name) onSceneSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: scenes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.6,
      ),
      itemBuilder: (BuildContext context, int index) {
        final Map<String, dynamic> scene = scenes[index];
        final bool isActive = activeSceneIndex == index;

        return TactileScenePad(
          name: scene['name'] as String,
          icon: scene['icon'] as IconData,
          isActive: isActive,
          onTap: () => onSceneSelected(index, scene['name'] as String),
        );
      },
    );
  }
}
