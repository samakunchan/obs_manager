import 'package:flutter/foundation.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/o_b_s_server/services/services.dart';
import 'package:obs_manager/features/persistances/persistances.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:obs_websocket/request.dart';
import 'package:signals_flutter/signals_flutter.dart';

class OBSSoundService {
  /// Reactive state signals for sound
  final Signal<bool> isSoundMuted = signal<bool>(false);
  final Signal<String> inputName = signal<String>('My microphone');
  final Signal<String> inputKind = signal<String>('My microphone');

  /// Detects the correct sound configuration input by checking the list of inputs in OBS.
  Future<void> detectSoundConfiguration() async {
    final ObsWebSocket? socket = getIt<OBSService>().socket;
    if (socket == null) return;

    try {
      final RequestResponse? response = await socket.send('GetInputList');
      if (response == null || response.responseData == null) return;

      final List<Map<String, dynamic>> json = (response.responseData!['inputs'] as List)
          .map((v) => v as Map<String, dynamic>)
          .toList();

      final List<Input> listInputs = json.map(Input.fromJson).toList();
      final String correctSoundName = listInputs
          .where((Input v) => v.inputKind == 'coreaudio_input_capture' || v.inputKind == 'wasapi_input_capture')
          .first
          .inputName;
      final String correctKindName = listInputs
          .where((Input v) => v.inputKind == 'coreaudio_input_capture' || v.inputKind == 'wasapi_input_capture')
          .first
          .inputKind;

      inputName.value = correctSoundName;
      inputKind.value = correctKindName;
    } catch (e) {
      if (kDebugMode) {
        print('Error detecting sound configuration: $e');
      }
      await getIt<PersistancesLogsService>().addLog(
        code: 'error',
        message: 'Error detecting sound configuration: $e',
      );
    }
  }

  /// Gets the current mute status of the active microphone in OBS.
  Future<void> getStatusSound() async {
    final socket = getIt<OBSService>().socket;
    if (socket == null) return;

    try {
      final Inputs inputs = socket.inputs;
      final bool isReallyMuted = await inputs.getMute(inputName.value);
      isSoundMuted.value = isReallyMuted;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting sound status: $e');
      }
      await getIt<PersistancesLogsService>().addLog(
        code: 'error',
        message: 'Error getting sound status: $e',
      );
      throw OBSSoundException(e.toString());
    }
  }

  /// Toggles the mute state of the active microphone in OBS.
  Future<void> toggleMuteSound() async {
    final ObsWebSocket? socket = getIt<OBSService>().socket;
    if (socket == null) return;

    try {
      final Inputs inputs = socket.inputs;
      await inputs.toggleMute(inputName: inputName.value);
      final bool isReallyMuted = await inputs.getMute(inputName.value);
      isSoundMuted.value = isReallyMuted;
      await getIt<PersistancesLogsService>().addLog(
        code: 'info',
        message: isReallyMuted ? 'Sound muted' : 'Sound activated',
      );
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error toggling sound mute state: $e');
      }
      await getIt<PersistancesLogsService>().addLog(
        code: 'error',
        message: 'Error toggling sound mute state: $e',
      );
      throw OBSSoundException(e.toString());
    }
  }

  /// Exposes the current mute state.
  bool get activeIsSoundMuted => isSoundMuted.value;

  /// Reacts to external input mute state change events.
  set activeIsSoundMuted(bool isMuted) {
    isSoundMuted.value = isMuted;
  }

  /// Resets the signals upon disconnect.
  void clearSound() {
    isSoundMuted.value = false;
    inputName.value = 'My microphone';
  }
}
