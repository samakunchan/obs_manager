import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_scenes/o_b_s_scenes.dart';
import 'package:obs_manager/features/o_b_s_server/o_b_s_server.dart';
import 'package:obs_manager/features/o_b_s_sound/o_b_s_sound.dart';
import 'package:obs_manager/widgets/widgets.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// Monitoring Bottom Action Panel displaying connection Metadata and live Event Logs inside the ShowcaseCard.
class MonitoringActionPanel extends StatefulWidget {
  const MonitoringActionPanel({required this.onClose, super.key});

  final VoidCallback onClose;

  @override
  State<MonitoringActionPanel> createState() => _MonitoringActionPanelState();
}

class _MonitoringActionPanelState extends State<MonitoringActionPanel> {
  final List<String> _logs = [];
  final ScrollController _scrollController = ScrollController();

  // Signal dispose callbacks
  late final void Function() _disposeConnected;
  late final void Function() _disposeStream;
  late final void Function() _disposeScene;
  late final void Function() _disposeMute;

  @override
  void initState() {
    super.initState();
    _addLog('System ready. Diagnostic terminal listening.');

    final obsService = getIt<OBSService>();
    final scenesService = getIt<OBSScenesService>();
    final soundService = getIt<OBSSoundService>();

    // Initial logs based on current state
    if (obsService.isConnected.value) {
      _addLog('OBS Session: ACTIVE');
      _addLog('Initial Scene: ${scenesService.currentScene.value}');
      _addLog('Audio Input: ${soundService.inputName.value} (${soundService.isSoundMuted.value ? 'MUTED' : 'ACTIVE'})');
    } else {
      _addLog('OBS Session: OFFLINE');
    }

    // Set up reactive signal effects to record stream events on change
    bool initialConnected = true;
    _disposeConnected = effect(() {
      final isConnected = obsService.isConnected.value;
      if (initialConnected) {
        initialConnected = false;
        return;
      }
      _addLog('Connection status changed: ${isConnected ? 'CONNECTED' : 'DISCONNECTED'}');
    });

    bool initialStream = true;
    _disposeStream = effect(() {
      final status = obsService.streamStatus.value;
      if (initialStream) {
        initialStream = false;
        return;
      }
      _addLog('Stream state updated: ${status.name.toUpperCase()}');
    });

    bool initialScene = true;
    _disposeScene = effect(() {
      final scene = scenesService.currentScene.value;
      if (initialScene) {
        initialScene = false;
        return;
      }
      if (scene.isNotEmpty) {
        _addLog('Program Scene active: $scene');
      }
    });

    bool initialMute = true;
    _disposeMute = effect(() {
      final isMuted = soundService.isSoundMuted.value;
      if (initialMute) {
        initialMute = false;
        return;
      }
      _addLog('Microphone state changed: ${isMuted ? 'MUTED 🛑' : 'LIVE 🎙️'}');
    });
  }

  @override
  void dispose() {
    _disposeConnected();
    _disposeStream();
    _disposeScene();
    _disposeMute();
    _scrollController.dispose();
    super.dispose();
  }

  void _addLog(String message) {
    if (!mounted) return;
    final time = _getTimestamp();
    setState(() {
      _logs.add('[$time] $message');
      // Limit to last 50 logs for memory performance
      if (_logs.length > 50) {
        _logs.removeAt(0);
      }
    });

    // Auto-scroll terminal to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getTimestamp() {
    final now = DateTime.now();
    final h = now.hour.toString().padLeft(2, '0');
    final m = now.minute.toString().padLeft(2, '0');
    final s = now.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final obsService = getIt<OBSService>();
    final scenesService = getIt<OBSScenesService>();
    final soundService = getIt<OBSSoundService>();

    return Watch((_) {
      final isConnected = obsService.isConnected.value;
      final sceneName = scenesService.currentScene.value;
      final micName = soundService.inputName.value;
      final isMuted = soundService.isSoundMuted.value;
      final streamStateName = obsService.streamStatus.value.name.toUpperCase();

      return BottomActionPanelWrapper(
        title: 'SYSTEM LOGS & METADATA',
        onClose: widget.onClose,
        glowColor: AppColors.accent,
        leadingHeader: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isConnected ? AppColors.accent : AppColors.cyberTextMuted,
            boxShadow: [
              if (isConnected)
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.6),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
            ],
          ),
        ),
        child: SizedBox(
          height: 200, // Constrained height for ShowcaseCard content
          child: ShowcaseCard(
            title: 'Broadcaster Terminal Logs',
            icon: Icons.terminal_rounded,
            color: AppColors.accent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Left Column: Metadata Listing
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildMetadataItem('OBS SOCKET', isConnected ? '127.0.0.1:4455' : 'OFFLINE'),
                      _buildMetadataItem('ACTIVE SCENE', isConnected ? sceneName : 'NONE'),
                      _buildMetadataItem('AUDIO SOURCE', isConnected ? micName : 'NONE'),
                      _buildMetadataItem('AUDIO STATE', isConnected ? (isMuted ? 'MUTED' : 'LIVE') : 'OFFLINE'),
                      _buildMetadataItem('STREAM STATE', streamStateName),
                    ],
                  ),
                ),
                const VerticalDivider(width: 24, thickness: 1, color: Color(0x1FFFFFFF)),

                /// Right Column: Interactive Logs terminal matching my_home_page.dart
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Container(
                      height: 120,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkTerminalBg
                            : AppColors.lightTerminalBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.darkTerminalBorder
                              : AppColors.lightTerminalBorder,
                          width: 1.5,
                        ),
                      ),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _logs.join('\n'),
                            style: kTerminalTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildMetadataItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.barlowCondensed(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: AppColors.cyberTextMuted,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          value,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppColors.cyberTextLight,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
