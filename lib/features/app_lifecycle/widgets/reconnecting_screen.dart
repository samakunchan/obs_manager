import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/widgets/widgets.dart';

/// A premium, highly polished loading screen displayed while the application
/// is automatically reconnecting to the OBS Studio WebSocket.
class ReconnectingScreen extends StatefulWidget {
  const ReconnectingScreen({super.key});

  @override
  State<ReconnectingScreen> createState() => _ReconnectingScreenState();
}

class _ReconnectingScreenState extends State<ReconnectingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cyberSurface,
      body: Stack(
        children: [
          const CyberBackgroundGlows(),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  /// Glowing Neon Cyan Scanner / Loading Indicator
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (_, _) {
                        return Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.cyberCyan.withAlpha((15 * _pulseAnimation.value).toInt()),
                            border: Border.all(
                              color: AppColors.cyberCyan.withAlpha((100 * _pulseAnimation.value).toInt()),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.cyberCyan.withAlpha((30 * _pulseAnimation.value).toInt()),
                                blurRadius: 25 * _pulseAnimation.value,
                                spreadRadius: 4 * _pulseAnimation.value,
                              ),
                            ],
                          ),
                          child: const SizedBox(
                            width: 48,
                            height: 48,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.cyberCyan),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  /// Monospace System Text
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'LINK RESTORATION',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 32,
                        letterSpacing: 2,
                        color: AppColors.cyberCyan,
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.cyberCyan,
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),

                  /// Description of automatic reconnection
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      'WiFi network connection detected.\n\nRe-establishing secure local WebSocket links and synchronizing scene pipelines with OBS Studio...',
                      textAlign: .center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.cyberTextMuted,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
