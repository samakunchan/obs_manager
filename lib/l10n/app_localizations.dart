import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ar'), Locale('en'), Locale('es'), Locale('fr'), Locale('zh')];

  /// Title of the application
  ///
  /// In en, this message translates to:
  /// **'OBS Manager'**
  String get mainTitle;

  /// Settings label
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Button to connect to OBS server
  ///
  /// In en, this message translates to:
  /// **'Connect to OBS'**
  String get connectToObs;

  /// Button to start streaming
  ///
  /// In en, this message translates to:
  /// **'Start Stream'**
  String get startStream;

  /// Button to stop streaming
  ///
  /// In en, this message translates to:
  /// **'Stop Stream'**
  String get stopStream;

  /// Scenes list title
  ///
  /// In en, this message translates to:
  /// **'Scenes'**
  String get scenes;

  /// Sources list title
  ///
  /// In en, this message translates to:
  /// **'Sources'**
  String get sources;

  /// Fallback error message
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred'**
  String get unknownError;

  /// Error message when connection is refused
  ///
  /// In en, this message translates to:
  /// **'Connection refused by the OBS server'**
  String get connectionRefused;

  /// Error message when Wi-Fi is disabled
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi connection is required'**
  String get wifiRequired;

  /// Error message when local cache is empty
  ///
  /// In en, this message translates to:
  /// **'No cached connection settings found'**
  String get cacheEmpty;

  /// Error message when request times out
  ///
  /// In en, this message translates to:
  /// **'Connection timed out'**
  String get timeoutError;

  /// Audio label
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get audio;

  /// Monitoring label
  ///
  /// In en, this message translates to:
  /// **'Monitoring'**
  String get monitoring;

  /// Stream is starting status
  ///
  /// In en, this message translates to:
  /// **'Is Starting'**
  String get isStarting;

  /// Stream is stopping status
  ///
  /// In en, this message translates to:
  /// **'Is Stopping'**
  String get isStopping;

  /// Quick audio control panel title
  ///
  /// In en, this message translates to:
  /// **'Quick Audio Control'**
  String get quickAudioControl;

  /// OBS offline status label
  ///
  /// In en, this message translates to:
  /// **'OBS Offline'**
  String get obsOffline;

  /// Muted audio status label
  ///
  /// In en, this message translates to:
  /// **'Muted'**
  String get muted;

  /// Toggle microphone status label
  ///
  /// In en, this message translates to:
  /// **'Toggle the microphone in live'**
  String get recordingDecibelsLive;

  /// Connect prompt description
  ///
  /// In en, this message translates to:
  /// **'Connect to active OBS server'**
  String get connectToActiveObsServer;

  /// Scenes directory panel title
  ///
  /// In en, this message translates to:
  /// **'Scenes Directory'**
  String get scenesDirectory;

  /// Hint to choose visible scenes
  ///
  /// In en, this message translates to:
  /// **'Choose Visible Main Scenes'**
  String get chooseVisibleMainScenes;

  /// Selected state indicator
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 SELECTED} other{{count} SELECTED}}'**
  String selected(int count);

  /// Placeholder when no scenes are found
  ///
  /// In en, this message translates to:
  /// **'No scenes detected in OBS'**
  String get noScenesDetected;

  /// Placeholder prompt when OBS disconnected in scenes
  ///
  /// In en, this message translates to:
  /// **'Connect to OBS to list scenes'**
  String get connectToObsToListScenes;

  /// System logs panel title
  ///
  /// In en, this message translates to:
  /// **'System Logs'**
  String get systemLogsAndMetadata;

  /// Tooltip to clear system logs
  ///
  /// In en, this message translates to:
  /// **'Clear Logs'**
  String get clearLogs;

  /// Default terminal online system message
  ///
  /// In en, this message translates to:
  /// **'System online. Standby.'**
  String get systemOnlineStandby;

  /// Drawer option to clear cache
  ///
  /// In en, this message translates to:
  /// **'Cache clear'**
  String get cacheClear;

  /// Title of the cache clear warning dialog
  ///
  /// In en, this message translates to:
  /// **'System Purge Request'**
  String get systemPurgeRequest;

  /// Warning text shown in the purge dialog
  ///
  /// In en, this message translates to:
  /// **'WARNING: This operation will permanently wipe all local database registries, cached credentials, and system log history.\n\nYou will be logged out of the station. Are you sure you want to proceed?'**
  String get purgeWarningText;

  /// Generic cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Purge action button text
  ///
  /// In en, this message translates to:
  /// **'Purge'**
  String get purge;

  /// Snackbar success message after clearing cache
  ///
  /// In en, this message translates to:
  /// **'Cache fully purged and logged out cleanly'**
  String get cachePurgedSuccess;

  /// Drawer close button text
  ///
  /// In en, this message translates to:
  /// **'Close Console'**
  String get closeConsole;

  /// OBS connect action button text
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connect;

  /// OBS disconnect action button text
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get disconnect;

  /// OBS connection dialog title
  ///
  /// In en, this message translates to:
  /// **'Connection Console'**
  String get connectionConsole;

  /// OBS connection dialog subtitle
  ///
  /// In en, this message translates to:
  /// **'OBS WebSocket v5 Configuration'**
  String get obsWebsocketV5Configuration;

  /// Input field label for IP address
  ///
  /// In en, this message translates to:
  /// **'OBS WebSocket I.P.'**
  String get obsWebSocketIp;

  /// Validation error for IP address field
  ///
  /// In en, this message translates to:
  /// **'IP address is required'**
  String get ipRequired;

  /// Input field label for port
  ///
  /// In en, this message translates to:
  /// **'OBS WebSocket Port'**
  String get obsWebSocketPort;

  /// Validation error for port field
  ///
  /// In en, this message translates to:
  /// **'Port is required'**
  String get portRequired;

  /// Input field label for password
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get obsAuthenticationKey;

  /// Input field hint for password
  ///
  /// In en, this message translates to:
  /// **'OBS Password'**
  String get obsPassword;

  /// Divider text for QR connection alternative
  ///
  /// In en, this message translates to:
  /// **'Or Connect Via QR Code'**
  String get orConnectViaQrCode;

  /// Scan QR button text
  ///
  /// In en, this message translates to:
  /// **'Scan QR'**
  String get scanQr;

  /// Snackbar success message after connection
  ///
  /// In en, this message translates to:
  /// **'OBS Station configured and secured online'**
  String get obsStationConfiguredSuccess;

  /// Scanner dialog title
  ///
  /// In en, this message translates to:
  /// **'QR Code Scanner'**
  String get qrCodeScanner;

  /// Scanner instruction subtitle
  ///
  /// In en, this message translates to:
  /// **'Align OBS Console QR Code'**
  String get alignObsConsoleQrCode;

  /// Cancel scanning button text
  ///
  /// In en, this message translates to:
  /// **'Enter Manually'**
  String get enterManually;

  /// Main screen control bar title
  ///
  /// In en, this message translates to:
  /// **'Panel Control'**
  String get panelControl;

  /// Streaming live status badge label
  ///
  /// In en, this message translates to:
  /// **'On Air'**
  String get onAir;

  /// Streaming standby status badge label
  ///
  /// In en, this message translates to:
  /// **'REC: Standby'**
  String get recStandby;

  /// Count of presets loaded in scenes header
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 PRESET LOADED} other{{count} PRESETS LOADED}}'**
  String presetsLoaded(int count);

  /// Placeholder when no sources are detected in connected OBS
  ///
  /// In en, this message translates to:
  /// **'No sources detected'**
  String get noSourcesDetected;

  /// Placeholder header when sources are offline
  ///
  /// In en, this message translates to:
  /// **'Sources Offline'**
  String get sourcesOffline;

  /// Placeholder hint when sources are offline
  ///
  /// In en, this message translates to:
  /// **'Connect to the OBS server to load active scene inputs.'**
  String get connectObsToLoadInputs;

  /// Placeholder header when scenes are offline
  ///
  /// In en, this message translates to:
  /// **'OBS Disconnected'**
  String get obsDisconnected;

  /// Placeholder description when scenes are offline
  ///
  /// In en, this message translates to:
  /// **'Scene manager is offline. Please initialize your connection using the Station Control Console in the sidebar.'**
  String get sceneCommandCenterOffline;

  /// Action button in offline scenes placeholder
  ///
  /// In en, this message translates to:
  /// **'Open Connection'**
  String get openControlConsole;

  /// MyHomePage showcase subtitle
  ///
  /// In en, this message translates to:
  /// **'Core Initialization Showcase'**
  String get coreInitializationShowcase;

  /// Language selector header in MyHomePage
  ///
  /// In en, this message translates to:
  /// **'Select Language (Localization Test)'**
  String get selectLanguage;

  /// Showcase card title for active translations
  ///
  /// In en, this message translates to:
  /// **'Active Translations'**
  String get activeTranslations;

  /// Showcase card title for errors & alerts
  ///
  /// In en, this message translates to:
  /// **'Mapped Errors & Alerts'**
  String get mappedErrorsAlerts;

  /// Showcase card title for client service
  ///
  /// In en, this message translates to:
  /// **'ClientService (OBS WebSocket)'**
  String get clientServiceTitle;

  /// Showcase card description for client service
  ///
  /// In en, this message translates to:
  /// **'Integrates functional exception-to-failure domain mapping using dartz Either boundaries.'**
  String get clientServiceDescription;

  /// Showcase button to simulate failure
  ///
  /// In en, this message translates to:
  /// **'Simulate OBS Failure'**
  String get simulateObsFailure;

  /// Showcase card title for API service
  ///
  /// In en, this message translates to:
  /// **'ApiService (Dio REST Client)'**
  String get apiServiceTitle;

  /// Showcase card description for API service
  ///
  /// In en, this message translates to:
  /// **'SOLID client managing generic HTTP requests, custom intercepts, and structured error responses.'**
  String get apiServiceDescription;

  /// Showcase button to simulate HTTP error
  ///
  /// In en, this message translates to:
  /// **'Simulate HTTP Error'**
  String get simulateHttpError;

  /// Showcase header for simulation logs
  ///
  /// In en, this message translates to:
  /// **'Simulation Logs & Metadata'**
  String get simulationLogsMetadata;

  /// System offline warning status label
  ///
  /// In en, this message translates to:
  /// **'SYSTEM OFFLINE'**
  String get systemOffline;

  /// Detailed warning message when WiFi is disconnected
  ///
  /// In en, this message translates to:
  /// **'A local WiFi network connection is required to communicate with the OBS Broadcaster Studio over local WebSocket.\n\nPlease check your system settings and connect to WiFi.'**
  String get noWifiMessage;

  /// Connection status during a network retry scan
  ///
  /// In en, this message translates to:
  /// **'SCANNING SYSTEM...'**
  String get scanningSystem;

  /// Retry scan button label
  ///
  /// In en, this message translates to:
  /// **'RESCAN CONNECTION'**
  String get rescanConnection;

  /// Cyber reconnection screen header
  ///
  /// In en, this message translates to:
  /// **'LINK RESTORATION'**
  String get linkRestoration;

  /// Reconnection progress descriptive details message
  ///
  /// In en, this message translates to:
  /// **'WiFi network connection detected.\n\nRe-establishing secure local WebSocket links and synchronizing scene pipelines with OBS Studio...'**
  String get reconnectingMessage;

  /// Label for the theme mode selector in the drawer
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// Light theme mode option label
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// Dark theme mode option label
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// System theme mode option label
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'es', 'fr', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
