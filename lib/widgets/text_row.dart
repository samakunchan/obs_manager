import 'package:flutter/material.dart';

/// A simple row showing a localized translation next to its key name in monospace.
class TextRow extends StatelessWidget {
  /// Creates a [TextRow].
  const TextRow({
    required this.value,
    required this.keyName,
    super.key,
  });

  /// The localized translation value.
  final String value;

  /// The technical string key identifier.
  final String keyName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(value, style: theme.textTheme.bodyMedium, overflow: .ellipsis),
          ),
          Text(keyName, style: theme.textTheme.labelSmall),
        ],
      ),
    );
  }
}
