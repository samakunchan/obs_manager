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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            keyName,
            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
