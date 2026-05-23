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
}
