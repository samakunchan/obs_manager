import 'dart:async';

import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_scenes/o_b_s_scenes.dart';
import 'package:obs_manager/features/o_b_s_server/services/services.dart';
import 'package:obs_manager/features/o_b_s_sound/o_b_s_sound.dart';
import 'package:obs_manager/features/o_b_s_sources/o_b_s_sources.dart';
import 'package:obs_manager/features/persistances/persistances.dart';
import 'package:obs_websocket/obs_websocket.dart';

Transform _createFakeTransform() {
  return Transform.fromJson(<String, dynamic>{
    'alignment': 0,
    'boundsAlignment': 0,
    'boundsHeight': 0.0,
    'boundsType': 'OBS_BOUNDS_NONE',
    'boundsWidth': 0.0,
    'cropBottom': 0,
    'cropLeft': 0,
    'cropRight': 0,
    'cropTop': 0,
    'height': 0.0,
    'positionX': 0.0,
    'positionY': 0.0,
    'rotation': 0.0,
    'scaleX': 1.0,
    'scaleY': 1.0,
    'sourceHeight': 0.0,
    'sourceWidth': 0.0,
    'width': 0.0,
  });
}

class FakeOBSService extends OBSService {
  FakeOBSService();

  @override
  Future<void> connect({
    required String ip,
    required String port,
    String? password,
  }) async {
    statusMessage.value = 'Connecting...';
    await Future<void>.delayed(const Duration(milliseconds: 600));

    isConnected.value = true;
    statusMessage.value = 'Connected';

    await getIt<PersistancesService>().saveCredentials(
      ip: ip,
      port: port,
      password: password,
    );

    await getIt<PersistancesLogsService>().addLog(
      code: 'success',
      message: 'Connected to FAKE OBS at ws://$ip:$port (Demo Mode)',
    );

    // Bootstrap simulated data
    await getIt<OBSScenesService>().fetchScenes();
    await getIt<OBSSourcesService>().fetchSources();
    await getIt<OBSSoundService>().detectSoundConfiguration();
    await getIt<OBSSoundService>().getStatusSound();
  }

  @override
  Future<void> autoConnectOnStartup() async {
    final PersistancesService persistances = getIt<PersistancesService>();
    if (persistances.hasCredentials) {
      statusMessage.value = 'Auto-connecting...';
      await getIt<PersistancesLogsService>().addLog(
        code: 'info',
        message: 'Attempting auto-connection to FAKE OBS',
      );
      await connect(
        ip: persistances.ip!,
        port: persistances.port!,
        password: persistances.password,
      );
    }
  }

  @override
  Future<void> reconnect() async {
    final PersistancesService persistances = getIt<PersistancesService>();
    if (persistances.hasCredentials) {
      await connect(
        ip: persistances.ip!,
        port: persistances.port!,
        password: persistances.password,
      );
    }
  }

  @override
  Future<void> logout() async {
    await getIt<PersistancesLogsService>().addLog(
      code: 'info',
      message: 'Successfully logged out from FAKE OBS',
    );
    isConnected.value = false;
    streamStatus.value = StatusStream.stopped;
    getIt<OBSScenesService>().clearScenes();
    getIt<OBSSourcesService>().clearSources();
    getIt<OBSSoundService>().clearSound();
    statusMessage.value = 'Disconnected';
  }

  @override
  Future<void> startStreaming() async {
    streamStatus.value = StatusStream.isStarting;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    streamStatus.value = StatusStream.started;
    await getIt<PersistancesLogsService>().addLog(
      code: 'info',
      message: 'Simulated stream started successfully...',
    );
  }

  @override
  Future<void> stopStreaming() async {
    streamStatus.value = StatusStream.isStopping;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    streamStatus.value = StatusStream.stopped;
    await getIt<PersistancesLogsService>().addLog(
      code: 'info',
      message: 'Simulated stream stopped successfully...',
    );
  }
}

class FakeOBSScenesService extends OBSScenesService {
  final List<Scene> _fakeScenes = <Scene>[
    Scene(sceneName: 'Intro Screen', sceneIndex: 0),
    Scene(sceneName: 'Main Cam', sceneIndex: 1),
    Scene(sceneName: 'Screen Share', sceneIndex: 2),
    Scene(sceneName: 'BRB / Intermission', sceneIndex: 3),
    Scene(sceneName: 'Outro Screen', sceneIndex: 4),
  ];

  @override
  Future<void> fetchScenes() async {
    scenes.value = _fakeScenes;
    if (currentScene.value.isEmpty) {
      currentScene.value = 'Main Cam';
    }
  }

  @override
  Future<void> changeScene(String sceneName) async {
    currentScene.value = sceneName;
    await getIt<PersistancesLogsService>().addLog(
      code: 'info',
      message: 'Switch to fake scene: $sceneName',
    );
    await getIt<OBSSourcesService>().fetchSources();
  }
}

class FakeOBSSourcesService extends OBSSourcesService {
  final Map<String, List<SceneItemDetail>> _fakeSourcesMap = <String, List<SceneItemDetail>>{
    'Intro Screen': <SceneItemDetail>[
      SceneItemDetail(
        sceneItemId: 101,
        sceneItemEnabled: true,
        sourceName: 'Intro Video Loop',
        inputKind: 'ffmpeg_source',
        isGroup: false,
        sceneItemBlendMode: 'OBS_BLEND_NORMAL',
        sceneItemIndex: 1,
        sceneItemLocked: false,
        sceneItemTransform: _createFakeTransform(),
        sourceType: 'OBS_SOURCE_TYPE_INPUT',
      ),
      SceneItemDetail(
        sceneItemId: 102,
        sceneItemEnabled: true,
        sourceName: 'Overlay Graphics',
        inputKind: 'image_source',
        isGroup: false,
        sceneItemBlendMode: 'OBS_BLEND_NORMAL',
        sceneItemIndex: 2,
        sceneItemLocked: false,
        sceneItemTransform: _createFakeTransform(),
        sourceType: 'OBS_SOURCE_TYPE_INPUT',
      ),
      SceneItemDetail(
        sceneItemId: 103,
        sceneItemEnabled: false,
        sourceName: 'BGM Music',
        inputKind: 'wasapi_output_capture',
        isGroup: false,
        sceneItemBlendMode: 'OBS_BLEND_NORMAL',
        sceneItemIndex: 3,
        sceneItemLocked: false,
        sceneItemTransform: _createFakeTransform(),
        sourceType: 'OBS_SOURCE_TYPE_INPUT',
      ),
    ],
    'Main Cam': <SceneItemDetail>[
      SceneItemDetail(
        sceneItemId: 201,
        sceneItemEnabled: true,
        sourceName: 'Webcam Capture',
        inputKind: 'dshow_input',
        isGroup: false,
        sceneItemBlendMode: 'OBS_BLEND_NORMAL',
        sceneItemIndex: 1,
        sceneItemLocked: false,
        sceneItemTransform: _createFakeTransform(),
        sourceType: 'OBS_SOURCE_TYPE_INPUT',
      ),
      SceneItemDetail(
        sceneItemId: 202,
        sceneItemEnabled: true,
        sourceName: 'Background Blur',
        inputKind: 'color_source_v2',
        isGroup: false,
        sceneItemBlendMode: 'OBS_BLEND_NORMAL',
        sceneItemIndex: 2,
        sceneItemLocked: false,
        sceneItemTransform: _createFakeTransform(),
        sourceType: 'OBS_SOURCE_TYPE_INPUT',
      ),
      SceneItemDetail(
        sceneItemId: 203,
        sceneItemEnabled: false,
        sourceName: 'Border Glow',
        inputKind: 'image_source',
        isGroup: false,
        sceneItemBlendMode: 'OBS_BLEND_NORMAL',
        sceneItemIndex: 3,
        sceneItemLocked: false,
        sceneItemTransform: _createFakeTransform(),
        sourceType: 'OBS_SOURCE_TYPE_INPUT',
      ),
      SceneItemDetail(
        sceneItemId: 204,
        sceneItemEnabled: true,
        sourceName: 'Microphone',
        inputKind: 'wasapi_input_capture',
        isGroup: false,
        sceneItemBlendMode: 'OBS_BLEND_NORMAL',
        sceneItemIndex: 4,
        sceneItemLocked: false,
        sceneItemTransform: _createFakeTransform(),
        sourceType: 'OBS_SOURCE_TYPE_INPUT',
      ),
    ],
    'Screen Share': <SceneItemDetail>[
      SceneItemDetail(
        sceneItemId: 301,
        sceneItemEnabled: true,
        sourceName: 'Browser Window',
        inputKind: 'window_capture',
        isGroup: false,
        sceneItemBlendMode: 'OBS_BLEND_NORMAL',
        sceneItemIndex: 1,
        sceneItemLocked: false,
        sceneItemTransform: _createFakeTransform(),
        sourceType: 'OBS_SOURCE_TYPE_INPUT',
      ),
      SceneItemDetail(
        sceneItemId: 302,
        sceneItemEnabled: true,
        sourceName: 'Webcam PIP',
        inputKind: 'dshow_input',
        isGroup: false,
        sceneItemBlendMode: 'OBS_BLEND_NORMAL',
        sceneItemIndex: 2,
        sceneItemLocked: false,
        sceneItemTransform: _createFakeTransform(),
        sourceType: 'OBS_SOURCE_TYPE_INPUT',
      ),
      SceneItemDetail(
        sceneItemId: 303,
        sceneItemEnabled: true,
        sourceName: 'Border Frame',
        inputKind: 'image_source',
        isGroup: false,
        sceneItemBlendMode: 'OBS_BLEND_NORMAL',
        sceneItemIndex: 3,
        sceneItemLocked: false,
        sceneItemTransform: _createFakeTransform(),
        sourceType: 'OBS_SOURCE_TYPE_INPUT',
      ),
    ],
    'BRB / Intermission': <SceneItemDetail>[
      SceneItemDetail(
        sceneItemId: 401,
        sceneItemEnabled: true,
        sourceName: 'BRB Text',
        inputKind: 'text_gdiplus_v2',
        isGroup: false,
        sceneItemBlendMode: 'OBS_BLEND_NORMAL',
        sceneItemIndex: 1,
        sceneItemLocked: false,
        sceneItemTransform: _createFakeTransform(),
        sourceType: 'OBS_SOURCE_TYPE_INPUT',
      ),
      SceneItemDetail(
        sceneItemId: 402,
        sceneItemEnabled: true,
        sourceName: 'Countdown Timer',
        inputKind: 'text_gdiplus_v2',
        isGroup: false,
        sceneItemBlendMode: 'OBS_BLEND_NORMAL',
        sceneItemIndex: 2,
        sceneItemLocked: false,
        sceneItemTransform: _createFakeTransform(),
        sourceType: 'OBS_SOURCE_TYPE_INPUT',
      ),
      SceneItemDetail(
        sceneItemId: 403,
        sceneItemEnabled: true,
        sourceName: 'Music Playlist',
        inputKind: 'ffmpeg_source',
        isGroup: false,
        sceneItemBlendMode: 'OBS_BLEND_NORMAL',
        sceneItemIndex: 3,
        sceneItemLocked: false,
        sceneItemTransform: _createFakeTransform(),
        sourceType: 'OBS_SOURCE_TYPE_INPUT',
      ),
    ],
    'Outro Screen': <SceneItemDetail>[
      SceneItemDetail(
        sceneItemId: 501,
        sceneItemEnabled: true,
        sourceName: 'Outro Video',
        inputKind: 'ffmpeg_source',
        isGroup: false,
        sceneItemBlendMode: 'OBS_BLEND_NORMAL',
        sceneItemIndex: 1,
        sceneItemLocked: false,
        sceneItemTransform: _createFakeTransform(),
        sourceType: 'OBS_SOURCE_TYPE_INPUT',
      ),
      SceneItemDetail(
        sceneItemId: 502,
        sceneItemEnabled: true,
        sourceName: 'Credits Scroll',
        inputKind: 'text_gdiplus_v2',
        isGroup: false,
        sceneItemBlendMode: 'OBS_BLEND_NORMAL',
        sceneItemIndex: 2,
        sceneItemLocked: false,
        sceneItemTransform: _createFakeTransform(),
        sourceType: 'OBS_SOURCE_TYPE_INPUT',
      ),
      SceneItemDetail(
        sceneItemId: 503,
        sceneItemEnabled: true,
        sourceName: 'Social Links Overlay',
        inputKind: 'image_source',
        isGroup: false,
        sceneItemBlendMode: 'OBS_BLEND_NORMAL',
        sceneItemIndex: 3,
        sceneItemLocked: false,
        sceneItemTransform: _createFakeTransform(),
        sourceType: 'OBS_SOURCE_TYPE_INPUT',
      ),
    ],
  };

  @override
  Future<void> fetchSources() async {
    final String activeScene = getIt<OBSScenesService>().activeSceneName;
    sources.value = _fakeSourcesMap[activeScene] ?? <SceneItemDetail>[];
  }

  @override
  Future<void> toggleSourceEnabled(SceneItemDetail source) async {
    final String activeScene = getIt<OBSScenesService>().activeSceneName;
    final List<SceneItemDetail> list = _fakeSourcesMap[activeScene] ?? <SceneItemDetail>[];
    for (int i = 0; i < list.length; i++) {
      if (list[i].sceneItemId == source.sceneItemId) {
        list[i] = SceneItemDetail(
          sceneItemId: list[i].sceneItemId,
          sceneItemEnabled: !list[i].sceneItemEnabled,
          sourceName: list[i].sourceName,
          inputKind: list[i].inputKind,
          isGroup: list[i].isGroup,
          sceneItemBlendMode: list[i].sceneItemBlendMode,
          sceneItemIndex: list[i].sceneItemIndex,
          sceneItemLocked: list[i].sceneItemLocked,
          sceneItemTransform: list[i].sceneItemTransform,
          sourceType: list[i].sourceType,
        );
        break;
      }
    }
    await getIt<PersistancesLogsService>().addLog(
      code: 'info',
      message: 'Toggled fake source "${source.sourceName}": ${!source.sceneItemEnabled ? "visible" : "hidden"}',
    );
    await fetchSources();
  }
}

class FakeOBSSoundService extends OBSSoundService {
  @override
  Future<void> detectSoundConfiguration() async {
    inputName.value = 'Studio Microphone';
    inputKind.value = 'wasapi_input_capture';
  }

  @override
  Future<void> getStatusSound() async {
    isSoundMuted.value = false;
  }

  @override
  Future<void> toggleMuteSound() async {
    isSoundMuted.value = !isSoundMuted.value;
    await getIt<PersistancesLogsService>().addLog(
      code: 'info',
      message: isSoundMuted.value ? 'Simulated sound muted' : 'Simulated sound activated',
    );
  }
}
