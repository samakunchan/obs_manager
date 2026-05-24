import 'package:flutter/material.dart';

class ChamferClipper extends CustomClipper<Path> {
  const ChamferClipper({this.chamferSize = 12.0});

  final double chamferSize;

  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(chamferSize, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - chamferSize)
      ..lineTo(size.width - chamferSize, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, chamferSize)
      ..close();
  }

  @override
  bool shouldReclip(covariant ChamferClipper oldClipper) => oldClipper.chamferSize != chamferSize;
}
