import 'package:shared_preferences/shared_preferences.dart';

/// A robust data persistence service backed by SharedPreferences
/// that manages saving, loading, and clearing OBS server connection credentials.
class PersistancesService {
  const PersistancesService(this._prefs);

  static const String _keyIp = 'obs_ip';
  static const String _keyPort = 'obs_port';
  static const String _keyPassword = 'obs_password';

  final SharedPreferences _prefs;

  /// Retrieves the cached OBS IP address.
  String? get ip => _prefs.getString(_keyIp);

  /// Retrieves the cached OBS Port.
  String? get port => _prefs.getString(_keyPort);

  /// Retrieves the cached OBS Password.
  String? get password => _prefs.getString(_keyPassword);

  /// Determines whether connection credentials are currently saved.
  bool get hasCredentials => ip != null && port != null;

  /// Saves the connection parameters to persistent storage.
  Future<void> saveCredentials({
    required String ip,
    required String port,
    String? password,
  }) async {
    await _prefs.setString(_keyIp, ip);
    await _prefs.setString(_keyPort, port);
    if (password != null && password.isNotEmpty) {
      await _prefs.setString(_keyPassword, password);
    } else {
      await _prefs.remove(_keyPassword);
    }
  }

  /// Clears the stored credentials from persistent storage (e.g., when obsolete).
  Future<void> clearCredentials() async {
    await _prefs.remove(_keyIp);
    await _prefs.remove(_keyPort);
    await _prefs.remove(_keyPassword);
  }
}
