import 'package:flutter/material.dart';

/// A custom button widget representing a language choice option using ChoiceChip.
class LanguageButton extends StatelessWidget {
  /// Creates a [LanguageButton].
  const LanguageButton({
    required this.code,
    required this.label,
    required this.isSelected,
    required this.onSelected,
    super.key,
  });

  /// The language code (e.g. 'en', 'fr').
  final String code;

  /// The human-readable label (e.g. '🇺🇸 English').
  final String label;

  /// Whether this language button is currently selected.
  final bool isSelected;

  /// Callback when the selection state changes.
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: onSelected,
        selectedColor: const Color(0xFF4F46E5),
        backgroundColor: const Color(0xFF1E1E38),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.grey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
