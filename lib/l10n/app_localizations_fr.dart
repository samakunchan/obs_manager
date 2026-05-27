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

  @override
  String get audio => 'Audio';

  @override
  String get monitoring => 'Surveillance';

  @override
  String get isStarting => 'Démarrage en cours';

  @override
  String get isStopping => 'Arrêt en cours';

  @override
  String get quickAudioControl => 'Contrôle Audio Rapide';

  @override
  String get obsOffline => 'OBS Hors ligne';

  @override
  String get muted => 'Muet';

  @override
  String get recordingDecibelsLive => 'Enregistrement des décibels en direct';

  @override
  String get connectToActiveObsServer => 'Connecter à un serveur OBS actif';

  @override
  String get scenesDirectory => 'Répertoire des scènes';

  @override
  String get chooseVisibleMainScenes => 'Choisir les scènes principales visibles';

  @override
  String selected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count SÉLECTIONNÉS',
      one: '1 SÉLECTIONNÉ',
    );
    return '$_temp0';
  }

  @override
  String get noScenesDetected => 'Aucune scène détectée dans OBS';

  @override
  String get connectToObsToListScenes => 'Se connecter à OBS pour lister les scènes';

  @override
  String get systemLogsAndMetadata => 'Journaux Système';

  @override
  String get clearLogs => 'Effacer les journaux';

  @override
  String get systemOnlineStandby => 'Système en ligne. En attente.';

  @override
  String get cacheClear => 'Vider le cache';

  @override
  String get systemPurgeRequest => 'Demande de Purge Système';

  @override
  String get purgeWarningText =>
      'ATTENTION : Cette opération effacera définitivement tous les registres de la base de données locale, les identifiants mis en cache et l\'historique des journaux système.\n\nVous serez déconnecté de la station. Êtes-vous sûr de vouloir continuer ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get purge => 'Purger';

  @override
  String get cachePurgedSuccess => 'Cache entièrement vidé et déconnecté proprement';

  @override
  String get closeConsole => 'Fermer la Console';

  @override
  String get connect => 'Se connecter';

  @override
  String get disconnect => 'Se déconnecter';

  @override
  String get connectionConsole => 'Console de connexion';

  @override
  String get obsWebsocketV5Configuration => 'Configuration OBS WebSocket v5';

  @override
  String get obsWebSocketIp => 'I.P. de l\'OBS WebSocket';

  @override
  String get ipRequired => 'L\'adresse IP est requise';

  @override
  String get obsWebSocketPort => 'Port de l\'OBS WebSocket';

  @override
  String get portRequired => 'Le port est requis';

  @override
  String get obsAuthenticationKey => 'Mot de passe';

  @override
  String get obsPassword => 'Mot de passe OBS';

  @override
  String get orConnectViaQrCode => 'Ou se connecter via Code QR';

  @override
  String get scanQr => 'Scanner QR';

  @override
  String get obsStationConfiguredSuccess => 'Station OBS configurée et sécurisée en ligne';

  @override
  String get qrCodeScanner => 'Scanner de Code QR';

  @override
  String get alignObsConsoleQrCode => 'Aligner le Code QR de la console OBS';

  @override
  String get enterManually => 'Saisir Manuellement';

  @override
  String get panelControl => 'Panneau de Contrôle';

  @override
  String get onAir => 'En Direct';

  @override
  String get recStandby => 'Enr : En attente';

  @override
  String presetsLoaded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count PRÉRÉGLAGES CHARGÉS',
      one: '1 PRÉRÉGLAGE CHARGÉ',
    );
    return '$_temp0';
  }

  @override
  String get noSourcesDetected => 'Aucune source détectée';

  @override
  String get sourcesOffline => 'Sources Hors ligne';

  @override
  String get connectObsToLoadInputs => 'Connectez-vous au serveur OBS pour charger les entrées de scène actives.';

  @override
  String get obsDisconnected => 'OBS Déconnecté';

  @override
  String get sceneCommandCenterOffline =>
      'Le gestionnaire de scènes est hors ligne. Veuillez initialiser votre connexion à l\'aide de la console de contrôle de la station dans la barre latérale.';

  @override
  String get openControlConsole => 'Ouvrir la connexion';

  @override
  String get coreInitializationShowcase => 'Vitrine d\'initialisation de base';

  @override
  String get selectLanguage => 'Sélectionner la langue (Test de localisation)';

  @override
  String get activeTranslations => 'Traductions actives';

  @override
  String get mappedErrorsAlerts => 'Erreurs & Alertes mappées';

  @override
  String get clientServiceTitle => 'Service Client (OBS WebSocket)';

  @override
  String get clientServiceDescription =>
      'Intègre un mappage de domaine exception-vers-échec fonctionnel utilisant les limites Either de dartz.';

  @override
  String get simulateObsFailure => 'Simuler un échec OBS';

  @override
  String get apiServiceTitle => 'Service API (Client REST Dio)';

  @override
  String get apiServiceDescription =>
      'Client SOLID gérant les requêtes HTTP génériques, les interceptions personnalisées et les réponses d\'erreur structurées.';

  @override
  String get simulateHttpError => 'Simuler une erreur HTTP';

  @override
  String get simulationLogsMetadata => 'Journaux de Simulation & Métadonnées';

  @override
  String get systemOffline => 'SYSTÈME HORS LIGNE';

  @override
  String get noWifiMessage =>
      'Une connexion réseau Wi-Fi locale est requise pour communiquer avec OBS Studio via le WebSocket local.\n\nVeuillez vérifier les paramètres de votre système et vous connecter au Wi-Fi.';

  @override
  String get scanningSystem => 'ANALYSE DU SYSTÈME...';

  @override
  String get rescanConnection => 'RESCANNER LA CONNEXION';

  @override
  String get linkRestoration => 'RESTAURATION DU LIEN';

  @override
  String get reconnectingMessage =>
      'Connexion réseau Wi-Fi détectée.\n\nRétablissement des liaisons WebSocket locales sécurisées et synchronisation des scènes avec OBS Studio...';
}
