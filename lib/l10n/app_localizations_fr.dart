// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get mainTitle => 'Gestionnaire OBS';

  @override
  String get settings => 'Paramètres';

  @override
  String get connectToObs => 'Se connecter à OBS';

  @override
  String get startStream => 'Démarrer le Stream';

  @override
  String get stopStream => 'Arrêter le Stream';

  @override
  String get scenes => 'Scènes';

  @override
  String get sources => 'Sources';

  @override
  String get unknownError => 'Une erreur inconnue est survenue';

  @override
  String get connectionRefused => 'Connexion refusée par le serveur OBS';

  @override
  String get wifiRequired => 'Une connexion Wi-Fi est requise';

  @override
  String get cacheEmpty => 'Aucun paramètre de connexion enregistré trouvé';

  @override
  String get timeoutError => 'Délai de connexion dépassé';
}
