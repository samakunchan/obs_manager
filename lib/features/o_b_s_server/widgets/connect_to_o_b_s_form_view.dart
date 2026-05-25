import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_manager/core/index.dart';

/// manual credentials connection form widget.
class ConnectToOBSFormView extends StatefulWidget {
  const ConnectToOBSFormView({
    required this.formKey,
    required this.ipController,
    required this.portController,
    required this.passwordController,
    required this.isConnecting,
    required this.onConnectPressed,
    required this.onCancelPressed,
    required this.onScanPressed,
    this.statusLog,
    this.errorLog,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController ipController;
  final TextEditingController portController;
  final TextEditingController passwordController;
  final bool isConnecting;
  final VoidCallback onConnectPressed;
  final VoidCallback onCancelPressed;
  final VoidCallback onScanPressed;
  final String? statusLog;
  final String? errorLog;

  @override
  State<ConnectToOBSFormView> createState() => _ConnectToOBSFormViewState();
}

class _ConnectToOBSFormViewState extends State<ConnectToOBSFormView> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        key: const ValueKey('form_view'),
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          /// Dialog Title Header with terminal vibe
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
                child: const Icon(Icons.settings_input_component, color: AppColors.cyberCyan, size: 20),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 2,
                  children: [
                    Text(
                      'CONNECTION_CONSOLE',
                      style: GoogleFonts.barlowCondensed(
                        fontSize: 20,
                        fontWeight: .bold,
                        color: AppColors.cyberCyan,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      'OBS WEBSOCKET V5 CONFIGURATION',
                      style: GoogleFonts.jetBrainsMono(
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
          const SizedBox(height: 20),

          /// Connection IP Input
          TextFormField(
            controller: widget.ipController,
            cursorColor: AppColors.cyberCyan,
            style: GoogleFonts.jetBrainsMono(color: AppColors.cyberTextLight, fontSize: 13),
            decoration: _buildInputDecoration(
              label: 'OBS WEB SOCKET I.P.',
              hint: 'e.g., 192.168.0.140',
              prefixIcon: Icons.leak_add,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'IP address is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          /// Connection Port Input
          TextFormField(
            controller: widget.portController,
            cursorColor: AppColors.cyberCyan,
            style: GoogleFonts.jetBrainsMono(color: AppColors.cyberTextLight, fontSize: 13),
            keyboardType: .number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: _buildInputDecoration(
              label: 'OBS WEB SOCKET PORT',
              hint: 'e.g., 4456',
              prefixIcon: Icons.developer_board,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Port is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          /// Connection Password Input
          TextFormField(
            controller: widget.passwordController,
            cursorColor: AppColors.cyberCyan,
            style: GoogleFonts.jetBrainsMono(color: AppColors.cyberTextLight, fontSize: 13),
            obscureText: _obscurePassword,
            decoration: _buildInputDecoration(
              label: 'OBS AUTHENTICATION KEY',
              hint: 'OBS password',
              prefixIcon: Icons.key,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.cyberTextMuted,
                  size: 18,
                ),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
          ),
          const SizedBox(height: 16),

          /// OR QR CODE divider
          Row(
            spacing: 10,
            children: [
              const Expanded(child: Divider(color: AppColors.darkCardBorder)),
              Text(
                'OR CONNECT VIA QR CODE',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 9,
                  fontWeight: .bold,
                  color: AppColors.cyberTextMuted,
                ),
              ),
              const Expanded(child: Divider(color: AppColors.darkCardBorder)),
            ],
          ),
          const SizedBox(height: 12),

          /// Sleek square button styled to resemble a digital QR Code card
          Center(
            child: InkWell(
              onTap: widget.onScanPressed,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.cyberSurfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.cyberCyan.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cyberCyan.withValues(alpha: 0.05),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: .center,
                  spacing: 6,
                  children: [
                    const Icon(
                      Icons.qr_code_scanner,
                      color: AppColors.cyberCyan,
                      size: 36,
                    ),
                    Text(
                      'SCAN QR',
                      style: GoogleFonts.jetBrainsMono(
                        color: AppColors.cyberCyan,
                        fontSize: 8,
                        fontWeight: .bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          /// Monospace Real-time status logs (Cyber Console feel)
          if (widget.statusLog != null || widget.errorLog != null)
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.cyberSurfaceContainerLowest,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: widget.errorLog != null
                      ? AppColors.cyberAlertRed.withValues(alpha: 0.5)
                      : AppColors.cyberCyan.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                widget.errorLog ?? widget.statusLog!,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  height: 1.4,
                  color: widget.errorLog != null ? AppColors.cyberAlertRed : AppColors.terminalText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          /// Actions (Connect / Close)
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.isConnecting ? null : widget.onCancelPressed,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.cyberTextMuted.withValues(alpha: 0.5)),
                    foregroundColor: AppColors.cyberTextLight,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    'CANCEL',
                    style: GoogleFonts.jetBrainsMono(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.isConnecting ? null : widget.onConnectPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cyberCyan,
                    foregroundColor: AppColors.cyberSurface,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    disabledBackgroundColor: AppColors.cyberCyan.withValues(alpha: 0.3),
                  ),
                  child: widget.isConnecting
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.cyberSurface),
                          ),
                        )
                      : Text(
                          'CONNECT',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String label,
    required String hint,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(prefixIcon, color: AppColors.cyberTextMuted, size: 18),
      suffixIcon: suffixIcon,
      labelStyle: GoogleFonts.jetBrainsMono(color: AppColors.cyberTextMuted, fontSize: 10, fontWeight: FontWeight.bold),
      hintStyle: GoogleFonts.jetBrainsMono(color: AppColors.cyberTextMuted.withValues(alpha: 0.5), fontSize: 12),
      floatingLabelStyle: GoogleFonts.jetBrainsMono(color: AppColors.cyberCyan, fontSize: 11, fontWeight: FontWeight.bold),
      filled: true,
      fillColor: AppColors.cyberSurfaceContainerLowest,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.cyberTextMuted.withValues(alpha: 0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.cyberCyan, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.cyberAlertRed),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.cyberAlertRed, width: 1.5),
      ),
      errorStyle: GoogleFonts.jetBrainsMono(color: AppColors.cyberAlertRed, fontSize: 10, fontWeight: FontWeight.bold),
    );
  }
}
