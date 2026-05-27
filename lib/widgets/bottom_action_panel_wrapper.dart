import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';

/// A reusable, premium glassmorphic wrapper for overlays positioned just above the BottomActionBar.
/// Features a smooth size/fade entrance transition, customizable glow theme, and header close control.
class BottomActionPanelWrapper extends StatefulWidget {
  const BottomActionPanelWrapper({
    required this.title,
    required this.child,
    required this.onClose,
    this.glowColor = AppColors.cyberCyan,
    this.leadingHeader,
    this.trailingHeader,
    super.key,
  });

  /// The header title of the panel.
  final String title;

  /// The inner widget content of the panel.
  final Widget child;

  /// Callback triggered after the slide-down close animation finishes.
  final VoidCallback onClose;

  /// The neon cyber glow theme color of this panel. Defaults to AppColors.cyberCyan.
  final Color glowColor;

  /// Optional leading widget next to the title (e.g., status indicator, icon).
  final Widget? leadingHeader;

  /// Optional trailing widget in the header (e.g. action buttons).
  final Widget? trailingHeader;

  @override
  State<BottomActionPanelWrapper> createState() => _BottomActionPanelWrapperState();
}

class _BottomActionPanelWrapperState extends State<BottomActionPanelWrapper> with SingleTickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    );
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _animateClose() async {
    await _slideController.reverse();
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _slideAnimation,
      axisAlignment: -1,
      child: FadeTransition(
        opacity: _slideAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cyberSurfaceContainer.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(AppDefaultValues.kBorderRadiusSecondary),
            border: Border.all(
              color: widget.glowColor.withValues(alpha: 0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withValues(alpha: 0.15),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            children: [
              /// Header Row
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  /// Text header
                  Row(
                    children: [
                      if (widget.leadingHeader != null) ...[
                        widget.leadingHeader!,
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.title.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 14,
                          letterSpacing: 1.1,
                          color: widget.glowColor,
                        ),
                        overflow: .ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: .min,
                    children: [
                      /// Clear logs
                      if (widget.trailingHeader != null) ...[
                        widget.trailingHeader!,
                        // const SizedBox(width: 12),
                      ],

                      /// Close panel
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.cyberTextMuted, size: 20),
                        onPressed: _animateClose,
                        padding: .zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              /// Body content
              widget.child,
            ],
          ),
        ),
      ),
    );
  }
}
