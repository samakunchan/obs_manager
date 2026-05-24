import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/app_lifecycle/app_lifecycle.dart';
import 'package:obs_manager/features/o_b_s_server/services/dependency_injection.dart';
import 'package:obs_manager/l10n/app_localizations.dart';
import 'package:obs_manager/pages/pages.dart';
import 'package:signals_flutter/signals_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// Disable signals logs.
  SignalsObserver.instance = null;

  setupLocator();
  getIt<AppLifecycleService>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OBS Manager',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: .dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // Default to system locale, or fallback to first supported
      localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) {
        if (locale != null) {
          for (final Locale supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        return supportedLocales.first;
      },
      home: const SafeArea(
        child: AppLifecycleGate(
          child: ObsTactileCommandPage(),
        ),
      ),
    );
  }
}

const aaa = [
  {"inputKind": "coreaudio_input_capture", "inputName": "Mic/Aux", "unversionedInputKind": "coreaudio_input_capture"},
  {"inputKind": "text_ft2_source_v2", "inputName": "Je reviens", "unversionedInputKind": "text_ft2_source"},
  {"inputKind": "macos-avcapture", "inputName": "Ma Webcam", "unversionedInputKind": "macos-avcapture"},
  {"inputKind": "browser_source", "inputName": "Alerte Twich", "unversionedInputKind": "browser_source"},
  {"inputKind": "screen_capture", "inputName": "Android Studio", "unversionedInputKind": "screen_capture"},
  {"inputKind": "screen_capture", "inputName": "OPMacos", "unversionedInputKind": "screen_capture"},
  {"inputKind": "screen_capture", "inputName": "Capture d'écran macOS", "unversionedInputKind": "screen_capture"},
  {"inputKind": "ffmpeg_source", "inputName": "Canva twitch video accueil", "unversionedInputKind": "ffmpeg_source"},
  {"inputKind": "ffmpeg_source", "inputName": "Canva twitch video fin", "unversionedInputKind": "ffmpeg_source"},
];
