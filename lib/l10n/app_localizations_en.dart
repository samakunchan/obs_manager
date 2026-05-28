// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get mainTitle => 'OBS Manager';

  @override
  String get settings => 'Settings';

  @override
  String get connectToObs => 'Connect to OBS';

  @override
  String get startStream => 'Start Stream';

  @override
  String get stopStream => 'Stop Stream';

  @override
  String get scenes => 'Scenes';

  @override
  String get sources => 'Sources';

  @override
  String get unknownError => 'An unknown error occurred';

  @override
  String get connectionRefused => 'Connection refused by the OBS server';

  @override
  String get wifiRequired => 'Wi-Fi connection is required';

  @override
  String get cacheEmpty => 'No cached connection settings found';

  @override
  String get timeoutError => 'Connection timed out';

  @override
  String get audio => 'Audio';

  @override
  String get monitoring => 'Monitoring';

  @override
  String get isStarting => 'Is Starting';

  @override
  String get isStopping => 'Is Stopping';

  @override
  String get quickAudioControl => 'Quick Audio Control';

  @override
  String get obsOffline => 'OBS Offline';

  @override
  String get muted => 'Muted';

  @override
  String get recordingDecibelsLive => 'Toggle the microphone in live';

  @override
  String get connectToActiveObsServer => 'Connect to active OBS server';

  @override
  String get scenesDirectory => 'Scenes Directory';

  @override
  String get chooseVisibleMainScenes => 'Choose Visible Main Scenes';

  @override
  String selected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count SELECTED',
      one: '1 SELECTED',
    );
    return '$_temp0';
  }

  @override
  String get noScenesDetected => 'No scenes detected in OBS';

  @override
  String get connectToObsToListScenes => 'Connect to OBS to list scenes';

  @override
  String get systemLogsAndMetadata => 'System Logs';

  @override
  String get clearLogs => 'Clear Logs';

  @override
  String get systemOnlineStandby => 'System online. Standby.';

  @override
  String get cacheClear => 'Cache clear';

  @override
  String get systemPurgeRequest => 'System Purge Request';

  @override
  String get purgeWarningText =>
      'WARNING: This operation will permanently wipe all local database registries, cached credentials, and system log history.\n\nYou will be logged out of the station. Are you sure you want to proceed?';

  @override
  String get cancel => 'Cancel';

  @override
  String get purge => 'Purge';

  @override
  String get cachePurgedSuccess => 'Cache fully purged and logged out cleanly';

  @override
  String get closeConsole => 'Close Console';

  @override
  String get connect => 'Connect';

  @override
  String get disconnect => 'Disconnect';

  @override
  String get connectionConsole => 'Connection Console';

  @override
  String get obsWebsocketV5Configuration => 'OBS WebSocket v5 Configuration';

  @override
  String get obsWebSocketIp => 'OBS WebSocket I.P.';

  @override
  String get ipRequired => 'IP address is required';

  @override
  String get obsWebSocketPort => 'OBS WebSocket Port';

  @override
  String get portRequired => 'Port is required';

  @override
  String get obsAuthenticationKey => 'Password';

  @override
  String get obsPassword => 'OBS Password';

  @override
  String get orConnectViaQrCode => 'Or Connect Via QR Code';

  @override
  String get scanQr => 'Scan QR';

  @override
  String get obsStationConfiguredSuccess => 'OBS Station configured and secured online';

  @override
  String get qrCodeScanner => 'QR Code Scanner';

  @override
  String get alignObsConsoleQrCode => 'Align OBS Console QR Code';

  @override
  String get enterManually => 'Enter Manually';

  @override
  String get panelControl => 'Panel Control';

  @override
  String get onAir => 'On Air';

  @override
  String get recStandby => 'REC: Standby';

  @override
  String presetsLoaded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count PRESETS LOADED',
      one: '1 PRESET LOADED',
      zero: '0 PRESETS LOADED',
    );
    return '$_temp0';
  }

  @override
  String get noSourcesDetected => 'No sources detected';

  @override
  String get sourcesOffline => 'Sources Offline';

  @override
  String get connectObsToLoadInputs => 'Connect to the OBS server to load active scene inputs.';

  @override
  String get obsDisconnected => 'OBS Disconnected';

  @override
  String get sceneCommandCenterOffline =>
      'Scene manager is offline. Please initialize your connection using the Station Control Console in the sidebar.';

  @override
  String get openControlConsole => 'Open Connection';

  @override
  String get coreInitializationShowcase => 'Core Initialization Showcase';

  @override
  String get selectLanguage => 'Select Language (Localization Test)';

  @override
  String get activeTranslations => 'Active Translations';

  @override
  String get mappedErrorsAlerts => 'Mapped Errors & Alerts';

  @override
  String get clientServiceTitle => 'ClientService (OBS WebSocket)';

  @override
  String get clientServiceDescription =>
      'Integrates functional exception-to-failure domain mapping using dartz Either boundaries.';

  @override
  String get simulateObsFailure => 'Simulate OBS Failure';

  @override
  String get apiServiceTitle => 'ApiService (Dio REST Client)';

  @override
  String get apiServiceDescription =>
      'SOLID client managing generic HTTP requests, custom intercepts, and structured error responses.';

  @override
  String get simulateHttpError => 'Simulate HTTP Error';

  @override
  String get simulationLogsMetadata => 'Simulation Logs & Metadata';

  @override
  String get systemOffline => 'SYSTEM OFFLINE';

  @override
  String get noWifiMessage =>
      'A local WiFi network connection is required to communicate with the OBS Broadcaster Studio over local WebSocket.\n\nPlease check your system settings and connect to WiFi.';

  @override
  String get scanningSystem => 'SCANNING SYSTEM...';

  @override
  String get rescanConnection => 'RESCAN CONNECTION';

  @override
  String get linkRestoration => 'LINK RESTORATION';

  @override
  String get reconnectingMessage =>
      'WiFi network connection detected.\n\nRe-establishing secure local WebSocket links and synchronizing scene pipelines with OBS Studio...';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';
}
