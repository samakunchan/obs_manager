import 'package:flutter/material.dart';

/// Cyber Ambient Background Glows layered inside pages
class CyberBackgroundGlows extends StatelessWidget {
  const CyberBackgroundGlows({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: .expand,
      children: [
        Positioned(
          top: -250,
          right: -250,
          child: Container(
            width: 600,
            height: 600,
            decoration: const BoxDecoration(shape: .circle, color: Color(0x0C00E5FF)),
          ),
        ),
        Positioned(
          bottom: -200,
          left: -200,
          child: Container(
            width: 500,
            height: 500,
            decoration: const BoxDecoration(shape: .circle, color: Color(0x0975D1FF)),
          ),
        ),
      ],
    );
  }
}
