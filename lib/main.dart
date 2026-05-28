import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/features/app_lifecycle/app_lifecycle.dart';
import 'package:obs_manager/features/o_b_s_server/services/dependency_injection.dart';
import 'package:obs_manager/features/o_b_s_server/services/o_b_s_service.dart';
import 'package:obs_manager/l10n/app_localizations.dart';
import 'package:obs_manager/pages/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals_flutter/signals_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Disable signals logs.
  SignalsObserver.instance = null;

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  setupLocator(prefs);
  getIt<AppLifecycleService>().init();
  // Auto-connect to OBS on startup using persisted credentials if available
  await getIt<OBSService>().autoConnectOnStartup();

  if (kIsWeb) {
    runApp(
      DevicePreview(
        enabled: kIsWeb,
        builder: (BuildContext context) => const MyApp(),
      ),
    );
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: kIsWeb ? DevicePreview.locale(context) : null,
      builder: kIsWeb ? DevicePreview.appBuilder : null,
      title: 'OBS Manager',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: .system,
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
      home: Builder(
        builder: (BuildContext context) {
          return ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: const SafeArea(
              child: AppLifecycleGate(
                child: MainPage(),
              ),
            ),
          );
        },
      ),
    );
  }
}
