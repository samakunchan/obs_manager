import 'package:flutter/material.dart';

/// Custom painter to draw a continuous stroke around the chamfered path.
class ChamferBorderPainter extends CustomPainter {
  const ChamferBorderPainter({
    required this.color,
    this.chamferSize = 12.0,
    this.strokeWidth = 1.5,
    this.elevation = 0.0,
    this.mode = .dark,
    this.isActive = false,
  });

  final double chamferSize;
  final Color color;
  final double strokeWidth;
  final double elevation;
  final Brightness mode;
  final bool isActive;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path()
      ..moveTo(chamferSize, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - chamferSize)
      ..lineTo(size.width - chamferSize, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, chamferSize)
      ..close();

    if (elevation > 0) {
      canvas.drawShadow(
        path,
        Colors.black.withAlpha(80),
        elevation,
        true,
      );
    }

    final Paint paint = Paint()
      ..color = color
      ..style = mode == .light && isActive ? .fill : .stroke
      ..strokeWidth = strokeWidth;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ChamferBorderPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.chamferSize != chamferSize ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.elevation != elevation;
}
