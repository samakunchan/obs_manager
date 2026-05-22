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
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              spacing: 8,
              children: [
                Icon(icon, color: color, size: 20),
                Text(title, style: theme.textTheme.titleMedium),
              ],
            ),
            const Divider(height: 20),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
