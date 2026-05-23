# CHANGELOG OBS MANAGER

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
