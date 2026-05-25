import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_scenes/o_b_s_scenes.dart';
import 'package:obs_manager/features/o_b_s_server/o_b_s_server.dart';
import 'package:obs_manager/widgets/widgets.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// Interactive Scenes Overlay Panel wrapped inside BottomActionPanelWrapper.
/// Focuses strictly on scene visibility filtering: tapping anywhere on the tile toggles its main screen visibility checkbox.
class ScenesActionPanel extends StatelessWidget {
  const ScenesActionPanel({
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
    final scenesService = getIt<OBSScenesService>();
    final obsService = getIt<OBSService>();

    return BottomActionPanelWrapper(
      title: 'SCENES DIRECTORY',
      onClose: onClose,
      leadingHeader: const Icon(Icons.grid_view_rounded, color: AppColors.cyberCyan, size: 16),
      child: SizedBox(
        height: 220, // Constrained container height for ShowcaseCard/Wrapper content
        child: Watch((_) {
          final isConnected = obsService.isConnected.value;
          final allScenes = scenesService.scenes.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Header Info Text
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CHOOSE VISIBLE MAIN SCENES',
                    style: GoogleFonts.barlowCondensed(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: AppColors.cyberTextMuted,
                    ),
                  ),
                  Text(
                    '${visibleScenes.length} SELECTED',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: AppColors.cyberCyan,
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
                                'NO SCENES DETECTED IN OBS',
                                style: GoogleFonts.jetBrainsMono(fontSize: 10, color: AppColors.cyberTextMuted),
                              ),
                            )
                          : GridView.builder(
                              itemCount: allScenes.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 2,
                              ),
                              itemBuilder: (context, index) {
                                final scene = allScenes[index];
                                final isChecked = visibleScenes.contains(scene.sceneName);

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
                          'CONNECT TO OBS TO LIST SCENES',
                          style: GoogleFonts.jetBrainsMono(fontSize: 10, color: AppColors.cyberTextMuted),
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
                ? AppColors.cyberCyan.withValues(alpha: 0.1)
                : AppColors.cyberSurfaceContainerLow.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isVisible ? AppColors.cyberCyan : const Color(0x1F4FC3F7),
              width: isVisible ? 1.5 : 1,
            ),
            boxShadow: [
              if (isVisible)
                BoxShadow(
                  color: AppColors.cyberCyan.withValues(alpha: 0.15),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
            ],
          ),
          child: Row(
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: AppColors.cyberTextMuted,
                ),
                child: Checkbox(
                  value: isVisible,
                  onChanged: onVisibleChanged,
                  activeColor: AppColors.cyberCyan,
                  checkColor: Colors.black,
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  name,
                  style: GoogleFonts.barlowCondensed(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isVisible ? Colors.white : AppColors.cyberTextMuted,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
