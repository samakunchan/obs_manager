import 'package:flutter/foundation.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_scenes/o_b_s_scenes.dart';
import 'package:obs_manager/features/o_b_s_server/services/services.dart';
import 'package:obs_manager/features/persistances/persistances.dart';
import 'package:obs_websocket/event.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:signals_flutter/signals_flutter.dart';

class OBSSourcesService {
  // Reactive state signals for sources
  final sources = signal<List<SceneItemDetail>>([]);

  /// Fetches all active sources (scene items) for the current OBS program scene.
  Future<void> fetchSources() async {
    final socket = getIt<OBSService>().socket;
    if (socket == null) return;

    final currentSceneName = getIt<OBSScenesService>().activeSceneName;
    if (currentSceneName.isEmpty) return;

    try {
      final List<SceneItemDetail> details = await socket.sceneItems.getSceneItemList(currentSceneName);
      sources.value = details.reversed.toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching sources: $e');
      }
    }
  }

  /// Toggles the enablement (visibility) state of a source in the current scene.
  Future<void> toggleSourceEnabled(SceneItemDetail source) async {
    final socket = getIt<OBSService>().socket;
    if (socket == null) return;

    final currentSceneName = getIt<OBSScenesService>().activeSceneName;
    if (currentSceneName.isEmpty) return;

    try {
      final SceneItemEnableStateChanged request = SceneItemEnableStateChanged(
        sceneName: currentSceneName,
        sceneItemId: source.sceneItemId,
        sceneItemEnabled: !source.sceneItemEnabled,
      );

      await socket.sceneItems.setSceneItemEnabled(request);
      await fetchSources();
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error toggling source: $e');
      }
      await getIt<PersistancesLogsService>().addLog(
        code: 'error',
        message: 'Error toggling source: $e',
      );
      throw OBSSourcesException(e.toString());
    }
  }

  /// Resets the signals upon disconnect.
  void clearSources() {
    sources.value = [];
  }
}
