import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';

class CTACentralBroadcastMobile extends StatelessWidget {
  const CTACentralBroadcastMobile({
    required this.streamStatusMessage,
    required this.onToggleStream,
    required this.streamStatus,
    super.key,
  });
  final StatusStream streamStatus;
  final VoidCallback onToggleStream;
  final String streamStatusMessage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: streamStatus == StatusStream.started || streamStatus == StatusStream.isStopping
                ? AppColors.cyberAlertRed
                : AppColors.cyberSkyBlue.withValues(alpha: 0.8),
            foregroundColor: Colors.black,
            shadowColor: streamStatus == StatusStream.started || streamStatus == StatusStream.isStopping
                ? AppColors.cyberAlertRed
                : AppColors.cyberCyan,
            elevation: 8,
          ),
          onPressed: onToggleStream,
          child: Row(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.rocket_launch, size: 20),
                ),
              ),
              Expanded(
                flex: MediaQuery.of(context).orientation == .portrait ? 2 : 4,
                child: Text(
                  streamStatusMessage,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.cyberSurface),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
