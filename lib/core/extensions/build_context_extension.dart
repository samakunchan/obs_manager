import 'package:flutter/widgets.dart';
import 'package:obs_manager/l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  /// Convenient accessor for standard [AppLocalizations] instance
  AppLocalizations get localizations => AppLocalizations.of(this)!;

  /// Fallback alias for convenience (e.g. context.localization.title)
  AppLocalizations get localization => AppLocalizations.of(this)!;
}
