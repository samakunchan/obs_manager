import 'package:flutter/material.dart';

/// Custom painter to draw a continuous stroke around the chamfered path.
class ChamferBorderPainter extends CustomPainter {
  const ChamferBorderPainter({
    required this.color,
    this.chamferSize = 12.0,
    this.strokeWidth = 1.5,
  });

  final double chamferSize;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Path path = Path()
      ..moveTo(chamferSize, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - chamferSize)
      ..lineTo(size.width - chamferSize, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, chamferSize)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ChamferBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.chamferSize != chamferSize || oldDelegate.strokeWidth != strokeWidth;
}
