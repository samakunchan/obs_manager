import 'package:flutter/material.dart';
import 'package:obs_manager/core/index.dart';
import 'package:obs_manager/widgets/widgets.dart';

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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.darkGlowPrimary
                              : AppColors.lightGlowPrimary,
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.darkGlowAccent
                              : AppColors.lightGlowAccent,
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
                              spacing: 14,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [AppColors.primary, AppColors.accent],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.settings_input_component,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.mainTitle,
                                      style: Theme.of(context).textTheme.headlineMedium,
                                    ),
                                    Text(
                                      context.localization.coreInitializationShowcase,
                                      style: Theme.of(context).textTheme.bodySmall,
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
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.darkChipBg
                                    : AppColors.lightChipBg,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? AppColors.darkChipBorder
                                      : AppColors.lightChipBorder,
                                ),
                              ),
                              child: Text(
                                Localizations.localeOf(context).languageCode.toUpperCase(),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.lightIndigo,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Language Selection Row
                        Text(
                          context.localization.selectLanguage.toUpperCase(),
                          style: Theme.of(context).textTheme.labelMedium,
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
                                title: context.localization.activeTranslations,
                                icon: Icons.translate,
                                color: AppColors.primary,
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
                                title: context.localization.mappedErrorsAlerts,
                                icon: Icons.warning_amber_rounded,
                                color: AppColors.warningColor,
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
                                title: context.localization.clientServiceTitle,
                                icon: Icons.swap_calls_rounded,
                                color: AppColors.primary,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.localization.clientServiceDescription,
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        style: kElevatedButtonDarkSuccess,
                                        onPressed: _isLoading ? null : _simulateObsConnection,
                                        icon: const Icon(Icons.play_arrow),
                                        label: Text(context.localization.simulateObsFailure),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // ApiService (Dio REST) simulation card
                              ShowcaseCard(
                                title: context.localization.apiServiceTitle,
                                icon: Icons.cloud_done_outlined,
                                color: AppColors.infoColor,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.localization.apiServiceDescription,
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        onPressed: _isLoading ? null : _simulateApiCall,
                                        icon: const Icon(Icons.play_arrow),
                                        label: Text(context.localization.simulateHttpError),
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
                        Text(
                          context.localization.simulationLogsMetadata.toUpperCase(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 120,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkTerminalBg
                                : AppColors.lightTerminalBg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.darkTerminalBorder
                                  : AppColors.lightTerminalBorder,
                              width: 1.5,
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(_simulationLogs, style: kTerminalTextStyle),
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
