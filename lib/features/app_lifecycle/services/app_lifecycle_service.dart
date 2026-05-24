import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:obs_manager/features/o_b_s_server/services/services.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AppLifecycleService with WidgetsBindingObserver {
  late final StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();

  /// Reactive state signals
  final Signal<bool> isWifiConnected = signal<bool>(true);
  final Signal<bool> isReconnecting = signal<bool>(false);

  /// Initializes listeners for lifecycle changes and WiFi connectivity.
  void init() {
    WidgetsBinding.instance.addObserver(this);
    _checkInitialConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Cleans up listeners.
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectivitySubscription.cancel();
  }

  /// Manually checks WiFi connectivity.
  Future<void> checkConnectivity() async {
    try {
      final List<ConnectivityResult> results = await _connectivity.checkConnectivity();
      _updateConnectionStatus(results);
    } catch (_) {}
  }

  Future<void> _checkInitialConnectivity() async {
    try {
      final List<ConnectivityResult> results = await _connectivity.checkConnectivity();
      _updateConnectionStatus(results);
    } catch (_) {}
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    // Check if connected specifically to WiFi
    final bool hasWifi = results.contains(ConnectivityResult.wifi);
    isWifiConnected.value = hasWifi;

    final OBSService obsService = getIt<OBSService>();
    if (!hasWifi) {
      // Automatically disconnect from OBS when WiFi is lost
      if (obsService.isConnected.value) {
        obsService.logout();
      }
    } else {
      // Automatically attempt to reconnect to OBS when WiFi is restored
      if (!obsService.isConnected.value) {
        isReconnecting.value = true;
        obsService.reconnect().then((_) {
          isReconnecting.value = false;
        }).catchError((_) {
          isReconnecting.value = false;
        });
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final OBSService obsService = getIt<OBSService>();

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        // Automatically disconnect from OBS when app is hidden/paused
        if (obsService.isConnected.value) {
          obsService.logout();
        }
      case AppLifecycleState.resumed:
        // Automatically attempt to reconnect to OBS on resume
        if (!obsService.isConnected.value && isWifiConnected.value) {
          obsService.reconnect();
        }
    }
  }
}
