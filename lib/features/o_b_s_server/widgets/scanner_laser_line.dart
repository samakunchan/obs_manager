import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';

/// A premium animated laser line overlay for the QR Code Scanner.
class ScannerLaserLine extends StatefulWidget {
  const ScannerLaserLine({super.key});

  @override
  State<ScannerLaserLine> createState() => _ScannerLaserLineState();
}

class _ScannerLaserLineState extends State<ScannerLaserLine> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 236).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              color: AppColors.cyberCyan,
              boxShadow: [
                BoxShadow(
                  color: AppColors.cyberCyan.withValues(alpha: 0.8),
                  blurRadius: 8,
                  spreadRadius: 1.5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
