import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_scenes/o_b_s_scenes.dart';
import 'package:obs_manager/features/o_b_s_server/o_b_s_server.dart';
import 'package:obs_manager/widgets/widgets.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// Interactive Scenes Overlay Panel wrapped inside BottomActionPanelWrapper.
/// Focuses strictly on scene visibility filtering: tapping anywhere on the tile toggles its main screen visibility checkbox.
class ActionPanelScenesFilter extends StatelessWidget {
  const ActionPanelScenesFilter({
    required this.onClose,
    required this.visibleScenes,
    required this.onSceneVisibilityChanged,
    super.key,
  });

  final VoidCallback onClose;
  final Set<String> visibleScenes;
  final void Function(String name, {required bool isVisible}) onSceneVisibilityChanged;

  @override
  Widget build(BuildContext context) {
    final OBSScenesService scenesService = getIt<OBSScenesService>();
    final OBSService obsService = getIt<OBSService>();
    final Orientation orientation = MediaQuery.of(context).orientation;
    final int countAxis = switch (orientation) {
      .portrait => 3,
      .landscape => 5,
    };

    final double width = MediaQuery.of(context).size.width;
    final bool isDesktop = width > 800;

    return BottomActionPanelWrapper(
      glowColor: Theme.of(context).colorScheme.tertiary,
      title: context.localization.scenesDirectory.toUpperCase(),
      onClose: onClose,
      leadingHeader: Icon(Icons.grid_view_rounded, color: Theme.of(context).colorScheme.secondary, size: 16),
      child: SizedBox(
        height: 220, // Constrained container height for ShowcaseCard/Wrapper content
        child: Watch((_) {
          final bool isConnected = obsService.isConnected.value;
          final List<Scene> allScenes = scenesService.scenes.value;

          return Column(
            crossAxisAlignment: .stretch,
            children: [
              /// Header Info Text
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    context.localization.chooseVisibleMainScenes.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 10,
                      letterSpacing: 1,
                      color: AppColors.cyberTextMuted,
                    ),
                  ),
                  Text(
                    context.localization.selected(visibleScenes.length),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 9,
                      fontWeight: .bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(height: 1, color: Color(0x1FFFFFFF)),
              const SizedBox(height: 12),

              /// Grid of tactile scene tiles
              Expanded(
                child: isConnected
                    ? (allScenes.isEmpty
                          ? Center(
                              child: Text(
                                context.localization.noScenesDetected.toUpperCase(),
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(fontSize: 10, color: AppColors.cyberTextMuted),
                              ),
                            )
                          : GridView.builder(
                              itemCount: allScenes.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isDesktop ? countAxis + 2 : countAxis,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 2,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                final Scene scene = allScenes[index];
                                final bool isChecked = visibleScenes.contains(scene.sceneName);

                                return _buildSceneTile(
                                  context: context,
                                  name: scene.sceneName,
                                  isVisible: isChecked,
                                  onVisibleChanged: (val) {
                                    if (val != null) {
                                      onSceneVisibilityChanged(scene.sceneName, isVisible: val);
                                    }
                                  },
                                );
                              },
                            ))
                    : Center(
                        child: Text(
                          context.localization.connectToObsToListScenes.toUpperCase(),
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(fontSize: 10, color: AppColors.cyberTextMuted),
                        ),
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSceneTile({
    required BuildContext context,
    required String name,
    required bool isVisible,
    required ValueChanged<bool?> onVisibleChanged,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onVisibleChanged(!isVisible),
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: isVisible
                ? Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1)
                : Theme.of(context).colorScheme.surfaceContainerLow.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isVisible ? Theme.of(context).colorScheme.secondary : const Color(0x1F4FC3F7),
              width: isVisible ? 1.5 : 1,
            ),
            boxShadow: [
              if (isVisible)
                BoxShadow(
                  color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.15),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
            ],
          ),
          child: Row(
            spacing: 4,
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: AppColors.cyberTextMuted,
                ),
                child: Checkbox(
                  value: isVisible,
                  onChanged: onVisibleChanged,
                  activeColor: Theme.of(context).colorScheme.secondary,
                  checkColor: Colors.black,
                  visualDensity: .compact,
                  materialTapTargetSize: .shrinkWrap,
                ),
              ),
              Expanded(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 12,
                    color: isVisible ? Theme.of(context).colorScheme.tertiary : AppColors.cyberTextMuted,
                  ),
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
