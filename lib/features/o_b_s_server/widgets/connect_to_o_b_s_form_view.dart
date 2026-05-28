import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Theme.of(context).colorScheme.secondary),
                ),
                child: Icon(Icons.settings_input_component, size: 20),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 2,
                  children: [
                    Text(
                      context.localization.connectionConsole.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.secondary,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      context.localization.obsWebsocketV5Configuration.toUpperCase(),
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
                icon: const Icon(Icons.close, size: 20),
                onPressed: widget.onCancelPressed,
              ),
            ],
          ),
          const SizedBox(height: 20),

          /// Connection IP Input
          TextFormField(
            controller: widget.ipController,
            cursorColor: Theme.of(context).colorScheme.secondary,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: _buildInputDecoration(
              label: context.localization.obsWebSocketIp.toUpperCase(),
              hint: 'e.g., 192.xxx.x.xxx',
              prefixIcon: Icons.leak_add,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return context.localization.ipRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          /// Connection Port Input
          TextFormField(
            controller: widget.portController,
            cursorColor: Theme.of(context).colorScheme.secondary,
            style: Theme.of(context).textTheme.bodyMedium,
            keyboardType: .number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: _buildInputDecoration(
              label: context.localization.obsWebSocketPort.toUpperCase(),
              hint: 'e.g., 1122',
              prefixIcon: Icons.developer_board,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return context.localization.portRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          /// Connection Password Input
          TextFormField(
            controller: widget.passwordController,
            cursorColor: AppColors.cyberCyan,
            style: Theme.of(context).textTheme.bodyMedium,
            obscureText: _obscurePassword,
            decoration: _buildInputDecoration(
              label: context.localization.obsAuthenticationKey.toUpperCase(),
              hint: context.localization.obsPassword,
              prefixIcon: Icons.key,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
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
                context.localization.orConnectViaQrCode.toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                  color: Theme.of(context).colorScheme.surfaceContainerLowest,
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
                      context.localization.scanQr.toUpperCase(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: widget.errorLog != null
                      ? AppColors.cyberAlertRed.withValues(alpha: 0.5)
                      : AppColors.cyberCyan.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                widget.errorLog ?? widget.statusLog!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                  height: 1.4,
                  color: widget.errorLog != null ? AppColors.cyberAlertRed : AppColors.terminalText,
                  fontWeight: .bold,
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
                    context.localization.cancel.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.isConnecting ? null : widget.onConnectPressed,
                  style: ElevatedButton.styleFrom(
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
                          context.localization.connect.toUpperCase(),
                          style: Theme.of(context).textTheme.bodySmall,
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
    final textTheme = Theme.of(context).textTheme;
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(prefixIcon, color: Theme.of(context).colorScheme.secondary, size: 18),
      suffixIcon: suffixIcon,
      labelStyle: textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.secondary, fontSize: 10, fontWeight: .bold),
      hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.cyberTextMuted.withValues(alpha: 0.5), fontSize: 12),
      floatingLabelStyle: textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 11,
        fontWeight: .bold,
      ),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.cyberTextMuted.withValues(alpha: 0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 1.5),
      ),
      errorStyle: textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.error, fontSize: 10, fontWeight: .bold),
    );
  }
}
