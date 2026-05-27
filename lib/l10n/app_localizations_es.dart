// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get mainTitle => 'Administrador de OBS';

  @override
  String get settings => 'Ajustes';

  @override
  String get connectToObs => 'Conectar a OBS';

  @override
  String get startStream => 'Iniciar Transmisión';

  @override
  String get stopStream => 'Detener Transmisión';

  @override
  String get scenes => 'Escenas';

  @override
  String get sources => 'Fuentes';

  @override
  String get unknownError => 'Ocurrió un error desconocido';

  @override
  String get connectionRefused => 'Conexión rechazada por el servidor OBS';

  @override
  String get wifiRequired => 'Se requiere conexión Wi-Fi';

  @override
  String get cacheEmpty => 'No se encontraron configuraciones de conexión guardadas';

  @override
  String get timeoutError => 'Tiempo de espera de conexión agotado';

  @override
  String get audio => 'Audio';

  @override
  String get monitoring => 'Monitoreo';

  @override
  String get isStarting => 'Iniciando';

  @override
  String get isStopping => 'Deteniendo';

  @override
  String get quickAudioControl => 'Control de Audio Rápido';

  @override
  String get obsOffline => 'OBS Fuera de Línea';

  @override
  String get muted => 'Silenciado';

  @override
  String get recordingDecibelsLive => 'Grabando decibelios en vivo';

  @override
  String get connectToActiveObsServer => 'Conectarse al servidor OBS activo';

  @override
  String get scenesDirectory => 'Directorio de Escenas';

  @override
  String get chooseVisibleMainScenes => 'Elegir Escenas Principales Visibles';

  @override
  String selected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count SELECCIONADOS',
      one: '1 SELECCIONADO',
    );
    return '$_temp0';
  }

  @override
  String get noScenesDetected => 'No se detectaron escenas en OBS';

  @override
  String get connectToObsToListScenes => 'Conectar a OBS para listar escenas';

  @override
  String get systemLogsAndMetadata => 'Registros del Sistema';

  @override
  String get clearLogs => 'Limpiar Registros';

  @override
  String get systemOnlineStandby => 'Sistema en línea. En espera.';

  @override
  String get cacheClear => 'Borrar caché';

  @override
  String get systemPurgeRequest => 'Solicitud de Purga del Sistema';

  @override
  String get purgeWarningText =>
      'ADVERTENCIA: Esta operación borrará permanentemente todos los registros de la base de datos local, las credenciales almacenadas en caché y el historial de registros del sistema.\n\nSe cerrará su sesión en la estación. ¿Está seguro de que desea continuar?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get purge => 'Purgar';

  @override
  String get cachePurgedSuccess => 'Caché completamente purgada y sesión cerrada limpiamente';

  @override
  String get closeConsole => 'Cerrar Consola';

  @override
  String get connect => 'Conectar';

  @override
  String get disconnect => 'Desconectar';

  @override
  String get connectionConsole => 'Consola de Conexión';

  @override
  String get obsWebsocketV5Configuration => 'Configuración de OBS WebSocket v5';

  @override
  String get obsWebSocketIp => 'I.P. de OBS WebSocket';

  @override
  String get ipRequired => 'Se requiere la dirección IP';

  @override
  String get obsWebSocketPort => 'Puerto de OBS WebSocket';

  @override
  String get portRequired => 'Se requiere el puerto';

  @override
  String get obsAuthenticationKey => 'Contraseña';

  @override
  String get obsPassword => 'Contraseña OBS';

  @override
  String get orConnectViaQrCode => 'O Conectar mediante Código QR';

  @override
  String get scanQr => 'Escanear QR';

  @override
  String get obsStationConfiguredSuccess => 'Estación OBS configurada y asegurada en línea';

  @override
  String get qrCodeScanner => 'Escáner de Código QR';

  @override
  String get alignObsConsoleQrCode => 'Alinear Código QR de la Consola OBS';

  @override
  String get enterManually => 'Ingresar Manualmente';

  @override
  String get panelControl => 'Panel de Control';

  @override
  String get onAir => 'En Vivo';

  @override
  String get recStandby => 'Grabando: En espera';

  @override
  String presetsLoaded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count PREAJUSTES CARGADOS',
      one: '1 PREAJUSTE CARGADO',
    );
    return '$_temp0';
  }

  @override
  String get noSourcesDetected => 'Ninguna fuente detectada';

  @override
  String get sourcesOffline => 'Fuentes Fuera de Línea';

  @override
  String get connectObsToLoadInputs => 'Conéctese al servidor OBS para cargar las entradas de escena activas.';

  @override
  String get obsDisconnected => 'OBS Desconectado';

  @override
  String get sceneCommandCenterOffline =>
      'El gestor de escenas está fuera de línea. Inicialice su conexión utilizando la Consola de Control de Estaciones en la barra lateral.';

  @override
  String get openControlConsole => 'Abrir Conexión';

  @override
  String get coreInitializationShowcase => 'Vitrina de Inicialización del Núcleo';

  @override
  String get selectLanguage => 'Seleccionar Idioma (Prueba de Localización)';

  @override
  String get activeTranslations => 'Traducciones Activas';

  @override
  String get mappedErrorsAlerts => 'Errores y Alertas Mapeados';

  @override
  String get clientServiceTitle => 'Servicio Cliente (OBS WebSocket)';

  @override
  String get clientServiceDescription =>
      'Integra mapeo funcional de dominio de excepción a falla usando límites Either de dartz.';

  @override
  String get simulateObsFailure => 'Simular Falla de OBS';

  @override
  String get apiServiceTitle => 'Servicio API (Cliente REST Dio)';

  @override
  String get apiServiceDescription =>
      'Cliente SOLID que gestiona solicitudes HTTP genéricas, intercepciones personalizadas y respuestas de error estructuradas.';

  @override
  String get simulateHttpError => 'Simular Error HTTP';

  @override
  String get simulationLogsMetadata => 'Registros de Simulación y Metadatos';

  @override
  String get systemOffline => 'SISTEMA FUERA DE LÍNEA';

  @override
  String get noWifiMessage =>
      'Se requiere una conexión de red WiFi local para comunicarse con el OBS Broadcaster Studio a través del WebSocket local.\n\nPor favor, verifique los ajustes de su sistema y conéctese a la red WiFi.';

  @override
  String get scanningSystem => 'ESCANEANDO SISTEMA...';

  @override
  String get rescanConnection => 'REESCANEAR CONEXIÓN';

  @override
  String get linkRestoration => 'RESTAURACIÓN DEL ENLACE';

  @override
  String get reconnectingMessage =>
      'Conexión de red WiFi detectada.\n\nReestableciendo enlaces locales seguros de WebSocket y sincronizando los canales de escenas con OBS Studio...';
}
