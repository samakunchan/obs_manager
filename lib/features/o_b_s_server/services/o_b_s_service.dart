import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_scenes/o_b_s_scenes.dart';
import 'package:obs_manager/features/o_b_s_server/services/services.dart';
import 'package:obs_manager/features/o_b_s_sources/o_b_s_sources.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:signals_flutter/signals_flutter.dart';

class OBSService {
  ObsWebSocket? _socket;

  /// Exposes the active ObsWebSocket connection.
  ObsWebSocket? get socket => _socket;

  // Reactive state signals
  final isConnected = signal<bool>(false);
  final statusMessage = signal<String>('Disconnected');
  final isStreaming = signal<bool>(false);

  /// Attempts to connect to OBS. Enforces a singleton strategy:
  /// if a socket is already active, we close it before reconnecting.
  Future<void> connect({
    required String ip,
    required String port,
    String? password,
  }) async {
    try {
      // Singleton strategy: close existing connection first
      if (_socket != null) {
        await logout();
      }

      if (kDebugMode) {
        print('ws://$ip:$port - $password');
      }

      statusMessage.value = 'Connecting...';

      _socket = await ObsWebSocket.connect(
        'ws://$ip:$port',
        password: password,
        fallbackEventHandler: _fallbackEventHandler,
      );
      // Verify connection by getting active profile list
      final ProfileListResponse? defaultProfile = await _socket?.config.getProfileList();
      if (defaultProfile != null && defaultProfile.currentProfileName.isNotEmpty) {
        isConnected.value = true;
        statusMessage.value = 'Connected';

        // Subscribe to all OBS events
        await _socket?.subscribe(EventSubscription.all);

        // Fetch initial streaming status
        final streamStatus = await _socket?.stream.status;
        if (streamStatus != null) {
          isStreaming.value = streamStatus.outputActive;
        }

        // Fetch initial scenes and sources via their respective services
        try {
          await getIt<OBSScenesService>().fetchScenes();
          await getIt<OBSSourcesService>().fetchSources();
        } catch (_) {}
      } else {
        throw OBSServerException('SERVER_CANNOT_CONNECTED');
      }
    } on Exception catch (e) {
      isConnected.value = false;
      statusMessage.value = 'Connection failed';
      _socket = null;
      if (kDebugMode) {
        print('Message : $e');
      }
      throw OBSServerException(e.toString());
    }
  }

  /// Logs out of the current OBS session and resets all signals.
  Future<void> logout() async {
    try {
      if (_socket != null) {
        await _socket?.close();
        _socket = null;
      }
      isConnected.value = false;
      isStreaming.value = false;
      getIt<OBSScenesService>().clearScenes();
      getIt<OBSSourcesService>().clearSources();
      statusMessage.value = 'Disconnected';
    } on Exception catch (_) {
      isConnected.value = false;
      isStreaming.value = false;
      getIt<OBSScenesService>().clearScenes();
      getIt<OBSSourcesService>().clearSources();
      statusMessage.value = 'Disconnected';
      _socket = null;
      throw OBSServerException('SERVER_CANNOT_DISCONNECTED');
    }
  }

  /// Starts streaming in OBS.
  Future<void> startStreaming() async {
    try {
      await _socket?.stream.start();
      isStreaming.value = true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error starting stream: $e');
      }
      throw OBSStatusException(e.toString());
    }
  }

  /// Stops streaming in OBS.
  Future<void> stopStreaming() async {
    try {
      await _socket?.stream.stop();
      isStreaming.value = false;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error stopping stream: $e');
      }
      throw OBSStatusException(e.toString());
    }
  }

  Future<void> _fallbackEventHandler(Event event) async {
    if (event.eventType == 'CurrentProgramSceneChanged') {
      getIt<OBSScenesService>().activeSceneName = event.eventData?['sceneName']?.toString() ?? '';
      await getIt<OBSSourcesService>().fetchSources();
    }

    if (event.eventType == 'SceneItemEnableStateChanged') {
      await getIt<OBSSourcesService>().fetchSources();
    }

    if (event.eventType == 'StreamStateChanged') {
      final state = event.eventData?['outputState']?.toString();
      if (state == 'OBS_WEBSOCKET_OUTPUT_STARTED') {
        isStreaming.value = true;
      } else if (state == 'OBS_WEBSOCKET_OUTPUT_STOPPED') {
        isStreaming.value = false;
      }
    }
  }
}
