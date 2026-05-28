import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_server/o_b_s_server.dart';
import 'package:obs_manager/features/persistances/persistances.dart';
import 'package:obs_manager/widgets/widgets.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// Monitoring Bottom Action Panel displaying connection Metadata and live Event Logs inside the ShowcaseCard.
class MonitoringActionPanel extends StatefulWidget {
  const MonitoringActionPanel({required this.onClose, super.key});

  final VoidCallback onClose;

  @override
  State<MonitoringActionPanel> createState() => _MonitoringActionPanelState();
}

class _MonitoringActionPanelState extends State<MonitoringActionPanel> {
  final ScrollController _scrollController = ScrollController();
  late final void Function() _disposeLogsEffect;

  @override
  void initState() {
    super.initState();
    final PersistancesLogsService logsService = getIt<PersistancesLogsService>();

    // Set up reactive signal effect to auto-scroll when new logs are added
    _disposeLogsEffect = effect(() {
      // Access the signal to subscribe to its updates
      final _ = logsService.logs.value;

      // Auto-scroll terminal to bottom after next frame layout pass
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _disposeLogsEffect();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OBSService obsService = getIt<OBSService>();
    final PersistancesLogsService logsService = getIt<PersistancesLogsService>();

    return Watch((BuildContext context) {
      final bool isConnected = obsService.isConnected.value;
      final List<LogEntry> logs = logsService.logs.value;

      final List<Widget> logWidgets = logs.map((entry) {
        final String h = entry.time.hour.toString().padLeft(2, '0');
        final String m = entry.time.minute.toString().padLeft(2, '0');
        final String s = entry.time.second.toString().padLeft(2, '0');
        final timestamp = '[$h:$m:$s]';

        Color codeColor;
        switch (entry.code) {
          case 'error':
            codeColor = AppColors.cyberAlertRed;
          case 'warning':
            codeColor = AppColors.warningColor;
          case 'success':
            codeColor = AppColors.terminalText;
          case 'info':
          default:
            codeColor = AppColors.cyberSkyBlue;
        }

        return Text(
          '$timestamp [${entry.code.toUpperCase()}] ${entry.message}',
          style: kTerminalTextStyle.copyWith(color: codeColor),
        );
      }).toList();

      return BottomActionPanelWrapper(
        glowColor: Theme.of(context).colorScheme.tertiary,
        title: context.localization.systemLogsAndMetadata.toUpperCase(),
        onClose: widget.onClose,
        leadingHeader: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: .circle,
            color: isConnected ? Theme.of(context).colorScheme.secondary : AppColors.cyberTextMuted,
            boxShadow: [
              if (isConnected)
                BoxShadow(
                  color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.6),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
            ],
          ),
        ),
        trailingHeader: Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
            icon: const Icon(Icons.delete_sweep_outlined, size: 20),
            tooltip: context.localization.clearLogs,
            onPressed: logs.isEmpty
                ? null
                : () async {
                    await logsService.clearLogs();
                  },
          ),
        ),
        child: SizedBox(
          height: 200,
          child: Row(
            crossAxisAlignment: .stretch,
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == .dark ? AppColors.darkTerminalBg : AppColors.lightTerminalBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).brightness == .dark
                            ? AppColors.darkTerminalBorder
                            : AppColors.lightTerminalBorder,
                        width: 1.5,
                      ),
                    ),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Align(
                        alignment: .topLeft,
                        child: Column(
                          crossAxisAlignment: .start,
                          children: logWidgets.isEmpty
                              ? [
                                  Text(
                                    '>> ${context.localization.systemOnlineStandby.toUpperCase()}',
                                    style: kTerminalTextStyle.copyWith(color: AppColors.cyberTextMuted),
                                  ),
                                ]
                              : logWidgets,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
