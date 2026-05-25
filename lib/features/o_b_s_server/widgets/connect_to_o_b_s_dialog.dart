import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_server/services/services.dart';
import 'package:obs_manager/features/o_b_s_server/widgets/connect_to_o_b_s_form_view.dart';
import 'package:obs_manager/features/o_b_s_server/widgets/connect_to_o_b_s_scanner_view.dart';
import 'package:obs_manager/features/persistances/persistances.dart';

/// State-of-the-art Cyber-themed OBS WebSocket Connection Console Dialog.
/// Orchestrates manual form inputs and QR Code scanner views.
class ConnectToOBSDialog extends StatefulWidget {
  const ConnectToOBSDialog({super.key});

  @override
  State<ConnectToOBSDialog> createState() => _ConnectToOBSDialogState();
}

class _ConnectToOBSDialogState extends State<ConnectToOBSDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _ipController;
  late final TextEditingController _portController;
  late final TextEditingController _passwordController;

  bool _isConnecting = false;
  bool _isScanning = false;
  String? _statusLog;
  String? _errorLog;

  @override
  void initState() {
    super.initState();
    final PersistancesService persistances = getIt<PersistancesService>();
    // Prefill from persistances, or use original hardcoded broadcaster defaults
    _ipController = TextEditingController(text: persistances.ip ?? '192.168.0.140');
    _portController = TextEditingController(text: persistances.port ?? '4456');
    _passwordController = TextEditingController(text: persistances.password ?? 'password123A&');
  }

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleConnect() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isConnecting = true;
      _errorLog = null;
      _statusLog =
          '>> INITIALIZING WEBSOCKET PROTOCOL...\n>> CONNECTING TO ws://${_ipController.text}:${_portController.text}...';
    });

    try {
      await getIt<OBSService>().connect(
        ip: _ipController.text.trim(),
        port: _portController.text.trim(),
        password: _passwordController.text.isNotEmpty ? _passwordController.text : null,
      );

      if (mounted) {
        setState(() {
          _statusLog = '>> CONNECTION SUCCESSFUL.\n>> AUTHENTICATED WITH PROFILE.';
        });

        // Small delay to let the user see the connection success state before dismissing
        await Future<void>.delayed(const Duration(milliseconds: 600));

        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.successColor,
              content: Text(
                '🤖 OBS STATION CONFIGURED AND SECURED ONLINE',
                style: GoogleFonts.jetBrainsMono(
                  color: Colors.white,
                  fontWeight: .bold,
                  fontSize: 12,
                ),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isConnecting = false;
          _statusLog = null;
          _errorLog = '>> ERROR: CONNECTION FAILED\n>> REASON: ${e.toString().toUpperCase()}';
        });
      }
    }
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (!mounted) return;
    final String? result = barcodes.barcodes.firstOrNull?.displayValue;

    if (result != null && result.contains('obsws')) {
      final RegExp regExpIp = RegExp(r'\b(?:\d{1,3}\.){3}\d{1,3}\b');
      final RegExp regExpPort = RegExp(r':(\d+)');
      final RegExp regExpPW = RegExp(r'/([^/]+)$');

      final String ip = regExpIp.stringMatch(result) ?? '';
      final String port = regExpPort.firstMatch(result)?.group(1) ?? '';
      final String token = regExpPW.firstMatch(result)?.group(1) ?? '';

      setState(() {
        _ipController.text = ip;
        _portController.text = port;
        _passwordController.text = token;
        _isScanning = false;
        _errorLog = null;
        _statusLog = '>> CONFIGURATION IMPORTED VIA QR CODE';
      });

      // Automatically attempt OBS connection using scanned params
      _handleConnect();
    } else {
      setState(() {
        _errorLog = '>> ERROR: INVALID QR CODE FORMAT.\n>> MUST CONTAIN OBSWS ENCODED VALUES.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardOffset = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: EdgeInsets.only(bottom: keyboardOffset),
      child: Center(
        child: SingleChildScrollView(
          child: Dialog(
            backgroundColor: AppColors.cyberSurfaceContainerLow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDefaultValues.kBorderRadiusSecondary),
              side: const BorderSide(color: AppColors.cyberCyan, width: 1.5),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 450),
              padding: const EdgeInsets.all(24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _isScanning
                    ? ConnectToOBSScannerView(
                        onDetect: _handleBarcode,
                        onCancelPressed: () => setState(() {
                          _isScanning = false;
                          _errorLog = null;
                        }),
                        errorLog: _errorLog,
                      )
                    : ConnectToOBSFormView(
                        formKey: _formKey,
                        ipController: _ipController,
                        portController: _portController,
                        passwordController: _passwordController,
                        isConnecting: _isConnecting,
                        onConnectPressed: _handleConnect,
                        onCancelPressed: Navigator.of(context).pop,
                        onScanPressed: () => setState(() {
                          _isScanning = true;
                          _errorLog = null;
                        }),
                        statusLog: _statusLog,
                        errorLog: _errorLog,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
