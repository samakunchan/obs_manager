# CHANGELOG OBS MANAGER

## 🚀 0.5.0 - 24/05/2026

### Added
- Created the new `o_b_s_sound` feature module to support microphone state detection and management reactively with Signals + GetIt.
- Built a high-fidelity, interactive `OBSToggleSoundButton` displaying microphone volume and mute states with glowing neon background, custom borders, and seamless scale micro-animations.
- Integrated a premium **Audio Control** dashboard in `AudioMixPanel` displaying current microphone name (synchronized from OBS) and glowing, color-coded live/muted status states.
- Implemented real-time event-driven synchronization for sound mute states using the OBS WebSocket `InputMuteStateChanged` event fallback handler inside `OBSService`.

### Changed
- Refactored UI layouts (`DesktopLayout` and `MobileLayout`) to consume the new `AudioMixPanel` with zero parameters.
- Purged all simulated, non-poolable DB levels, VU timers, and math packages from `tactile_command_page.dart` to optimize CPU efficiency and keep code maintainable.
- Standardized `const` constructors on layout pages to maximize drawing and rendering performance.

### Fixed
- Fixed and cleaned up all unused imports, trailing comma placements, and linter constraints to achieve a 100% clean `flutter analyze` build.

## 🚀 0.4.0 - 24/05/2026

### Added
- Created new feature module `lib/features/app_lifecycle/` to manage app-lifecycle aware states and WiFi network connectivity fallback screens.
- Implemented reactive WiFi tracking utilizing the `connectivity_plus` package inside `AppLifecycleService`.
- Built custom full-screen cyberpunk `NoWifiScreen` warning page with pulsing red icon warning signals and a manual "RESCAN CONNECTION" button.
- Built a beautiful cyber-style `ReconnectingScreen` loading spinner showing status animations during automatic reconnect sequences.
- Developed `AppLifecycleGate` widget wrapping `Watch` which blocks the command interface reactively on WiFi loss, transitions to a loading screen on reconnection, and displays the main dashboard on success.

### Changed
- Updated `AppLifecycleService` to automatically trigger `obsService.logout()` to tear down websocket sessions on WiFi loss and automatically trigger `obsService.reconnect()` on restored WiFi connection.
- Integrated `WidgetsFlutterBinding.ensureInitialized()` and `AppLifecycleService` bootstrap initialization in `main.dart`, wrapping the home root tactile command center with `AppLifecycleGate`.

### Fixed
- Resolved all double literal parameters and typed warnings to achieve 100% clean `flutter analyze`.

## 🚀 0.3.0 - 24/05/2026

### Added
- Created `o_b_s_scenes` feature module with `OBSScenesService` to reactively hold and switch active OBS program scenes.
- Created `o_b_s_sources` feature module with `OBSSourcesService` to query, sync, and toggle source (scene item) enablement and visibility.
- Created custom premium cyberpunk offline widgets `OfflineScenesPlaceholder` and `OfflineSourcesPlaceholder` to handle disconnected states elegantly.
- Integrated `StatusStream` enum signal inside `OBSService` to reactively track Starting, Started, Stopping, and Stopped streaming states.
- Integrated `WakelockPlus` to dynamically enable wakelocks during active streams (`StatusStream.started`) and disable them when stopped (`StatusStream.stopped`).
- Created stateless layout widgets `DesktopLayout` and `MobileLayout` in separate files under `lib/pages/main_page/` to confined widget rebuild scopes.

### Changed
- Refactored `tactile_command_page.dart` and `sources_panel.dart` to consume scenes and sources services, providing real-time, event-driven synchronization with the OBS WebSocket.
- Standardized dependency injection registrations in `dependency_injection.dart` using cascade operator chains.

### Fixed
- Fixed and resolved all linter warnings (`avoid_void_async`, `noop_primitive_operations`, `directives_ordering`, `avoid_setters_without_getters`, `always_use_package_imports`) achieving a 100% clean flutter analysis score.

## 🚀 0.2.0 - 23/05/2026

### Added
- Created standalone, modularized cyber-themed widgets under `lib/widgets/`:
  - `TactileScenePad` with dynamic 45° chamfered clippers/painters.
  - `PreviewMonitor` network visual feed overlay.
  - `AudioMixPanel` with simulated decibel VU levels meter rows.
  - `SourcesPanel` listing current capture devices and inputs.
  - `StationDrawer` terminal sliding navigation drawer.
  - `MissionControlAppBar` custom streaming and record status ticker header.
  - `BottomActionBar` bottom controller CTAs and navigation buttons.
  - `CyberBackgroundGlows` decorative layered background neon glow filters.
  - `ScenesHeader` with dynamic preset loaded counts.
  - `ScenesGrid` responsive grid matching layout form factors.
- Added `AppUtils.highlightColor` inside `lib/core/utils/utils.dart` to centralize visual highlight states.
- Introduced `AppTextTheme` for global specialized typography assets.
- Integrated `cyberHighlight` into design constants and custom outlined buttons themes.

### Changed
- Refactored `lib/pages/tactile_command_page.dart` to consume modular widgets, reducing the file footprint and improving readability.
- Re-architected drawer layouts and navigation bars to use modern Flutter flex row/column `spacing` properties instead of verbose explicit gap paddings.
- Standardized text selection areas, gesture detections, and scroll behaviors inside drawers and command pads.
- Updated `lib/widgets/widgets.dart` alphabetical export registry.

### Fixed
- Fixed and cleaned up all static analysis rules, strict types, double/integer literals, and import sorting errors to achieve a 100% clean build.

## 🚀 0.1.0 - 22/05/2026

### Added
- Created brand new Flutter project structure for `obs_manager` to replace `obs_for_sama` step by step.
- Added standard expert utility packages: `signals_flutter`, `get_it`, `dartz`, `dio`, `shared_preferences`, `package_info_plus`, `device_info_plus`, and `flutter_dotenv`.
- Added business specific packages: `obs_websocket`, `mobile_scanner`, `wakelock_plus`, `sizer`, `connectivity_plus`, `bitsdojo_window`, and `device_preview` for complete compatibility.
- Configured strict, premium linters and code formatting standards (`very_good_analysis` guidelines).

### Changed
- N/A

### Fixed
- N/A
