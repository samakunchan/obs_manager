import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/app_lifecycle/app_lifecycle.dart';
import 'package:obs_manager/features/o_b_s_scenes/o_b_s_scenes.dart';
import 'package:obs_manager/features/o_b_s_server/services/services.dart';
import 'package:obs_manager/features/o_b_s_sound/o_b_s_sound.dart';
import 'package:obs_manager/features/o_b_s_sources/o_b_s_sources.dart';
import 'package:obs_manager/features/persistances/persistances.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class OBSService {
  OBSService() {
    try {
      final PersistancesService persistances = getIt<PersistancesService>();
      _lastIp = persistances.ip;
      _lastPort = persistances.port;
      _lastPassword = persistances.password;
    } catch (_) {}
  }

  ObsWebSocket? _socket;
  String? _lastIp;
  String? _lastPort;
  String? _lastPassword;

  Future<void>? _connectionFuture;

  /// Exposes the active ObsWebSocket connection.
  ObsWebSocket? get socket => _socket;

  // Reactive state signals
  final Signal<bool> isConnected = signal<bool>(false);
  final Signal<String> statusMessage = signal<String>('Disconnected');
  final Signal<StatusStream> streamStatus = signal<StatusStream>(StatusStream.stopped);

  /// Attempts to connect to OBS. Enforces a singleton strategy:
  /// if a socket is already active, we close it before reconnecting.
  Future<void> connect({
    required String ip,
    required String port,
    String? password,
  }) async {
    if (_connectionFuture != null) {
      if (kDebugMode) {
        print('Connection attempt already in progress. Awaiting existing future.');
      }
      return _connectionFuture;
    }

    final future = _connect(
      ip: ip,
      port: port,
      password: password,
    );
    _connectionFuture = future;

    try {
      await future;
    } finally {
      _connectionFuture = null;
    }
  }

  Future<void> _connect({
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
        _lastIp = ip;
        _lastPort = port;
        _lastPassword = password;

        // Save successfully verified credentials to persistent storage
        try {
          await getIt<PersistancesService>().saveCredentials(
            ip: ip,
            port: port,
            password: password,
          );
        } catch (_) {}

        try {
          await getIt<PersistancesLogsService>().addLog(
            code: 'success',
            message: 'Connected to OBS at ws://$ip:$port',
          );
        } catch (_) {
          await getIt<PersistancesLogsService>().addLog(
            code: 'error',
            message: 'Error persistance credentials.',
          );
        }

        isConnected.value = true;
        statusMessage.value = 'Connected';

        // Subscribe to all OBS events
        await _socket?.subscribe(EventSubscription.all);

        // Fetch initial streaming status
        final initialStreamStatus = await _socket?.stream.status;
        if (initialStreamStatus != null) {
          streamStatus.value = initialStreamStatus.outputActive ? StatusStream.started : StatusStream.stopped;
        }

        // Fetch initial scenes and sources via their respective services
        try {
          await getIt<OBSScenesService>().fetchScenes();
          await getIt<OBSSourcesService>().fetchSources();
          await getIt<OBSSoundService>().detectSoundConfiguration();
          await getIt<OBSSoundService>().getStatusSound();
        } catch (_) {}
      } else {
        throw OBSServerException('SERVER_CANNOT_CONNECTED');
      }
    } on Exception catch (e) {
      isConnected.value = false;
      statusMessage.value = 'Connection failed';
      _socket = null;
      try {
        await getIt<PersistancesLogsService>().addLog(
          code: 'error',
          message: 'Failed to connect to OBS at ws://$ip:$port: $e',
        );
      } catch (_) {}
      if (kDebugMode) {
        print('Message : $e');
      }
      throw OBSServerException(e.toString());
    }
  }

  Future<void> autoConnectOnStartup() async {
    // Only attempt auto-connect if WiFi is active
    if (!getIt<AppLifecycleService>().isWifiConnected.value) {
      if (kDebugMode) {
        print('Skipping auto-connect on startup: No WiFi connection.');
      }
      return;
    }

    final PersistancesService persistances = getIt<PersistancesService>();
    if (persistances.hasCredentials) {
      try {
        statusMessage.value = 'Auto-connecting...';
        try {
          await getIt<PersistancesLogsService>().addLog(
            code: 'info',
            message: 'Attempting auto-connection to OBS',
          );
        } catch (_) {}
        await connect(
          ip: persistances.ip!,
          port: persistances.port!,
          password: persistances.password,
        );
      } catch (e) {
        if (kDebugMode) {
          print('Auto-connection failed on startup: $e. Clearing obsolete credentials.');
        }
        try {
          await getIt<PersistancesLogsService>().addLog(
            code: 'warning',
            message: 'Auto-connection failed. Obsolete credentials cleared.',
          );
        } catch (_) {}
        await persistances.clearCredentials();
        _lastIp = null;
        _lastPort = null;
        _lastPassword = null;
        statusMessage.value = 'Obsolete credentials cleared';
      }
    }
  }

  /// Reconnects to OBS using the cached last used credentials.
  Future<void> reconnect() async {
    final ip = _lastIp;
    final port = _lastPort;
    if (ip != null && port != null) {
      await connect(
        ip: ip,
        port: port,
        password: _lastPassword,
      );
    }
  }

  /// Logs out of the current OBS session and resets all signals.
  Future<void> logout() async {
    try {
      if (_socket != null) {
        await _socket?.close();
        _socket = null;
        try {
          await getIt<PersistancesLogsService>().addLog(
            code: 'info',
            message: 'Successfully logged out from OBS',
          );
        } catch (_) {}
      }
      isConnected.value = false;
      streamStatus.value = StatusStream.stopped;
      getIt<OBSScenesService>().clearScenes();
      getIt<OBSSourcesService>().clearSources();
      getIt<OBSSoundService>().clearSound();
      statusMessage.value = 'Disconnected';
    } on Exception catch (e) {
      isConnected.value = false;
      streamStatus.value = StatusStream.stopped;
      getIt<OBSScenesService>().clearScenes();
      getIt<OBSSourcesService>().clearSources();
      getIt<OBSSoundService>().clearSound();
      statusMessage.value = 'Disconnected';
      _socket = null;
      try {
        await getIt<PersistancesLogsService>().addLog(
          code: 'error',
          message: 'Failed to disconnect cleanly from OBS: $e',
        );
      } catch (_) {}
      throw OBSServerException('SERVER_CANNOT_DISCONNECTED');
    }
  }

  /// Starts streaming in OBS.
  Future<void> startStreaming() async {
    try {
      await _socket?.stream.start();
      streamStatus.value = StatusStream.isStarting;
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
      streamStatus.value = StatusStream.isStopping;
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

    if (event.eventType == 'InputMuteStateChanged') {
      final String? name = event.eventData?['inputName']?.toString();
      if (name == getIt<OBSSoundService>().inputName.value) {
        final bool? isMuted = event.eventData?['inputMuted'] as bool?;
        if (isMuted != null) {
          getIt<OBSSoundService>().activeIsSoundMuted = isMuted;
        }
      }
    }

    if (event.eventType == 'SceneItemEnableStateChanged') {
      await getIt<OBSSourcesService>().fetchSources();
    }

    if (event.eventType == 'StreamStateChanged') {
      final state = event.eventData?['outputState']?.toString();
      if (state == 'OBS_WEBSOCKET_OUTPUT_STARTING') {
        streamStatus.value = StatusStream.isStarting;
      } else if (state == 'OBS_WEBSOCKET_OUTPUT_STARTED') {
        streamStatus.value = StatusStream.started;
        try {
          await WakelockPlus.enable();
        } catch (_) {}
      } else if (state == 'OBS_WEBSOCKET_OUTPUT_STOPPING') {
        streamStatus.value = StatusStream.isStopping;
      } else if (state == 'OBS_WEBSOCKET_OUTPUT_STOPPED') {
        streamStatus.value = StatusStream.stopped;
        try {
          await WakelockPlus.disable();
        } catch (_) {}
      }
    }
  }
}
