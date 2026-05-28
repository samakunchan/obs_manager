import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_server/widgets/scanner_laser_line.dart';

/// Self-contained QR Code camera preview and scanner console widget.
class ConnectToOBSScannerView extends StatefulWidget {
  const ConnectToOBSScannerView({
    required this.onDetect,
    required this.onCancelPressed,
    this.errorLog,
    super.key,
  });

  final void Function(BarcodeCapture barcodes) onDetect;
  final VoidCallback onCancelPressed;
  final String? errorLog;

  @override
  State<ConnectToOBSScannerView> createState() => _ConnectToOBSScannerViewState();
}

class _ConnectToOBSScannerViewState extends State<ConnectToOBSScannerView> {
  final MobileScannerController _scannerController = MobileScannerController(autoStart: false);

  @override
  void initState() {
    super.initState();
    // Start camera immediately when the view is mounted
    unawaited(_scannerController.start());
  }

  @override
  void dispose() {
    // Stop and release camera when the view is unmounted
    unawaited(_scannerController.stop());
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('scanner_view'),
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        /// Header block
        Row(
          spacing: 12,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.cyberCyan.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.cyberCyan),
              ),
              child: const Icon(Icons.qr_code_scanner, color: AppColors.cyberCyan, size: 20),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                spacing: 2,
                children: [
                  Text(
                    context.localization.qrCodeScanner.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 20,
                      color: AppColors.cyberCyan,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    context.localization.alignObsConsoleQrCode.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 9,
                      fontWeight: .bold,
                      color: AppColors.cyberTextMuted,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.cyberTextMuted, size: 20),
              onPressed: widget.onCancelPressed,
            ),
          ],
        ),
        const SizedBox(height: 24),

        /// Live camera viewer box with animated cyber grid overlays
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.cyberCyan, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  MobileScanner(
                    controller: _scannerController,
                    onDetect: widget.onDetect,
                  ),

                  /// Shadowed vignette grid margins
                  IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.surfaceContainerLow.withValues(alpha: 0.5),
                          width: 12,
                        ),
                      ),
                    ),
                  ),

                  /// Scanning Neon laser animation
                  const Positioned(
                    top: 12,
                    left: 24,
                    right: 24,
                    child: ScannerLaserLine(),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        /// Console real-time log updates
        if (widget.errorLog != null)
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.cyberAlertRed.withValues(alpha: 0.5)),
            ),
            child: Text(
              widget.errorLog!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 10,
                height: 1.4,
                color: AppColors.cyberAlertRed,
                fontWeight: .bold,
              ),
            ),
          ),

        /// Abort Scanning Button
        OutlinedButton.icon(
          onPressed: widget.onCancelPressed,
          icon: const Icon(Icons.keyboard, size: 16),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.cyberTextMuted.withValues(alpha: 0.5)),
            foregroundColor: AppColors.cyberTextLight,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          label: Text(
            context.localization.enterManually.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11, fontWeight: .bold, letterSpacing: 1),
          ),
        ),
      ],
    );
  }
}
