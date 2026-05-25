import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// Representation of a single structured log entry in the system.
class LogEntry {
  const LogEntry({
    required this.time,
    required this.code,
    required this.message,
  });

  factory LogEntry.fromJson(Map<String, dynamic> json) => LogEntry(
    time: DateTime.parse(json['time'] as String),
    code: json['code'] as String,
    message: json['message'] as String,
  );

  final DateTime time;
  final String code; // 'error', 'warning', 'success', 'info'
  final String message;

  Map<String, dynamic> toJson() => {
    'time': time.toIso8601String(),
    'code': code,
    'message': message,
  };
}

/// A robust data persistence logging service backed by SharedPreferences
/// that publishes live events reactively utilizing Signals.
class PersistancesLogsService {
  PersistancesLogsService(this._prefs) {
    _loadLogs();
  }

  static const String _keyLogs = 'obs_system_logs';
  final SharedPreferences _prefs;

  /// Reactive signal holding the current log history
  final Signal<List<LogEntry>> logs = signal<List<LogEntry>>([]);

  void _loadLogs() {
    try {
      final List<String>? jsonList = _prefs.getStringList(_keyLogs);
      if (jsonList != null) {
        logs.value = jsonList.map((str) {
          final map = json.decode(str) as Map<String, dynamic>;
          return LogEntry.fromJson(map);
        }).toList();
      }
    } catch (_) {
      logs.value = [];
    }
  }

  /// Appends a new structured log and commits it to persistent storage.
  Future<void> addLog({
    required String code,
    required String message,
  }) async {
    final entry = LogEntry(
      time: DateTime.now(),
      code: code,
      message: message,
    );

    // Reactive update
    final currentList = List<LogEntry>.from(logs.value)..add(entry);

    // Limit logging history to 100 records to optimize memory/storage sizes
    if (currentList.length > 100) {
      currentList.removeAt(0);
    }
    logs.value = currentList;

    // Persist to SharedPreferences
    try {
      final List<String> jsonList = currentList.map((e) => json.encode(e.toJson())).toList();
      await _prefs.setStringList(_keyLogs, jsonList);
    } catch (_) {}
  }

  /// Wipes all logged operations from storage and memory.
  Future<void> clearLogs() async {
    logs.value = [];
    await _prefs.remove(_keyLogs);
  }
}
