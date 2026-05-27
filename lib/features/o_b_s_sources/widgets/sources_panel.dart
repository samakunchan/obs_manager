import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_server/services/services.dart';
import 'package:obs_manager/features/o_b_s_sources/o_b_s_sources.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// Active video and image input sources panel
class SourcesPanel extends StatelessWidget {
  const SourcesPanel({super.key});

  IconData _getIconForSource(String inputKind) {
    final String kind = inputKind.toLowerCase();
    if (kind.contains('camera') || kind.contains('video') || kind.contains('dshow')) {
      return Icons.videocam_rounded;
    }
    if (kind.contains('image') || kind.contains('slideshow') || kind.contains('png') || kind.contains('jpg')) {
      return Icons.image_rounded;
    }
    if (kind.contains('text') || kind.contains('gdi') || kind.contains('free_type')) {
      return Icons.title_rounded;
    }
    if (kind.contains('audio') || kind.contains('wasapi') || kind.contains('mic') || kind.contains('sound')) {
      return Icons.volume_up_rounded;
    }
    if (kind.contains('browser')) {
      return Icons.language_rounded;
    }
    if (kind.contains('capture') || kind.contains('screen') || kind.contains('window') || kind.contains('monitor')) {
      return Icons.desktop_windows_rounded;
    }
    if (kind.contains('color')) {
      return Icons.color_lens_rounded;
    }
    return Icons.layers_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final OBSService obsService = getIt<OBSService>();
    final OBSSourcesService sourcesService = getIt<OBSSourcesService>();

    return Watch((_) {
      final isConnected = obsService.isConnected.value;
      final List<Widget> children = [];

      if (isConnected) {
        final currentSources = sourcesService.sources.value;
        if (currentSources.isEmpty) {
          children.add(
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  context.localization.noSourcesDetected.toUpperCase(),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontSize: 12, color: AppColors.cyberTextMuted, fontWeight: .bold),
                ),
              ),
            ),
          );
        } else {
          for (final source in currentSources) {
            children.add(
              SourceRow(
                icon: _getIconForSource(source.inputKind ?? ''),
                label: source.sourceName,
                isVisible: source.sceneItemEnabled,
                onTap: () => sourcesService.toggleSourceEnabled(source),
              ),
            );
          }
        }
      }

      return Container(
        padding: const EdgeInsets.all(AppDefaultValues.kBorderRadiusPrimary),
        decoration: BoxDecoration(
          color: AppColors.cyberSurfaceContainer.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(AppDefaultValues.kBorderRadiusSecondary),
          border: Border.all(color: const Color(0x1F4FC3F7)),
        ),
        child: Column(
          spacing: 12,
          crossAxisAlignment: .stretch,
          children: [
            /// Header
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(context.localization.sources.toUpperCase(), style: AppTextTheme.barlowCondensed),
              ],
            ),

            /// Sources list or placeholder
            if (isConnected)
              Column(
                spacing: 10,
                crossAxisAlignment: .stretch,
                children: children,
              )
            else
              const OfflineSourcesPlaceholder(),
          ],
        ),
      );
    });
  }
}
