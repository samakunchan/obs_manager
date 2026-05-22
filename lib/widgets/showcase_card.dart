import 'package:flutter/material.dart';

/// A custom stylized container displaying component info, featuring gradients and borders.
class ShowcaseCard extends StatelessWidget {
  /// Creates a [ShowcaseCard].
  const ShowcaseCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.child,
    super.key,
  });

  /// The title text of the card.
  final String title;

  /// The leading icon shown next to the title.
  final IconData icon;

  /// Theme accent color of the card.
  final Color color;

  /// Child widget displayed below the header divider.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF16162A),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF2C2C4E), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(color: Color(0xFF2C2C4E), height: 20),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
