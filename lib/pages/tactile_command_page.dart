import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/widgets/widgets.dart';

/// State-of-the-art OBS Manager Tactile Command Center.
class ObsTactileCommandPage extends StatefulWidget {
  const ObsTactileCommandPage({super.key});

  @override
  State<ObsTactileCommandPage> createState() => _ObsTactileCommandPageState();
}

class _ObsTactileCommandPageState extends State<ObsTactileCommandPage> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Live streaming states
  bool _isStreaming = false;
  int _activeSceneIndex = 0;
  String _activeSceneName = 'STARTING_SOON';

  // Animation for pulsing REC red dot
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // Live Audio VU Meter Values
  double _micDb = -12.4;
  double _bgmDb = -24;
  double _discordDb = -18.2;
  late Timer _vuMeterTimer;

  // Preset scene list mirroring the mockup
  final List<Map<String, dynamic>> _scenes = [
    {
      'name': 'STARTING_SOON',
      'icon': Icons.grid_view,
    },
    {
      'name': 'FULL_CAM',
      'icon': Icons.person,
    },
    {
      'name': 'GAMEPLAY_ULTRA',
      'icon': Icons.desktop_windows,
    },
    {
      'name': 'INTERMISSION',
      'icon': Icons.chat,
    },
    {
      'name': 'GUEST_SPLIT',
      'icon': Icons.group,
    },
    {
      'name': 'BE_RIGHT_BACK',
      'icon': Icons.videocam_off,
    },
  ];

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

  void _toggleStream() {
    setState(() {
      _isStreaming = !_isStreaming;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _isStreaming ? AppColors.successColor : AppColors.cyberAlertRed,
        content: Text(
          _isStreaming ? '🚨 LIVE BROADCAST INITIALIZED' : '🛑 BROADCAST TERMINATED',
          style: GoogleFonts.jetBrainsMono(
            color: Colors.white,
            fontWeight: .bold,
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isDesktop = width > 900;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.cyberSurface,
      drawer: const StationDrawer(),
      body: Stack(
        children: [
          // Cyber Ambient Background Glows
          const CyberBackgroundGlows(),

          // Main Screen Scaffold Container
          Column(
            children: [
              MissionControlAppBar(
                isStreaming: _isStreaming,
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
                  child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
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
              isStreaming: _isStreaming,
              onToggleStream: _toggleStream,
            ),
          ),
        ],
      ),
    );
  }

  // Widescreen Split Panel Layout
  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: .start,
      spacing: 24,
      children: [
        // Left Area: Scene selector and main preview
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              ScenesHeader(presetsCount: _scenes.length),
              const SizedBox(height: 12),
              ScenesGrid(
                scenes: _scenes,
                activeSceneIndex: _activeSceneIndex,
                crossAxisCount: 3,
                onSceneSelected: (int index, String name) {
                  setState(() {
                    _activeSceneIndex = index;
                    _activeSceneName = name;
                  });
                },
              ),
              const SizedBox(height: 24),
              PreviewMonitor(activeSceneName: _activeSceneName),
            ],
          ),
        ),
        // Right Area: Audio sliders and active sources
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              AudioMixPanel(micDb: _micDb, bgmDb: _bgmDb, discordDb: _discordDb),
              const SizedBox(height: 24),
              const SourcesPanel(),
            ],
          ),
        ),
      ],
    );
  }

  // Vertical Mobile Stacking Layout
  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: .start,
      children: [
        ScenesHeader(presetsCount: _scenes.length),
        const SizedBox(height: 12),
        ScenesGrid(
          scenes: _scenes,
          activeSceneIndex: _activeSceneIndex,
          crossAxisCount: 2,
          onSceneSelected: (index, name) {
            setState(() {
              _activeSceneIndex = index;
              _activeSceneName = name;
            });
          },
        ),
        // const SizedBox(height: 20),
        // PreviewMonitor(activeSceneName: _activeSceneName),
        const SizedBox(height: 20),
        const SourcesPanel(),
        const SizedBox(height: 20),
        AudioMixPanel(micDb: _micDb, bgmDb: _bgmDb, discordDb: _discordDb),
      ],
    );
  }
}
