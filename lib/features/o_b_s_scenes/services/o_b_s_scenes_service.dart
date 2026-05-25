import 'package:flutter/foundation.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_server/services/services.dart';
import 'package:obs_manager/features/persistances/persistances.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:signals_flutter/signals_flutter.dart';

class OBSScenesService {
  // Reactive state signals for scenes
  final scenes = signal<List<Scene>>([]);
  final currentScene = signal<String>('');

  /// Fetches all available scenes from OBS and sets the current program scene.
  Future<void> fetchScenes() async {
    final socket = getIt<OBSService>().socket;
    if (socket == null) return;

    try {
      final response = await socket.scenes.getSceneList();
      scenes.value = response.scenes.reversed.toList();
      currentScene.value = response.currentProgramSceneName;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching scene list: $e');
      }
      // Fallback: try fetching just the current scene
      try {
        final scene = await socket.scenes.getCurrentProgramScene();
        currentScene.value = scene;
      } catch (_) {}
    }
  }

  /// Changes the current program scene in OBS.
  Future<void> changeScene(String sceneName) async {
    final socket = getIt<OBSService>().socket;
    if (socket == null) return;

    try {
      await socket.scenes.setCurrentProgramScene(sceneName);
      currentScene.value = sceneName;
      await getIt<PersistancesLogsService>().addLog(
        code: 'info',
        message: 'Switch to scene: $sceneName',
      );
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error changing scene: $e');
      }
      await getIt<PersistancesLogsService>().addLog(
        code: 'error',
        message: 'Error changing scene: $e',
      );
      throw OBSScenesException(e.toString());
    }
  }

  /// Exposes the current program scene name.
  String get activeSceneName => currentScene.value;

  /// Reacts to external program scene change events.
  set activeSceneName(String sceneName) {
    currentScene.value = sceneName;
  }

  /// Resets the signals upon disconnect.
  void clearScenes() {
    scenes.value = [];
    currentScene.value = '';
  }
}
