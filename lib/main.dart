import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/l10n/app_localizations.dart';
import 'package:obs_manager/widgets/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OBS Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0A14),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // Default to system locale, or fallback to first supported
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null) {
          for (final supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        return supportedLocales.first;
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Locale? _forcedLocale;
  String _simulationLogs = 'System ready. Select a simulation below.';
  bool _isLoading = false;

  void _log(String message) {
    setState(() {
      _simulationLogs = '$message\n$_simulationLogs';
    });
  }

  void _changeLanguage(String languageCode) {
    setState(() {
      _forcedLocale = Locale(languageCode);
    });
    _log('Language changed to: ${languageCode.toUpperCase()}');
  }

  // Simulation handlers demonstrating client service mapping exception to failure
  Future<void> _simulateObsConnection() async {
    setState(() => _isLoading = true);
    _log('🔄 Initiating connection simulation to OBS WebSocket...');
    await Future<void>.delayed(const Duration(milliseconds: 800));

    // Demonstrate the use of failures mapped from WebSocket exceptions
    final failure = SocketFailure('Connection refused on 127.0.0.1:4455');
    _log('❌ Connection Failed: ${failure.message}');
    _log('🛡️ Mapped Domain Failure: $failure');
    setState(() => _isLoading = false);
  }

  Future<void> _simulateApiCall() async {
    setState(() => _isLoading = true);
    _log('🔄 Triggering secure API call via ApiService...');
    await Future<void>.delayed(const Duration(milliseconds: 800));

    // Demonstrate ExceptionModel mapping
    const exception = ExceptionModel(
      message: 'Unauthorized access token provided',
      exception: 'UnauthorizedException',
      statusCode: 401,
    );
    _log('❌ Server Error: [${exception.statusCode}] - ${exception.message}');
    _log('🛡️ Mapped ExceptionModel: $exception');
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    // Override the build context's localizations if a specific language is selected
    return Localizations.override(
      context: context,
      locale: _forcedLocale,
      child: Builder(
        builder: (context) {
          final l10n = context.localizations;
          final isRtl = Directionality.of(context) == TextDirection.rtl;

          return Scaffold(
            body: Stack(
              children: [
                // Premium Background Glow
                Positioned(
                  top: -200,
                  right: isRtl ? null : -200,
                  left: isRtl ? -200 : null,
                  child: Container(
                    width: 500,
                    height: 500,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x266366F1), // 15% opacity constant
                          blurRadius: 150,
                          spreadRadius: 50,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -150,
                  left: isRtl ? null : -150,
                  right: isRtl ? -150 : null,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x1EA855F7), // 12% opacity constant
                          blurRadius: 120,
                          spreadRadius: 40,
                        ),
                      ],
                    ),
                  ),
                ),

                // Main Content
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Header Widget
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.settings_input_component,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.mainTitle,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const Text(
                                      'Core Initialization Showcase',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Display current language tag
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E1E38),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFF3B3B6D),
                                ),
                              ),
                              child: Text(
                                Localizations.localeOf(context).languageCode.toUpperCase(),
                                style: const TextStyle(
                                  color: Color(0xFF818CF8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Language Selection Row
                        const Text(
                          'SELECT LANGUAGE (LOCALIZATION TEST)',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              LanguageButton(
                                code: 'en',
                                label: '🇺🇸 English',
                                isSelected: (_forcedLocale?.languageCode ?? Localizations.localeOf(context).languageCode) == 'en',
                                onSelected: (selected) => selected ? _changeLanguage('en') : null,
                              ),
                              LanguageButton(
                                code: 'fr',
                                label: '🇫🇷 Français',
                                isSelected: (_forcedLocale?.languageCode ?? Localizations.localeOf(context).languageCode) == 'fr',
                                onSelected: (selected) => selected ? _changeLanguage('fr') : null,
                              ),
                              LanguageButton(
                                code: 'es',
                                label: '🇪🇸 Español',
                                isSelected: (_forcedLocale?.languageCode ?? Localizations.localeOf(context).languageCode) == 'es',
                                onSelected: (selected) => selected ? _changeLanguage('es') : null,
                              ),
                              LanguageButton(
                                code: 'zh',
                                label: '🇨🇳 中文',
                                isSelected: (_forcedLocale?.languageCode ?? Localizations.localeOf(context).languageCode) == 'zh',
                                onSelected: (selected) => selected ? _changeLanguage('zh') : null,
                              ),
                              LanguageButton(
                                code: 'ar',
                                label: '🇸🇦 العربية',
                                isSelected: (_forcedLocale?.languageCode ?? Localizations.localeOf(context).languageCode) == 'ar',
                                onSelected: (selected) => selected ? _changeLanguage('ar') : null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Grid of components
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.5,
                            children: [
                              // Localized Keys list card
                              ShowcaseCard(
                                title: 'Active Translations',
                                icon: Icons.translate,
                                color: const Color(0xFF6366F1),
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    TextRow(value: l10n.settings, keyName: 'settings'),
                                    TextRow(value: l10n.connectToObs, keyName: 'connectToObs'),
                                    TextRow(value: l10n.startStream, keyName: 'startStream'),
                                    TextRow(value: l10n.stopStream, keyName: 'stopStream'),
                                    TextRow(value: l10n.scenes, keyName: 'scenes'),
                                    TextRow(value: l10n.sources, keyName: 'sources'),
                                  ],
                                ),
                              ),

                              // Mapped Localization Errors card
                              ShowcaseCard(
                                title: 'Mapped Errors & Alerts',
                                icon: Icons.warning_amber_rounded,
                                color: const Color(0xFFF59E0B),
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    TextRow(value: l10n.unknownError, keyName: 'unknownError'),
                                    TextRow(value: l10n.connectionRefused, keyName: 'connectionRefused'),
                                    TextRow(value: l10n.wifiRequired, keyName: 'wifiRequired'),
                                    TextRow(value: l10n.cacheEmpty, keyName: 'cacheEmpty'),
                                    TextRow(value: l10n.timeoutError, keyName: 'timeoutError'),
                                  ],
                                ),
                              ),

                              // ClientService simulation card
                              ShowcaseCard(
                                title: 'ClientService (OBS WebSocket)',
                                icon: Icons.swap_calls_rounded,
                                color: const Color(0xFF10B981),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Integrates functional exception-to-failure domain mapping using dartz Either boundaries.',
                                      style: TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF10B981),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: _isLoading ? null : _simulateObsConnection,
                                        icon: const Icon(Icons.play_arrow),
                                        label: const Text('Simulate OBS Failure'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // ApiService (Dio REST) simulation card
                              ShowcaseCard(
                                title: 'ApiService (Dio REST Client)',
                                icon: Icons.cloud_done_outlined,
                                color: const Color(0xFF3B82F6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'SOLID client managing generic HTTP requests, custom intercepts, and structured error responses.',
                                      style: TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF3B82F6),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: _isLoading ? null : _simulateApiCall,
                                        icon: const Icon(Icons.play_arrow),
                                        label: const Text('Simulate HTTP Error'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Simulation Logs terminal
                        const Text(
                          'SIMULATION LOGS & METADATA',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 120,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF09090F),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF232338),
                              width: 1.5,
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                _simulationLogs,
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  color: Color(0xFF34D399),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
