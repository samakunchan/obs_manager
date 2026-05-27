import 'package:shared_preferences/shared_preferences.dart';

/// A robust data persistence service backed by SharedPreferences
/// that manages saving, loading, and clearing visible OBS scene selections.
class PersistancesScenesService {
  const PersistancesScenesService(this._prefs);

  final SharedPreferences _prefs;

  static const String _keyVisibleScenes = 'obs_visible_scenes';

  /// Retrieves the list of visible scenes.
  List<String>? get visibleScenes => _prefs.getStringList(_keyVisibleScenes);

  /// Saves the list of visible scenes to persistent storage.
  Future<void> saveVisibleScenes(List<String> scenes) async {
    await _prefs.setStringList(_keyVisibleScenes, scenes);
  }

  /// Wipes the list of visible scenes from persistent storage.
  Future<void> clearVisibleScenes() async {
    await _prefs.remove(_keyVisibleScenes);
  }

  /// Wipes all data managed by this service from persistent storage.
  Future<void> clear() async {
    await clearVisibleScenes();
  }
}
