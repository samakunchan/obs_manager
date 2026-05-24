import 'package:flutter/material.dart';
import 'package:obs_manager/features/app_lifecycle/app_lifecycle.dart';
import 'package:obs_manager/features/o_b_s_server/services/dependency_injection.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// A gate widget that monitors WiFi connectivity reactively.
/// If WiFi is connected, the [child] is displayed.
/// Otherwise, the screen is blocked with a high-fidelity [NoWifiScreen].
/// During auto-reconnection, shows the [ReconnectingScreen] loading transition.
class AppLifecycleGate extends StatelessWidget {
  const AppLifecycleGate({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final AppLifecycleService service = getIt<AppLifecycleService>();
      final bool isWifi = service.isWifiConnected.value;
      final bool isReconnecting = service.isReconnecting.value;

      if (!isWifi) {
        return const NoWifiScreen();
      }

      if (isReconnecting) {
        return const ReconnectingScreen();
      }

      return child;
    });
  }
}
