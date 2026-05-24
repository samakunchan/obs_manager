import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_scenes/o_b_s_scenes.dart';
import 'package:obs_manager/features/o_b_s_server/o_b_s_server.dart';
import 'package:obs_manager/pages/main_page/desktop_layout.dart';
import 'package:obs_manager/pages/main_page/mobile_layout.dart';
import 'package:obs_manager/widgets/widgets.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// State-of-the-art OBS Manager Tactile Command Center.
class ObsTactileCommandPage extends StatefulWidget {
  const ObsTactileCommandPage({super.key});

  @override
  State<ObsTactileCommandPage> createState() => _ObsTactileCommandPageState();
}

class _ObsTactileCommandPageState extends State<ObsTactileCommandPage> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Live streaming states
  final bool _isStreaming = false;
  final int _activeSceneIndex = 0;
  final String _activeSceneName = 'STARTING_SOON';

  // Animation for pulsing REC red dot
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // Live Audio VU Meter Values
  double _micDb = -12.4;
  double _bgmDb = -24;
  double _discordDb = -18.2;
  late Timer _vuMeterTimer;

  @override
  void initState() {
    super.initState();

    // Pulse animation controller for the recording indicator
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.3, end: 1).animate(_pulseController);

    // Audio VU Meter dynamic simulation
    final random = math.Random();
    _vuMeterTimer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (mounted) {
        setState(() {
          // Add minor jitter to mic, bgm, and discord db values
          _micDb = -12.4 + (random.nextDouble() - 0.5) * 6;
          _bgmDb = -24 + (random.nextDouble() - 0.5) * 4;
          _discordDb = -18.2 + (random.nextDouble() - 0.5) * 5;

          // Clamping to standard limits
          _micDb = _micDb.clamp(-60.0, 0.0);
          _bgmDb = _bgmDb.clamp(-60.0, 0.0);
          _discordDb = _discordDb.clamp(-60.0, 0.0);
        });
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _vuMeterTimer.cancel();
    super.dispose();
  }

  Future<void> _toggleStream() async {
    final OBSService obsService = getIt<OBSService>();
    if (obsService.isConnected.value) {
      final bool starting = obsService.streamStatus.value != StatusStream.started;
      try {
        if (starting) {
          await obsService.startStreaming();
        } else {
          await obsService.stopStreaming();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.cyberAlertRed,
              content: Text(
                '🛑 ERROR: $e',
                style: GoogleFonts.jetBrainsMono(color: Colors.white, fontWeight: .bold),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.cyberAlertRed,
          content: Text(
            '🚨 OBS IS NOT CONNECTED',
            style: GoogleFonts.jetBrainsMono(color: Colors.white, fontWeight: .bold),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isDesktop = width > 900;
    final OBSService obsService = getIt<OBSService>();
    final OBSScenesService scenesService = getIt<OBSScenesService>();

    return Watch((_) {
      final bool isConnected = obsService.isConnected.value;
      final bool liveStreaming = isConnected
          ? (obsService.streamStatus.value == StatusStream.started || obsService.streamStatus.value == StatusStream.isStarting)
          : _isStreaming;

      final List<Map<String, dynamic>> scenesList;
      final String activeSceneName;
      final int activeSceneIndex;

      if (isConnected) {
        scenesList = scenesService.scenes.value.map((Scene scene) {
          return {
            'name': scene.sceneName,
            'icon': getIconForScene(scene.sceneName),
          };
        }).toList();

        activeSceneName = scenesService.currentScene.value;
        final int index = scenesList.indexWhere((s) => s['name'] == activeSceneName);
        activeSceneIndex = index != -1 ? index : 0;
      } else {
        scenesList = List.empty(growable: true);
        activeSceneName = _activeSceneName;
        activeSceneIndex = _activeSceneIndex;
      }

      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.cyberSurface,
        drawer: const StationDrawer(),
        body: Stack(
          children: [
            /// Cyber Ambient Background Glows
            const CyberBackgroundGlows(),

            /// Main Screen Scaffold Container
            Column(
              children: [
                MissionControlAppBar(
                  isStreaming: liveStreaming,
                  pulseAnimation: _pulseAnimation,
                  onDrawerPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      left: AppDefaultValues.kBorderRadiusPrimary,
                      right: AppDefaultValues.kBorderRadiusPrimary,
                      top: AppDefaultValues.kBorderRadiusTertiary,
                      bottom: 120, // Cushion space for bottom command navigation bar
                    ),
                    child: isDesktop
                        ? DesktopLayout(
                            isConnected: isConnected,
                            scenes: scenesList,
                            activeSceneIndex: activeSceneIndex,
                            activeSceneName: activeSceneName,
                            micDb: _micDb,
                            bgmDb: _bgmDb,
                            discordDb: _discordDb,
                            onSceneSelected: (int index, String name) {
                              if (isConnected) {
                                getIt<OBSScenesService>().changeScene(name);
                              }
                            },
                          )
                        : MobileLayout(
                            isConnected: isConnected,
                            scenes: scenesList,
                            activeSceneIndex: activeSceneIndex,
                            micDb: _micDb,
                            bgmDb: _bgmDb,
                            discordDb: _discordDb,
                            onSceneSelected: (int index, String name) {
                              if (isConnected) {
                                getIt<OBSScenesService>().changeScene(name);
                              }
                            },
                          ),
                  ),
                ),
              ],
            ),

            // Bottom Action Bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomActionBar(
                streamStatus: obsService.streamStatus.value,
                onToggleStream: _toggleStream,
              ),
            ),
          ],
        ),
      );
    });
  }
}
