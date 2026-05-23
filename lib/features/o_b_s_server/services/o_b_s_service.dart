import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:signals_flutter/signals_flutter.dart';

class OBSService {
  ObsWebSocket? _socket;

  // Reactive state signals
  final isConnected = signal<bool>(false);
  final statusMessage = signal<String>('Disconnected');
  final isStreaming = signal<bool>(false);
  final currentScene = signal<String>('');

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

        // Fetch initial current scene
        try {
          final scene = await _socket?.scenes.getCurrentProgramScene();
          if (scene != null) {
            currentScene.value = scene;
          }
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
      currentScene.value = '';
      statusMessage.value = 'Disconnected';
    } on Exception catch (_) {
      isConnected.value = false;
      isStreaming.value = false;
      currentScene.value = '';
      statusMessage.value = 'Disconnected';
      _socket = null;
      throw OBSServerException('SERVER_CANNOT_DISCONNECTED');
    }
  }

  /// Event listener to react to real-time OBS state changes.
  Future<void> _fallbackEventHandler(Event event) async {
    if (event.eventType == 'CurrentProgramSceneChanged') {
      currentScene.value = event.eventData?['sceneName']?.toString() ?? '';
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
