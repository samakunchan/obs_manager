import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_scenes/o_b_s_scenes.dart';
import 'package:obs_manager/features/o_b_s_server/o_b_s_server.dart';
import 'package:obs_manager/features/persistances/persistances.dart';
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

  // Bottom action panel state
  bool _showAudioPanel = false;
  bool _showMonitoringPanel = false;
  bool _showScenesPanel = false;
  final Set<String> _selectedVisibleScenes = <String>{};

  // Animation for pulsing REC red dot
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Pulse animation controller for the recording indicator
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.3, end: 1).animate(_pulseController);

    // Load saved visible scenes from persistent storage
    try {
      final List<String>? savedScenes = getIt<PersistancesScenesService>().visibleScenes;
      if (savedScenes != null) {
        _selectedVisibleScenes.addAll(savedScenes);
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _pulseController.dispose();
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
      final bool liveStreaming = isConnected ? (obsService.streamStatus.value == StatusStream.started) : _isStreaming;

      List<Map<String, dynamic>> scenesList;
      final String activeSceneName;
      final int activeSceneIndex;

      if (isConnected) {
        if (_selectedVisibleScenes.isEmpty && scenesService.scenes.value.isNotEmpty) {
          _selectedVisibleScenes.addAll(
            scenesService.scenes.value.map((s) => s.sceneName),
          );
          try {
            getIt<PersistancesScenesService>().saveVisibleScenes(_selectedVisibleScenes.toList());
          } catch (_) {}
        }

        scenesList = scenesService.scenes.value.map((Scene scene) {
          return {
            'name': scene.sceneName,
            'icon': getIconForScene(scene.sceneName),
          };
        }).toList();

        // Fallback: If cached selection has no overlap with the current scenes, reset and show all.
        final hasOverlap = scenesList.any((s) => _selectedVisibleScenes.contains(s['name']));
        if (!hasOverlap && scenesList.isNotEmpty) {
          _selectedVisibleScenes
            ..clear()
            ..addAll(scenesList.map((s) => s['name'] as String));
          try {
            getIt<PersistancesScenesService>().saveVisibleScenes(_selectedVisibleScenes.toList());
          } catch (_) {}
        }

        scenesList = scenesList.where((s) => _selectedVisibleScenes.contains(s['name'])).toList();

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

            // Bottom Action Bar & Panel stack container
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .stretch,
                children: [
                  if (_showAudioPanel)
                    AudioActionPanel(
                      onClose: () {
                        setState(() {
                          _showAudioPanel = false;
                        });
                      },
                    ),
                  if (_showMonitoringPanel)
                    MonitoringActionPanel(
                      onClose: () {
                        setState(() {
                          _showMonitoringPanel = false;
                        });
                      },
                    ),
                  if (_showScenesPanel)
                    ScenesActionPanel(
                      onClose: () {
                        setState(() {
                          _showScenesPanel = false;
                        });
                      },
                      visibleScenes: _selectedVisibleScenes,
                      onSceneVisibilityChanged: (name, {required isVisible}) {
                        setState(() {
                          if (isVisible) {
                            _selectedVisibleScenes.add(name);
                          } else {
                            if (_selectedVisibleScenes.length > 1) {
                              _selectedVisibleScenes.remove(name);
                            }
                          }
                          // Persist the updated list
                          try {
                            getIt<PersistancesScenesService>().saveVisibleScenes(_selectedVisibleScenes.toList());
                          } catch (_) {}
                        });
                      },
                    ),
                  BottomActionBar(
                    streamStatus: obsService.streamStatus.value,
                    onToggleStream: _toggleStream,
                    isAudioActive: _showAudioPanel,
                    onAudioTap: () {
                      setState(() {
                        _showAudioPanel = !_showAudioPanel;
                        _showMonitoringPanel = false;
                        _showScenesPanel = false;
                      });
                    },
                    isMonitoringActive: _showMonitoringPanel,
                    onMonitoringTap: () {
                      setState(() {
                        _showMonitoringPanel = !_showMonitoringPanel;
                        _showAudioPanel = false;
                        _showScenesPanel = false;
                      });
                    },
                    isScenesActive: _showScenesPanel,
                    onScenesTap: () {
                      setState(() {
                        _showScenesPanel = !_showScenesPanel;
                        _showAudioPanel = false;
                        _showMonitoringPanel = false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
