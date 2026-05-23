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
}
