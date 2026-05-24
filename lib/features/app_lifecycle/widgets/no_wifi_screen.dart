import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/app_lifecycle/services/services.dart';
import 'package:obs_manager/features/o_b_s_server/services/dependency_injection.dart';
import 'package:obs_manager/widgets/widgets.dart';

/// A premium, highly polished full-screen warning page displayed when
/// the device has no active WiFi connection.
class NoWifiScreen extends StatefulWidget {
  const NoWifiScreen({super.key});

  @override
  State<NoWifiScreen> createState() => _NoWifiScreenState();
}

class _NoWifiScreenState extends State<NoWifiScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.4, end: 1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _handleRetry() async {
    if (_isChecking) return;
    setState(() => _isChecking = true);

    /// Minor visual delay for the "system scanning" effect
    await Future<void>.delayed(const Duration(milliseconds: 800));
    await getIt<AppLifecycleService>().checkConnectivity();

    if (mounted) {
      setState(() => _isChecking = false);
    }
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
                  /// Pulsing Red Icon Shield Glow
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (_, _) {
                        return Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.cyberAlertRed.withAlpha((20 * _pulseAnimation.value).toInt()),
                            border: Border.all(
                              color: AppColors.cyberAlertRed.withAlpha((100 * _pulseAnimation.value).toInt()),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.cyberAlertRed.withAlpha((40 * _pulseAnimation.value).toInt()),
                                blurRadius: 30 * _pulseAnimation.value,
                                spreadRadius: 5 * _pulseAnimation.value,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.wifi_off_rounded,
                            size: 72,
                            color: AppColors.cyberAlertRed,
                          ),
                        );
                      },
                    ),
                  ),

                  /// Monospace System Text
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'SYSTEM OFFLINE',
                      style: GoogleFonts.barlowCondensed(
                        fontSize: 32,
                        fontWeight: .bold,
                        letterSpacing: 2,
                        color: AppColors.cyberAlertRed,
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.cyberAlertRed,
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),

                  /// Detailed descriptive message
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      'A local WiFi network connection is required to communicate with the OBS Broadcaster Studio over local WebSocket.\n\nPlease check your system settings and connect to WiFi.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.jetBrainsMono(
                        color: AppColors.cyberTextMuted,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                  ),

                  /// Cyber Scan Action Button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: SizedBox(
                      width: 240,
                      child: OutlinedButton(
                        onPressed: _isChecking ? null : _handleRetry,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: _isChecking ? AppColors.cyberTextMuted.withAlpha(80) : AppColors.cyberAlertRed,
                            width: 1.5,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: .center,
                          spacing: 10,
                          children: [
                            if (_isChecking)
                              const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.cyberAlertRed),
                                ),
                              )
                            else
                              const Icon(
                                Icons.sync_rounded,
                                color: AppColors.cyberAlertRed,
                                size: 18,
                              ),
                            Text(
                              _isChecking ? 'SCANNING SYSTEM...' : 'RESCAN CONNECTION',
                              style: GoogleFonts.jetBrainsMono(
                                color: _isChecking ? AppColors.cyberTextMuted : AppColors.cyberAlertRed,
                                fontWeight: .bold,
                                fontSize: 12,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
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
