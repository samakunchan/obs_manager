# CHANGELOG OBS MANAGER

## 🚀 0.7.0 - 25/05/2026

### Added
- Created `PersistancesService` to securely persist OBS IP, Port, and Password using `shared_preferences`.
- Created `PersistancesLogsService` to record connection successes, failures, clean disconnections, and obsolete credential clears reactively with a cap of 100 entries.
- Created `PersistancesScenesService` to securely persist scene visibility selections across app re-launches.
- Created `ConnectToOBSDialog` featuring a cyberpunk terminal aesthetic and a mobile camera scanner using the `mobile_scanner` package.
- Integrated a clear logs `delete_sweep_outlined` icon button in `MonitoringActionPanel` utilizing the new `trailingHeader` parameter in `BottomActionPanelWrapper`.

### Changed
- Refactored `OBSService` to support `autoConnectOnStartup()` triggered on app startup, with automatic obsolete credentials clearing on handshake failure.
- Refactored `MonitoringActionPanel` to reactively render persistent logs using GetIt, Signals (`Watch`), and a single background layout scroll-to-end `effect`.
- Refactored `TactileCommandPage` scenes mapping to load and persist custom layouts, including a dynamic overlap fallback validation to prevent empty scene grids on different OBS servers.
- Decoupled scene lay-out filtering from credential persistence following the Single Responsibility Principle.

### Fixed
- Fixed and re-ordered `LogEntry` constructor declarations to adhere strictly to the `sort_constructors_first` rule.
- Fixed `TactileCommandPage` visibility set clears using the cascade operator `..` to comply with the strict `cascade_invocations` rule.

## 🚀 0.6.0 - 24/05/2026

### Added
- Created `BottomActionPanelWrapper`: a highly reusable glassmorphic overlay widget that standardizes entrance/exit animations (`SizeTransition` and `FadeTransition` with `easeOutCubic` curve), glow border styles, and neon shadows.
- Created `AudioActionPanel`: a re-engineered audio controller that delegates its structure, animations, and transitions directly to `BottomActionPanelWrapper`, keeping simulated VU decibel meter bars, mute toggles, and volume control sliders intact.
- Created `MonitoringActionPanel`: a split-column telemetry and live diagnostics panel displaying connection metadata (OBS socket address, active scene name, audio capture source name, live/muted status, stream status) and a scrolling monospaced terminal logs interface styled exactly like the terminal in `my_home_page.dart`.
- Created `ScenesActionPanel`: a compact tactile directory list grid displaying all OBS scenes with checkbox-based visibilities, letting users customize exactly which scene pads are visible on the main tactile command screen.

### Changed
- Refactored `bottom_action_bar.dart` and `tactile_command_page.dart` to support three-way exclusive toggling across Scenes, Audio, and Monitoring action panels.
- Configured dynamic scenes grid filtering inside `ObsTactileCommandPage` using the checked visibility set, including a safety fallback enforcing at least one scene to remain visible.
- Re-designed `ScenesActionPanel` so that tapping anywhere on the scene tile (the whole area) reactively toggles its checkbox visibility state, and stripped all OBS scene-changing callbacks from this view.

### Fixed
- Fixed an active scene highlight borders alignment bug (`isActive` index mismatch) by re-ordering the list filtering sequence to compute `activeSceneIndex` strictly on the filtered list.
- Resolved and cleaned up unused helper method declarations, redundant properties (avoid `avoid_redundant_argument_values`), and double literal constraints to maintain a 100% clean `flutter analyze` score.

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
